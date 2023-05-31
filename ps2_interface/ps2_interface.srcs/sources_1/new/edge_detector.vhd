--Cezary Wieczorkowski
--Wojciech Paderewski

library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

entity edge_detector is
    port(clk_i : in std_logic;
        input : in std_logic;
        edge : out std_logic);   
end edge_detector;

architecture Behavioral of edge_detector is
   signal reg0 :std_logic;
   signal reg1 :std_logic;
begin
    detect: process(clk_i)
    begin
        if rising_edge(clk_i) then
            reg0  <= input;
            reg1  <= reg0;
        end if;
    end process;
    edge <= not reg0 and reg1;
end Behavioral;