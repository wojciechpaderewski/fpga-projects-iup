----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date: 02.03.2023 12:25:49
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

entity parity_tb is
end parity_tb;

architecture Behavioral of parity_tb is

    component top
        port(
            sw_i : in STD_LOGIC_VECTOR (7 downto 0);
            led7_an_o : out std_logic_vector (3 downto 0);
            led7_seg_o : out std_logic_vector (7 downto 0)
            );
    end component;
    
    signal sw_i : STD_LOGIC_VECTOR (7 downto 0) := "00000000";
    signal led7_an_o : STD_LOGIC_VECTOR (3 downto 0);
    signal led7_seg_o : STD_LOGIC_VECTOR (7 downto 0);
begin

    UUT : top port map(sw_i => sw_i, led7_an_o => led7_an_o, led7_seg_o => led7_seg_o);
   
    tb : PROCESS
        BEGIN
            for i in 0 to 7 loop
                wait for 100 ms;
                sw_i(i) <= '1';
            end loop;
            wait;
        END PROCESS tb;
end Behavioral;
