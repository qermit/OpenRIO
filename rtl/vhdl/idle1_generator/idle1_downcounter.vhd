----------------------------------------------------------------------------------
-- Company: 
-- Engineer: Piotr Miedzik, qermit@sezamkowa.net
-- 
-- Create Date: 05/17/2015 11:51:42 AM
-- Design Name: 
-- Module Name: idle1_downcounter - Behavioral
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

entity idle1_downcounter is
generic ( dec_step : natural := 1 );
    Port ( clk : in STD_LOGIC;
           load_0 : in STD_LOGIC;
           load_1 : in STD_LOGIC;
           value_0 : in STD_LOGIC_VECTOR (4 downto 0);
           value_1 : in STD_LOGIC_VECTOR (4 downto 0);
           Q : out STD_LOGIC_VECTOR (4 downto 0);
           Q_eq0 : out STD_LOGIC;
           Q_eq1 : out STD_LOGIC);
end idle1_downcounter;

architecture Behavioral of idle1_downcounter is

signal s_counter: std_logic_vector(4 downto 0);

begin

process(clk)
begin
if rising_edge(clk) then
if load_0 = '1' then
  s_counter <= value_0;
elsif load_1 = '1' then
  s_counter <= value_1;
else
  -- @todo parametryzacja 1, 2, 4
  s_counter <= std_logic_vector(unsigned(s_counter) - dec_step);
end if;
end if;
end process;

Q_eq0 <= '1' when s_counter = "00000" else '0';
Q_eq1 <= '1' when s_counter = "00001" else '0';
Q <= s_counter;


end Behavioral;
