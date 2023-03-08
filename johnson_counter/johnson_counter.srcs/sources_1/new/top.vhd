----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date: 03.03.2023 15:31:05
-- Design Name: 
-- Module Name: top - Behavioral
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

entity top is
    Port ( clk_i : in STD_LOGIC;
           rst_i : in STD_LOGIC;
           led_o : out STD_LOGIC_VECTOR (3 downto 0));         
end top;

architecture Behavioral of top is
    signal temp_counter : std_logic_vector(3 downto 0) := "0000";
begin
    counter : process (clk_i, rst_i)
        begin
            if rst_i = '1' then             
                temp_counter <= "0000";     --reset
            else
                if rising_edge(clk_i) then
                    temp_counter <= temp_counter(2 downto 0) & not temp_counter(3);     --shift left and move negation of msb to lsb 
                end if;
            end if;         
    end process counter;
    led_o <= temp_counter;
end Behavioral;
