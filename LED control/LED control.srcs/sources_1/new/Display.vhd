library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

entity Display is
 Port ( 
     clk_i : in STD_LOGIC;
     rst_i : in STD_LOGIC;
     digit_i : in STD_LOGIC_VECTOR (31 downto 0);
     led7_an_o : out STD_LOGIC_VECTOR (3 downto 0);
     led7_seg_o : out STD_LOGIC_VECTOR (7 downto 0)
 );
end Display;

architecture Behavioral of Display is
    component FrequencyDivider
         generic(
              divider : integer
         ); 
         Port (
            clk_i : in STD_LOGIC;
            clk_out: out STD_LOGIC
         );             
     end component;

     signal which_display :  STD_LOGIC_VECTOR (3 downto 0) := "1110";
     signal display_value :  STD_LOGIC_VECTOR (7 downto 0) := "00000000";
     signal divided_clk: STD_LOGIC := '0';
begin

    d:FrequencyDivider
    Generic Map (
        divider => 100000
    )
    Port Map ( clk_i => clk_i,
               clk_out => divided_clk 
    );

    show_on_display : process(divided_clk, digit_i, rst_i)
    begin
        if (rst_i = '1') then
            which_display <= "0000";
            display_value <= "11111111";
        else
         if rising_edge(divided_clk) then
            case which_display is
                when "1110" =>
                    display_value <= digit_i(7 downto 0);
                    --which_display <= "1101";
                when "1101" =>
                    display_value <= digit_i(15 downto 8);
                    --which_display <= "1011";
                when "1011" =>
                    display_value <= digit_i(23 downto 16);
                    --which_display <= "0111";
                when "0111" =>
                    display_value <= digit_i(31 downto 24);
                    --which_display <= "1110";
                when others =>
                    display_value <= display_value;
            end case;
            which_display <= which_display(2 downto 0) & which_display(3);
         end if;
         end if;
    end process;
    led7_an_o <= which_display;
    led7_seg_o <= display_value;
end Behavioral;
