----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date: 03.03.2023 09:29:44
-- Design Name: 
-- Module Name: sim - Behavioral
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

entity sim is
end sim;

architecture Behavioral of sim is

    component top
        port(
             sw_i : in STD_LOGIC_VECTOR (3 downto 0);
             led7_an_o : out STD_LOGIC_VECTOR (3 downto 0);
             led7_seg_o : out STD_LOGIC_VECTOR (7 downto 0)
            );
    end component;
    
    signal sw_i : STD_LOGIC_VECTOR (3 downto 0) := "0000";
    signal led7_an_o : STD_LOGIC_VECTOR (3 downto 0);
    signal led7_seg_o : STD_LOGIC_VECTOR (7 downto 0);
begin

    UUT : top port map(sw_i => sw_i, led7_an_o => led7_an_o, led7_seg_o => led7_seg_o);
   
    tb : PROCESS
        BEGIN
            for i in 0 to 15 loop
                wait for 100 ms;
                sw_i <= sw_i + 1;
            end loop;
            wait;
        END PROCESS tb;
end Behavioral;
