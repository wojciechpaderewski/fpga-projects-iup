library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.numeric_std.all;

entity EncoderAndMemory is
 Port ( 
     clk_i : in STD_LOGIC;
     btn_i : in STD_LOGIC_VECTOR (3 downto 0);
     sw_i : in STD_LOGIC_VECTOR (7 downto 0);
     digit_i : out STD_LOGIC_VECTOR (31 downto 0)
 );
end EncoderAndMemory;

architecture Behavioral of EncoderAndMemory is
    signal current_digit_i: STD_LOGIC_VECTOR (31 downto 0) := "00000000000000000000000000000000";
    signal current_segment_display_number: STD_LOGIC_VECTOR (6 downto 0) := "0000000";
    type segment_display_type is array (0 to 15) of std_logic_vector (6 downto 0); --binary values to 7-segment display
    constant segment_display_hex_values : segment_display_type := -- a b c d e f g
                  ("0000001",--0
                    "1001111",--1
                    "0010010",--2
                    "0000110",--3
                    "1001100",--4
                    "0100100",--5
                    "0100000",--6
                    "0001111",--7
                    "0000000",--8
                    "0000100",--9
                    "0001000",--A
                    "1100000",--b
                    "0110001",--C
                    "1000010",--d
                    "0110000",--E
                    "0111000");--F
begin
    SetNumber : process(clk_i, sw_i)
    begin
        if rising_edge(clk_i) then
            current_segment_display_number <= segment_display_hex_values(to_integer(unsigned(sw_i(3 downto 0))));
        end if;
    end process;
    ChooseDisplay : process(clk_i, btn_i)
    begin
         if rising_edge(clk_i) then
            case btn_i is
                when "0001" =>
                    current_digit_i(6 downto 0) <= current_segment_display_number;
                when "0010" =>
                    current_digit_i(14 downto 8) <= current_segment_display_number;
                when "0100" =>
                    current_digit_i(22 downto 16) <= current_segment_display_number;
                when "1000" =>
                    current_digit_i(30 downto 24) <= current_segment_display_number;
               when others =>
                    current_segment_display_number <= current_segment_display_number;
            end case;
        end if;
    end process;
    SetDots: process(clk_i, sw_i)
    begin
        if rising_edge(clk_i) then
           current_digit_i(7) <= sw_i(4);
           current_digit_i(15) <= sw_i(5);
           current_digit_i(23) <= sw_i(6);
           current_digit_i(31) <= sw_i(7);
        end if;
    end process;
    digit_i <= current_digit_i;
end Behavioral;
