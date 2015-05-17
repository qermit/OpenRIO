----------------------------------------------------------------------------------
-- Company: 
-- Engineer: Piotr Miedzik, qermit@sezamkowa.net
-- 
-- Create Date: 05/17/2015 10:55:38 AM
-- Design Name:
-- Module Name: prng7_dual - Behavioral
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
use IEEE.NUMERIC_STD.ALL;

entity prng7_single is
    Port    ( 
            clk      : in  STD_LOGIC;
rst      : in  STD_LOGIC;
-- Pseudo random number
lfsr_o     : out STD_LOGIC_VECTOR(6 downto 0);
Q_low      : out std_logic_vector(4 downto 0);
prb_o      : out std_logic_vector(0 downto 0)
           );
end prng7_single;

architecture Behavioral of prng7_single is
  constant lfsr_init: std_logic_vector(6 downto 0) := b"1111111";
  signal lfsr   : std_logic_vector(6 downto 0)     := b"0000001"; 
begin 

lfsr_o <= lfsr;

-- Polynomial: x^7 + x^6 + 1
process (clk) begin 
  if rising_edge(clk) then
    if rst = '1' then 
      lfsr <= lfsr_init; -- x"01"; --(others => '0');
      prb_o <= lfsr_init(6 downto 6);
    else
      prb_o <= lfsr(6 downto 6);
      lfsr(6) <= lfsr(5);
      lfsr(5) <= lfsr(4);
      lfsr(4) <= lfsr(3);
      lfsr(3) <= lfsr(2);
      lfsr(2) <= lfsr(1);
      lfsr(1) <= lfsr(0);
      lfsr(0) <= lfsr(6) xor lfsr(5);
    end if;    
  end if; 
end process;

Q_low  <= '1' & lfsr(5) & lfsr(3) & lfsr(2) & lfsr(0);
     
end Behavioral;

