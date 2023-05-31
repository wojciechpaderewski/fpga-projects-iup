----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date: 26.04.2023 17:21:17
-- Design Name: 
-- Module Name: ps2_interface_tb - Behavioral
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
--Cezary Wieczorkowski
--Wojciech Paderewski

library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

entity ps2_interface_tb is
end ps2_interface_tb;

architecture Behavioral of ps2_interface_tb is

component top is
    Port (clk_i : in STD_LOGIC;
          rst_i : in STD_LOGIC;
          ps2_clk_i : in STD_LOGIC;
          ps2_data_i : in STD_LOGIC;
          led7_an_o : out STD_LOGIC_VECTOR (3 downto 0);
          led7_seg_o : out STD_LOGIC_VECTOR (7 downto 0));
end component top;

constant period: time := 10ns;
constant ps2_period: time := 66000ns;

signal clk: std_logic := '0';
signal rst: std_logic := '0';
signal ps2_clk: std_logic := '0';
signal ps2_data: std_logic := '0';
signal led7_an: std_logic_vector (3 downto 0) := "0000";
signal led7_seg: std_logic_vector (7 downto 0) := "00000000";
signal data_clock_period: time := ps2_period;

begin

    uut: top
    port map(
        clk_i => clk,
        rst_i => rst,
        ps2_clk_i => ps2_clk,
        ps2_data_i => ps2_data,
        led7_an_o => led7_an,
        led7_seg_o => led7_seg
    );
    
    clk <= not clk after period/2;
    ps2_clk <= not ps2_clk after ps2_period/2;

   stim_proc: process
   begin
        --ps2_data <= '1';
        --wait for data_clock_period * 3.5;
        ps2_data <= '0'; --start
		wait for data_clock_period;
			 
  -- 0001 1100 A key
		ps2_data <= '0';
		wait for data_clock_period;
		ps2_data <= '0';
		wait for data_clock_period;
		ps2_data <= '0';
		wait for data_clock_period;
		ps2_data <= '1';
		wait for data_clock_period;

        ps2_data <= '1';
		wait for data_clock_period;
		ps2_data <= '1';
		wait for data_clock_period;
        ps2_data <= '0';
		wait for data_clock_period;
		ps2_data <= '0';
		wait for data_clock_period;

		ps2_data <= '0'; -- bit parzysto�ci
		wait for data_clock_period;
		ps2_data <= '1'; -- bit stopu
		wait for 1000us;
   end process;
end Behavioral;
