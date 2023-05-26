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
    signal outputValue : STD_LOGIC_VECTOR (7 downto 0) := "11111111";
begin
    setOutputValue : process(clk_i)
    begin
        if rising_edge(clk_i) then
                -- dot value
                outputValue(0)<= '1';
                outputValue(1)<= digit_i(0);
                outputValue(2)<= digit_i(1);
                outputValue(3)<= digit_i(2);
                outputValue(4)<= digit_i(3);
                outputValue(5)<= digit_i(4);
                outputValue(6)<= digit_i(5);
                outputValue(7)<= digit_i(6);
        end if;
    end process;
    
    led7_an_o <= "0111";
    led7_seg_o <= outputValue;
end Behavioral;
