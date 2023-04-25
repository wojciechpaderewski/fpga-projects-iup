--Cezary Wieczorkowski
--Wojciech Paderewski

library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.numeric_std.all;

entity Encoder is
 Port (
     clk_i : in STD_LOGIC;
     digit_in : in STD_LOGIC_VECTOR (15 downto 0);
     digit_out : out STD_LOGIC_VECTOR (31 downto 0)
 );
end Encoder;

architecture Behavioral of Encoder is
    signal current_digit_i: std_logic_vector (31 downto 0) := "00000001000000000000000100000001";
    signal current_segment_display_number: std_logic_vector (6 downto 0) := "0000000";
    signal input_digit_int: integer := 0;
    signal th_part: integer := 0;
    signal hun_part: integer := 0;
    signal dec_part: integer := 0;
    signal int_part: integer  := 0;
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
    SetNumber : process(clk_i)
    begin
        if rising_edge(clk_i) then
            input_digit_int <= to_integer(unsigned(digit_in(15 downto 0)));
            th_part <= (input_digit_int mod 10000) / 1000;
            hun_part <= (input_digit_int mod 1000) / 100;
            dec_part <= (input_digit_int mod 100) / 10;
            int_part <= (input_digit_int mod 10);
            
            current_digit_i(7 downto 1) <= segment_display_hex_values(int_part);
            current_digit_i(15 downto 9) <= segment_display_hex_values(dec_part);
            current_digit_i(23 downto 17) <= segment_display_hex_values(hun_part);
            current_digit_i(31 downto 25) <= segment_display_hex_values(th_part);
        end if;
    end process;
    
    digit_out <= current_digit_i;
end Behavioral;
