--Cezary Wieczorkowski
--Wojciech Paderewski
library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.STD_LOGIC_UNSIGNED.ALL;

entity top_tb is
end top_tb;

ARCHITECTURE behavior OF top_tb IS 
 
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
   signal sw_i : std_logic_vector(7 downto 0) := "10010000";
   signal btn_i : std_logic_vector(3 downto 0) := (others => '0');
   signal clk_i : std_logic := '0';

 	--Outputs
   signal led7_an_o : std_logic_vector(3 downto 0);
   signal led7_seg_o : std_logic_vector(7 downto 0);

   -- Clock period definitions
   constant period : time := 10 ns;
 
BEGIN
 
	-- Instantiate the Unit Under Test (UUT)
   uut: top PORT MAP (
          led7_an_o => led7_an_o,
          led7_seg_o => led7_seg_o,
          sw_i => sw_i,
          btn_i => btn_i,
          clk_i => clk_i
        );

   -- Clock
   clk_i <= not clk_i after period/2;
   
   sim: process
   begin		
      for i in 0 to 3 loop
        btn_i(i) <= '1';
        wait for 1 ms;
        btn_i(i) <= '0';
        wait for 1 ms;
        sw_i <= sw_i + '1';
      end loop;
      wait;
   end process;
end;
