----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date: 02.03.2023 19:22:01
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


library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use ieee.numeric_std.all;

-- Uncomment the following library declaration if using
-- arithmetic functions with Signed or Unsigned values
--use IEEE.NUMERIC_STD.ALL;

-- Uncomment the following library declaration if instantiating
-- any Xilinx leaf cells in this code.
--library UNISIM;
--use UNISIM.VComponents.all;

entity top is
 Port (
 sw_i : in STD_LOGIC_VECTOR (3 downto 0);
 led7_an_o : out STD_LOGIC_VECTOR (3 downto 0);
 led7_seg_o : out STD_LOGIC_VECTOR (7 downto 0)
 );
end top;

architecture Behavioral of top is
    constant zero_on_display: std_logic_vector := "11111100";
    constant one_on_display: std_logic_vector := "01100000";
    constant two_on_display: std_logic_vector := "00100101";
    constant three_on_display: std_logic_vector := "11110010";
    constant four_on_display: std_logic_vector := "01100110";
    signal input_number: integer range 0 to 4;
    
    function count(s : std_logic_vector) return integer is
      variable temp : natural := 0;
        begin
          for i in s'range loop
            if s(i) = '1' then temp := temp + 1; 
            end if;
          end loop;
          
         return temp;
    end function count;
begin
    input_number <= count(sw_i);
    
    led7_an_o <= "1110"; -- choose display
    
    with input_number select led7_seg_o <=
        zero_on_display when 0,
        one_on_display when 1,
        two_on_display when 2,
        three_on_display when 3,
        four_on_display when 4;
end Behavioral;
