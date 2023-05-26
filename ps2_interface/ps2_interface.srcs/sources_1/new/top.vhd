----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date: 26.04.2023 17:19:24
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
--Cezary Wieczorkowski
--Wojciech Paderewski

library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

entity top is
    Port (clk_i : in STD_LOGIC;
          rst_i : in STD_LOGIC;
          ps2_clk_i : in STD_LOGIC;
          ps2_data_i : in STD_LOGIC;
          led7_an_o : out STD_LOGIC_VECTOR (3 downto 0);
          led7_seg_o : out STD_LOGIC_VECTOR (7 downto 0));
end top;

architecture Behavioral of top is
    component ps2_transiver is
        Port (clk_i : in STD_LOGIC;
              rst_i : in STD_LOGIC;
              ps2_clk_i : in STD_LOGIC;
              ps2_data_i : in STD_LOGIC;
              ps2_data_byte : out std_logic_vector(7 downto 0));
    end component ps2_transiver;
    component Seg_Display is
        port( 
            clk_i : in STD_LOGIC;
            digit_i : in STD_LOGIC_VECTOR (6 downto 0);
            led7_an_o : out STD_LOGIC_VECTOR (3 downto 0);
            led7_seg_o : out STD_LOGIC_VECTOR (7 downto 0)
            );
    end component Seg_Display;
    component Encoder is
        port(
            clk_i : in STD_LOGIC;
            rst_i : in std_logic;
            digit_in : in STD_LOGIC_VECTOR (7 downto 0);
            digit_out : out STD_LOGIC_VECTOR (6 downto 0)
            );
    end component Encoder;
    
    signal enc_dis_digit_bridge : std_logic_vector (6 downto 0);
    signal ps2_enc_digit_bridge : std_logic_vector (7 downto 0);

begin
    transiver : ps2_transiver
        port map(
            clk_i => clk_i,
            rst_i => rst_i,
            ps2_clk_i => ps2_clk_i,
            ps2_data_i => ps2_data_i,
            ps2_data_byte => ps2_enc_digit_bridge
        );

    digit_decoder : Encoder
    port map(
        clk_i => clk_i,
        rst_i => rst_i,
        digit_in => ps2_enc_digit_bridge,
        digit_out => enc_dis_digit_bridge
    );    
    
    displayer : Seg_Display
    port map(
        clk_i => clk_i,
        digit_i => enc_dis_digit_bridge,
        led7_an_o => led7_an_o,
        led7_seg_o => led7_seg_o
    );

end Behavioral;
