----------------------------------------------------------------------------------
-- Company: 
-- Engineer: Piotr Miedzik, qermit@sezamkowa.net
-- 
-- Create Date: 05/17/2015 10:55:38 AM
-- Design Name:
-- Module Name: tb_idle1_downcounter - Behavioral
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

entity tb_idle1_downcounter is
--  Port ( );
end tb_idle1_downcounter;

architecture Behavioral of tb_idle1_downcounter is

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

signal load_value_0: std_logic_vector(4 downto 0) := "10000";
signal load_value_1: std_logic_vector(4 downto 0) := "10001";
signal load_0 : std_logic := '0';
signal load_1 : std_logic := '0';
signal clk: std_logic:= '0';

signal rst :std_logic:= '0';
signal Acntr_eq_zero      : std_logic;
signal Acntr_eq_one       : std_logic;

signal down_counter_low: std_logic_vector(4 downto 0);
constant clk_i_period : time := 10 ns;


begin

clk_process: process
begin
    clk <= '0';
    wait for clk_i_period/2;
    clk <= '1';
    wait for clk_i_period/2;
end process;

downcounter_one: idle1_downcounter
    Generic map (dec_step => 2)
    Port map ( clk => clk,
           load_0 => load_0,
           load_1 => load_1,
           value_0 => load_value_0,
           value_1 => load_value_1,
           Q => down_counter_low,
           Q_eq0 => Acntr_eq_zero,
           Q_eq1 => Acntr_eq_one);

load_0 <= rst or Acntr_eq_one;
load_1 <= Acntr_eq_zero;
-- Stimulus process
stim_proc: process
begin
  rst <= '1';
  wait for 15 ns;
  rst <= '0';
  wait;
end process;

end Behavioral;
