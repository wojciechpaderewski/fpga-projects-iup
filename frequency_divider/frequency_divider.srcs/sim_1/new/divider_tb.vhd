----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date: 11.03.2023 16:06:53
-- Design Name: 
-- Module Name: divider_tb - Behavioral
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

entity divider_tb is
end divider_tb;

architecture Behavioral of divider_tb is
    component top is
        Port(clk_i : in STD_LOGIC;
           rst_i : in STD_LOGIC;
           led_o : out STD_LOGIC);
    end component;
    
    constant PERIOD : time := 10ns;     --coresponds to 100Mhz freq
    
    signal clk_i : std_logic := '0';
    signal rst_i : std_logic := '1';    --start with device in reset
    signal led_o : std_logic;
begin
    UUT : top port map(clk_i => clk_i, rst_i => rst_i, led_o => led_o);
    
    clk_i <= not clk_i after PERIOD/2;   --generate simple clock
    
    tb : process
        begin
            wait for 5ns;
            rst_i <= '0';
            wait for 200ns;
            rst_i <= '1';
            wait for 5ns;
            rst_i <= '0';
            wait;  
    end process tb;
end Behavioral;
