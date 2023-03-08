----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date: 01.03.2023 16:17:44
-- Design Name: 
-- Module Name: parity - Behavioral
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
    Port(sw_i : in STD_LOGIC_VECTOR (7 downto 0);
        led7_an_o : out STD_LOGIC_VECTOR (3 downto 0);
        led7_seg_o : out STD_LOGIC_VECTOR (7 downto 0));
end top;

architecture Behavioral of top is
    signal parity_bit : STD_LOGIC;
begin
    led7_an_o <= "1110";
    parity_bit <= sw_i(7) xor sw_i(6) xor sw_i(5) xor sw_i(4) xor sw_i(3) xor sw_i(2) xor sw_i(1) xor sw_i(0);
    led7_seg_o <= "01100001" when (parity_bit = '0') else "00000011"; -- 0 = 00000011 E = 01100001
end Behavioral;
