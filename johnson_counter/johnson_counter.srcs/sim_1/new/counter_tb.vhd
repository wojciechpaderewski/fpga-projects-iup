----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date: 06.03.2023 21:18:11
-- Design Name: 
-- Module Name: counter_tb - Behavioral
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

entity counter_tb is
end counter_tb;

architecture Behavioral of counter_tb is
    component top 
        port(
            clk_i : in  std_logic;
            rst_i : in  std_logic;
            led_o : out std_logic_vector(3 downto 0)
            );       
    end component;

    signal clk_i : std_logic := '0';
    signal rst_i : std_logic := '0';
    signal led_o : std_logic_vector(3 downto 0);   
begin
    UUT : top port map(clk_i => clk_i, rst_i => rst_i, led_o => led_o);
    tb : process
        begin
            for i in 0 to 31 loop
                if i = 20 then
                    rst_i <= '1';
                    wait for 10 ms;
                    rst_i <= '0';    
                end if;
                wait for 50 ms;
                clk_i <= not clk_i;  
            end loop;
            wait;                
    end process tb;  
end Behavioral;
