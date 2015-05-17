----------------------------------------------------------------------------------
-- Company: 
-- Engineer: Piotr Miedzik, qermit@sezamkowa.net
-- 
-- Create Date: 05/17/2015 10:55:38 AM
-- Design Name:
-- Module Name: tb_idle1_decode_KAR - Behavioral
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


library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

-- Uncomment the following library declaration if using
-- arithmetic functions with Signed or Unsigned values
use IEEE.NUMERIC_STD.ALL;

-- Uncomment the following library declaration if instantiating
-- any Xilinx leaf cells in this code.
--library UNISIM;
--use UNISIM.VComponents.all;

entity tb_idle1_decode_KAR is
--  Port ( );
end tb_idle1_decode_KAR;

architecture Behavioral of tb_idle1_decode_KAR is
   constant clk_i_period : time := 10 ns;

COMPONENT idle1_decode_KAR
    Port ( send_idle : in STD_LOGIC;
           send_idle_dlyd : in STD_LOGIC;
           Acnt_eq_zero : in STD_LOGIC;
           prb : in STD_LOGIC;
           send_K : out STD_LOGIC;
           send_A : out STD_LOGIC;
           send_R : out STD_LOGIC);
end COMPONENT;

signal send_idle :std_logic := '0';
signal send_idle_dlyd:std_logic := '0';
signal Acnt_eq_zero: std_logic := '0';
signal prb: std_logic := '0';
signal send_K: std_logic;
signal send_A: std_logic;
signal send_R: std_logic;

signal s_test_vector: std_logic_vector(3 downto 0):= "0000";
signal clk: std_logic := '0';

begin

clk_process: process
begin
    clk <= '0';
    wait for clk_i_period/2;
    clk <= '1';
    wait for clk_i_period/2;
end process;

counter_process: process(clk)
begin
if rising_edge(clk) then
  s_test_vector <= std_logic_vector(unsigned(s_test_vector) + 1);
end if;
end process;

send_idle <= s_test_vector(3);
send_idle_dlyd <= s_test_vector(2);
Acnt_eq_zero <= s_test_vector(1);
prb <= s_test_vector(0);




decode_KAR_low: idle1_decode_KAR
    Port MAP( send_idle => send_idle,
           send_idle_dlyd => send_idle_dlyd,
           Acnt_eq_zero => Acnt_eq_zero,
           prb => prb,
           send_K => send_K,
           send_A => send_A,
           send_R => send_R);
           
           
-- Stimulus process
stim_proc: process
begin		
  wait;
end process;

end Behavioral;
