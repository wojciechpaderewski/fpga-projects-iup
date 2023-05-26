--Cezary Wieczorkowski
--Wojciech Paderewski

library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

entity Seg_Display is
 Port ( 
     clk_i : in STD_LOGIC;
     digit_i : in STD_LOGIC_VECTOR (6 downto 0);
     led7_an_o : out STD_LOGIC_VECTOR (3 downto 0);
     led7_seg_o : out STD_LOGIC_VECTOR (7 downto 0)
 );
end Seg_Display;

architecture Behavioral of Seg_Display is
begin
    led7_an_o <= "0111";
    led7_seg_o <= digit_i;
end Behavioral;
