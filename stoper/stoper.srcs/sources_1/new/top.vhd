----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date: 13.04.2023 14:38:34
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

-- Uncomment the following library declaration if using
-- arithmetic functions with Signed or Unsigned values
--use IEEE.NUMERIC_STD.ALL;

-- Uncomment the following library declaration if instantiating
-- any Xilinx leaf cells in this code.
--library UNISIM;
--use UNISIM.VComponents.all;

entity top is
 Port( 
     clk_i : in STD_LOGIC;
     rst_i : in STD_LOGIC;
     start_stop_button_i : in STD_LOGIC;
     led7_an_o : out STD_LOGIC_VECTOR (3 downto 0);
     led7_seg_o : out STD_LOGIC_VECTOR (7 downto 0)
    );
end top;


architecture Behavioral of top is
    component debouncer
        Port(
            clk_i : in std_logic;
            input_i : in std_logic;
            output_i : out std_logic
            );
    end component debouncer;
    
    type stopwatch_state is (WAITING, COUNTING, STOPPED, OVERFLOW);
    signal state : stopwatch_state := WAITING; 
    signal rst_i_deb : std_logic; 
    signal start_stop_button_i_deb : std_logic; 
begin
    
    r_debouncer : debouncer
    Port map(
        clk_i => clk_i,
        input_i => rst_i,
        output_i => rst_i_deb
    );

    s_debouncer : debouncer
    Port map(
        clk_i => clk_i,
        input_i => start_stop_button_i,
        output_i => start_stop_button_i_deb
    ); 
            
end Behavioral;
