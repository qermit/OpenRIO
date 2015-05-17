----------------------------------------------------------------------------------
-- Company: 
-- Engineer: Piotr Miedzik, qermit@sezamkowa.net
-- 
-- Create Date: 05/17/2015 10:55:38 AM
-- Design Name:
-- Module Name: idle1_decode_KAR - Behavioral
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
--use IEEE.NUMERIC_STD.ALL;

-- Uncomment the following library declaration if instantiating
-- any Xilinx leaf cells in this code.
--library UNISIM;
--use UNISIM.VComponents.all;

entity idle1_decode_KAR is
    Port ( send_idle : in STD_LOGIC;
           send_idle_dlyd : in STD_LOGIC;
           Acnt_eq_zero : in STD_LOGIC;
           prb : in STD_LOGIC;
           send_K : out STD_LOGIC;
           send_A : out STD_LOGIC;
           send_R : out STD_LOGIC);
end idle1_decode_KAR;

architecture Behavioral of idle1_decode_KAR is

begin

send_K <= send_idle and (not(send_idle_dlyd) or (send_idle_dlyd and prb and not(Acnt_eq_zero))); 
send_A <= send_idle and send_idle_dlyd and Acnt_eq_zero; 
send_R <= send_idle and send_idle_dlyd and not(Acnt_eq_zero) and not(prb); 

end Behavioral;
