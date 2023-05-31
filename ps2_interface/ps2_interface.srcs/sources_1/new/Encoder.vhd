--Cezary Wieczorkowski
--Wojciech Paderewski

library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.numeric_std.all;

entity Encoder is
 Port (
     clk_i : in STD_LOGIC;
     rst_i : in STD_LOGIC;
     digit_in : in STD_LOGIC_VECTOR (7 downto 0);
     digit_out : out STD_LOGIC_VECTOR (6 downto 0)
 );
end Encoder;

architecture Behavioral of Encoder is
    signal current_digit_i: std_logic_vector (6 downto 0) := "0000000";
    type segment_display_type is array (0 to 15) of std_logic_vector (6 downto 0);
    type key_type is array (0 to 15) of  integer range 0 to 255; --binary values to 7-segment display
    signal keyValue: integer range 0 to 255 := 0;
    signal lastKeyValue: integer range 0 to 255 := 0;
    signal isOtherKeyPresed: STD_LOGIC := '0';

    --binary values to 7-segment display
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
      constant key_hex_values : key_type := -- a b c d e f g
                    (16#45#,--0
                    16#16#,--1
                    16#1E#,--2
                    16#26#,--3
                    16#25#,--4
                    16#2E#,--5
                    16#36#,--6
                    16#3D#,--7
                    16#3E#,--8
                    16#46#,--9
                    16#1C#,--A
                    16#32#,--b
                    16#21#,--C
                    16#23#,--d
                    16#24#,--E
                    16#2B#);--F
begin
    EncodeKeyValueTo7SegmentValue : process(clk_i, digit_in, rst_i)
    begin 
        if (rst_i = '1') then
           lastKeyValue <= 0;
           current_digit_i <= "1111111";
        elsif rising_edge(clk_i) then
        keyValue <= to_integer(unsigned(digit_in(7 downto 0)));           
                for i in 0 to segment_display_hex_values'length-1 loop
                    if(keyValue = key_hex_values(i)) then 
                        current_digit_i <= segment_display_hex_values(i);
                        isOtherKeyPresed <= '0';
                        lastKeyValue <= keyValue;
                        exit;
                    else
                        isOtherKeyPresed <= '1';
                    end if;
                end loop;
                
                if(isOtherKeyPresed = '1') then 
                    current_digit_i <= "1111111";
                end if;        
            end if;
    end process;
    
    digit_out <= current_digit_i;
end Behavioral;