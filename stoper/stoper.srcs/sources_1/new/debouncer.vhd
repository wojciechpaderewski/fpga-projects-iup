----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date: 13.04.2023 14:54:41
-- Design Name: 
-- Module Name: debouncer - Behavioral
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
use IEEE.STD_LOGIC_UNSIGNED.ALL;

entity debouncer is
    Port(
    clk_i : in std_logic;
    input_i : in std_logic;
    output_i : out std_logic
    );
end debouncer;

architecture Behavioral of debouncer is

signal licznik : std_logic_vector(21 downto 0);
 
begin
 
   Debouncer_przycisku: process(clk_i)
   begin
      if rising_edge(clk_i) then
         if (input_i) = '0' then
            licznik <= (others => '1');
         else
            if licznik /= 0 then
               licznik <= licznik - 1;
            end if;
         end if;
      end if;
   end process Debouncer_przycisku;
 
output_i <= '1' when licznik = 0 else '0';

end Behavioral;
