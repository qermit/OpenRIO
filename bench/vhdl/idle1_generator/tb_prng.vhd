----------------------------------------------------------------------------------
-- Company: 
-- Engineer: Piotr Miedzik, qermit@sezamkowa.net
-- 
-- Create Date: 05/17/2015 10:55:38 AM
-- Design Name:
-- Module Name: tb_prng - Behavioral
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


LIBRARY ieee;
USE ieee.std_logic_1164.ALL;
 
-- Uncomment the following library declaration if using
-- arithmetic functions with Signed or Unsigned values
--USE ieee.numeric_std.ALL;
 
ENTITY tb_prng IS
END tb_prng;
 
ARCHITECTURE behavior OF tb_prng IS 
 
    -- Component Declaration for the Unit Under Test (UUT)
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

COMPONENT prng7_dual    
    PORT(
        clk      : in  STD_LOGIC;
        rst      : in  STD_LOGIC;
        -- Pseudo random number
        lfsr_o     : out STD_LOGIC_VECTOR(6 downto 0);
        Q_high     : out std_logic_vector(4 downto 0);
        Q_low      : out std_logic_vector(4 downto 0);
        prb_o      : out std_logic_vector(1 downto 0)
    );
END COMPONENT;
    

   --Inputs
   signal clk_x1 : std_logic := '0';
   signal clk_x2 : std_logic := '0';
   signal rst : std_logic := '0';

   signal prb_dual    : std_logic_vector(1 downto 0);
   signal prb_single  : std_logic_vector(0 downto 0);
   signal lfsr_dual   : std_logic_vector(6 downto 0);
   signal lfsr_single : std_logic_vector(6 downto 0);
   
   signal Q_low       : std_logic_vector(4 downto 0);
   signal Q_high      : std_logic_vector(4 downto 0);
   signal Q           : std_logic_vector(4 downto 0);
      
   -- Clock period definitions
   constant clk_i_period : time := 10 ns;
 
BEGIN
 
	-- Instantiate the Unit Under Test (UUT)
   uut_signle: prng7_single
   PORT MAP(
       clk     => clk_x2,
       rst   => rst,
       lfsr_o  => lfsr_single,
       Q_low => Q,
       prb_o => prb_single
   );




   uut_dual: prng7_dual 
       PORT MAP(
           clk     => clk_x1,
           rst   => rst,
           lfsr_o  => lfsr_dual,
           Q_high => Q_high,
           Q_low => Q_low,
           prb_o => prb_dual
       );
       
   -- Clock process definitions
   clk_x1_process :process
   begin
		clk_x1 <= '1';
		wait for clk_i_period/2;
		clk_x1 <= '0';
		wait for clk_i_period/2;
   end process;
   clk_x2_process :process
   begin
		clk_x2 <= '1';
		wait for clk_i_period/4;
		clk_x2 <= '0';
		wait for clk_i_period/4;
   end process;
 

   -- Stimulus process
   stim_proc: process
   begin		
      rst <= '1';
      -- hold reset state for 100 ns.
      wait for 27 ns;	
      rst <= '0';
      wait;
   end process;


END;
