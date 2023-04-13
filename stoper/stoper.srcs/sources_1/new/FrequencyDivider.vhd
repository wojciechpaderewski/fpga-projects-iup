--Cezary Wieczorkowski
--Wojciech Paderewski
library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

entity FrequencyDivider is
    generic(
          divider : integer := 1
     ); 
    Port (
          clk_i : in STD_LOGIC;
          clk_out: out STD_LOGIC
     );
end FrequencyDivider;

architecture Behavioral of FrequencyDivider is
    signal counter : natural := 0;
    signal div_out : std_logic := '0';
begin
    division : process(clk_i)
        begin
           if falling_edge(clk_i) then
               counter <= counter + 1;     --increment counter every clock cycle
               if counter = divider/2 - 1 then   --change state in mid cycle
                   div_out <= not div_out;
               end if;
               if counter >= divider-1 then      --change state at the end of the output cycle
                   counter <= 0;           --zero the counter
                   div_out <= not div_out; 
               end if;
           end if;
    end process division;
    clk_out <= div_out;
end Behavioral;
