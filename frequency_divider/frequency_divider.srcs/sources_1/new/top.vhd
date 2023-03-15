----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date: 11.03.2023 15:30:08
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
    Port (clk_i : in STD_LOGIC;
          rst_i : in STD_LOGIC;
          led_o : out STD_LOGIC);
end top;

architecture Behavioral of top is
--    constant N : natural := 26;     --divider for simulation set to 1+8+8+5+4
    constant N : natural := 100000000;
    signal counter : natural := 0;
    signal div_out : std_logic := '0';
begin
    division : process(clk_i, rst_i)
        begin
            if rst_i = '1' then     --perform reset
                div_out <= '0';
                counter <= 0;
            else 
                if falling_edge(clk_i) then
                    counter <= counter + 1;     --increment counter every clock cycle
                    if counter = N/2 - 1 then   --change state in mid cycle
                         div_out <= not div_out;
                    end if;
                    if counter >= N-1 then      --change state at the end of the output cycle
                        counter <= 0;           --zero the counter
                        div_out <= not div_out; 
                    end if;
                end if;
            end if;
    end process division;
    led_o <= div_out;
end Behavioral;
