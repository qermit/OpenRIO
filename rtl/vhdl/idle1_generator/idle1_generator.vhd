----------------------------------------------------------------------------------
-- Company: 
-- Engineer: Piotr Miedzik, qermit@sezamkowa.net
-- 
-- Create Date: 05/17/2015 10:55:38 AM
-- Design Name:
-- Module Name: idle1_generator_single - Behavioral
-- Project Name: RapidIO IP Library Core 
-- Target Devices: 
-- Tool Versions: 
-- Description: 
-- 
-- Dependencies: 
-- 
-- Revision:
-- Revision 0.01 - File Created
-- Additional Comments:
-- 
----------------------------------------------------------------------------------


library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

entity idle1_generator_single is
  generic (
            lfsr_init   : std_logic_vector(7 downto 0) := x"01";
            TCQ         : time      := 100 ps
  );
  port ( 
    clk                : in  std_logic;
    rst                : in  std_logic;
    
    send_idle           : in  std_logic_vector(0 downto 0);
    
    send_K              : out std_logic_vector(0 downto 0);
    send_A              : out std_logic_vector(0 downto 0);
    send_R              : out std_logic_vector(0 downto 0)
  );
end idle1_generator_single;

architecture RTL of idle1_generator_single is
-------------------------------------------------------------------------------------------------------------------------------------------

signal send_idle_high           : std_logic;
signal send_idle_low           : std_logic;

signal q_pseudo_random_number  : std_logic_vector(6 downto 0) := (others => '0');


signal s_prb                    :std_logic_vector(0 downto 0);
signal prb_high                : std_logic                    := '0';
signal prb_low                 : std_logic                    := '0';
signal Q_high                  : std_logic_vector(4 downto 0) := (others => '0');
signal Q_high_dec              : std_logic_vector(4 downto 0) := (others => '0');
signal Q_low                   : std_logic_vector(4 downto 0) := (others => '0');
signal Q_low_dec               : std_logic_vector(4 downto 0) := (others => '0');

signal down_counter_high       : std_logic_vector(4 downto 0) := (others => '0');
signal down_counter_low        : std_logic_vector(4 downto 0) := (others => '0');
signal Acntr_eq_zero_high      : std_logic                    := '0';
signal Acntr_eq_zero_low       : std_logic                    := '0';
signal Acntr_eq_one_high       : std_logic                    := '0';
signal Acntr_eq_one_low        : std_logic                    := '0';
signal send_idle_dlyd_high     : std_logic                    := '0';
signal send_idle_dlyd_low      : std_logic                    := '0';


signal load_0_low :std_logic;
signal load_1_low :std_logic;
signal load_0_high :std_logic;
signal load_1_high :std_logic;

-- 

COMPONENT prng7_single    
PORT(
            clk      : in  STD_LOGIC;
rst      : in  STD_LOGIC;
-- Pseudo random number
lfsr_o     : out STD_LOGIC_VECTOR(6 downto 0);
Q_low      : out std_logic_vector(4 downto 0);
prb_o      : out std_logic_vector(0 downto 0)
	);
END COMPONENT;

COMPONENT idle1_decode_KAR
    Port ( send_idle : in STD_LOGIC;
           send_idle_dlyd : in STD_LOGIC;
           Acnt_eq_zero : in STD_LOGIC;
           prb : in STD_LOGIC;
           send_K : out STD_LOGIC;
           send_A : out STD_LOGIC;
           send_R : out STD_LOGIC);
end COMPONENT;

COMPONENT idle1_downcounter
    generic ( dec_step : natural := 1 );
    Port ( clk : in STD_LOGIC;
           load_0 : in STD_LOGIC;
           load_1 : in STD_LOGIC;
           value_0 : in STD_LOGIC_VECTOR (4 downto 0);
           value_1 : in STD_LOGIC_VECTOR (4 downto 0);
           Q : out STD_LOGIC_VECTOR (4 downto 0);
           Q_eq0 : out STD_LOGIC;
           Q_eq1 : out STD_LOGIC);
end COMPONENT;
-------------------------------------------------------------------------------------------------------------------------------------------
begin

send_idle_low <= send_idle(0);
prb_low <= s_prb(0);

inst_prng: prng7_single 
    PORT MAP(
        clk     => clk,
		rst   => rst,
		lfsr_o  => q_pseudo_random_number,
		Q_low => Q_low,
		prb_o => s_prb
	);


downcounter_low: idle1_downcounter
    Generic map (dec_step => 1)
    Port map ( clk => clk,
           load_0 => load_0_low,
           load_1 => load_1_low,
           value_0 => Q_low,
           value_1 => (others => '0'),
           Q => down_counter_low,
           Q_eq0 => Acntr_eq_zero_low,
           Q_eq1 => Acntr_eq_one_low);

load_0_low <= rst or Acntr_eq_zero_low;
load_1_low <= '0';

-- send_idle_dlyd_low delay process
process(clk)
    begin    
    if rising_edge(clk) then    
        send_idle_dlyd_low     <= send_idle_low;
    end if;
end process;




decode_KAR_low: idle1_decode_KAR
    Port MAP( send_idle => send_idle_low,
           send_idle_dlyd => send_idle_dlyd_low,
           Acnt_eq_zero => Acntr_eq_zero_low,
           prb => prb_low,
           send_K => send_K(0),
           send_A => send_A(0),
           send_R => send_R(0));

end RTL;
-------------------------------------------------------------------------------------------------------------------------------------------
