----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date: 03.04.2023 21:34:28
-- Design Name: 
-- Module Name: top_tb - Behavioral
-- Project Name: 
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

entity top_tb is
--  Port ( );
end top_tb;

ARCHITECTURE behavior OF top_tb IS 
 
    -- Component Declaration for the Unit Under Test (UUT)
 
    COMPONENT top
    PORT(
         led7_an_o : OUT  std_logic_vector(3 downto 0);
         led7_seg_o : OUT  std_logic_vector(7 downto 0);
         sw_i : IN  std_logic_vector(7 downto 0);
         btn_i : IN  std_logic_vector(3 downto 0);
         clk_i : IN  std_logic
        );
    END COMPONENT;
    

   --Inputs
   signal sw_i : std_logic_vector(7 downto 0) := (others => '0') ;
   signal btn_i : std_logic_vector(3 downto 0) := (others => '0');
   signal clk_i : std_logic := '0';

 	--Outputs
   signal led7_an_o : std_logic_vector(3 downto 0);
   signal led7_seg_o : std_logic_vector(7 downto 0);

   -- Clock period definitions
   constant clk_i_period : time := 20 ns;
	
	--Kopia z TOP u?atwia prac? z reszt? kodu
	alias swDig: std_logic_vector (3 downto 0) is sw_i (3 downto 0);--switche definiuj?ce cyfr? do wpisania

 
BEGIN
 
	-- Instantiate the Unit Under Test (UUT)
   uut: top PORT MAP (
          led7_an_o => led7_an_o,
          led7_seg_o => led7_seg_o,
          sw_i => sw_i,
          btn_i => btn_i,
          clk_i => clk_i
        );

   -- Clock process definitions
   clk_i_process :process
   begin
		clk_i <= '0';
		wait for clk_i_period/2;
		clk_i <= '1';
		wait for clk_i_period/2;
   end process;
 

   -- Stimulus process
   stim_proc: process
   begin		
      -- hold reset state for 100 ns.
      wait for 100 ns;


		sw_i(4) <= '1'; ---Zapal dp0
		wait for 200 ns; 
		sw_i(5) <= '1';
		wait for 200 ns; 
		sw_i(6) <= '1';
		wait for 200 ns; 
		sw_i(7) <= '1';
		wait for 200 ns; 

		sw_i(4) <= '0';
		sw_i(5) <= '0';
		sw_i(6) <= '0';
		sw_i(7) <= '0';--Zgaszenie wszystkich kropek

		wait for 200 ns; 
		
		swDig <= "0001"; --jedynka na skrajny prawy
		wait for 5 ns;
		btn_i(0)<='1';
		wait for 15 ns;--wpisz
		btn_i(0)<='0';
		
		wait for 400 ns;
		
		swDig <= "0011";--3 na cyfrze 2 od prawej
		wait for 5 ns;
		btn_i(1)<='1';
		wait for 15 ns;
		btn_i(1)<='0';
		
		swDig <= "0111"; --na 2 od lewej
		wait for 5 ns;
		btn_i(2)<='1';
		wait for 15 ns;--wpisz
		btn_i(2)<='0';
		
		wait for 400 ns;
		
		swDig <= "1001"; --na lewy
		wait for 5 ns;
		btn_i(3)<='1';
		wait for 15 ns;--wpisz
		btn_i(3)<='0';
		
		wait for 400 ns;
		
		swDig <= "0000"; --zera na wszystkie segmenty
		wait for 5 ns;
		btn_i(0)<='1';
		btn_i(1)<='1';
		btn_i(2)<='1';
		btn_i(3)<='1';
		wait for 15 ns;--wpisz
		btn_i(0)<='0';
		btn_i(1)<='0';
		btn_i(2)<='0';
		btn_i(3)<='0';
		
		
		wait for 400 ns;
		
		
		
      wait for clk_i_period*10;

      -- insert stimulus here 

      wait;
   end process;
end;
