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

entity counter_gray_tb is
end counter_gray_tb;

architecture Behavioral of counter_gray_tb is

    component top
        port(
            clk_i : in STD_LOGIC;
            rst_i : in STD_LOGIC;
            led_o : out STD_LOGIC_VECTOR (2 downto 0)
        );
    end component;
    
    signal clk_i : STD_LOGIC := '0';
    signal rst_i : STD_LOGIC := '0';
    signal led_o : STD_LOGIC_VECTOR (2 downto 0);
begin

    UUT : top port map(clk_i => clk_i, rst_i => rst_i, led_o => led_o);
   
    tb : PROCESS
        BEGIN
            rst_i <= '1';
            wait for 50 ms;
            rst_i <= '0';
            wait for 50 ms;
            for i in 0 to 15 loop
                if (i = 4) then 
                   rst_i <= '1';
                    wait for 50 ms;
                    rst_i <= '0';
                    wait for 50 ms; 
                else
                    wait for 50 ms;
                    clk_i <= '1';
                    wait for 50 ms;
                    clk_i <= '0';
                end if;
            end loop;
            wait;
        END PROCESS tb;
end Behavioral;