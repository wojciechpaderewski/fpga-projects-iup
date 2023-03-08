--Cezary Wieczorkowski
--Wojciech Paderewski

library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.NUMERIC_STD.ALL;
use IEEE.STD_LOGIC_UNSIGNED.ALL;

entity top is
     Port ( 
     clk_i : in STD_LOGIC;
     rst_i : in STD_LOGIC;
     led_o : out STD_LOGIC_VECTOR (2 downto 0)
     );
end top;

architecture Behavioral of top is
    signal counter_bin: STD_LOGIC_VECTOR (2 downto 0) := "000";
begin
    COUNT : process(clk_i, rst_i)
    begin
        if (rst_i = '1') then
            counter_bin <= "000";
        else
            if falling_edge(clk_i) then
                counter_bin <= counter_bin + "001";
            else 
                counter_bin <= counter_bin;
            end if;
        end if;	 
    end process;
    
    --decimal to gray
    led_o(2) <= counter_bin(2);
    led_o(1) <= counter_bin(2) xor counter_bin(1);
    led_o(0) <= counter_bin(1) xor counter_bin(0);
end Behavioral;
