--Cezary Wieczorkowski
--Wojciech Paderewski
library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

entity top is
 Port ( 
     clk_i : in STD_LOGIC;
     btn_i : in STD_LOGIC_VECTOR (3 downto 0);
     sw_i : in STD_LOGIC_VECTOR (7 downto 0);
     led7_an_o : out STD_LOGIC_VECTOR (3 downto 0);
     led7_seg_o : out STD_LOGIC_VECTOR (7 downto 0)
 );
end top;

architecture Behavioral of top is
    signal encoded_signal: STD_LOGIC_VECTOR (31 downto 0);
    component EncoderAndMemory
         Port ( 
             clk_i : in STD_LOGIC;
             btn_i : in STD_LOGIC_VECTOR (3 downto 0);
             sw_i : in STD_LOGIC_VECTOR (7 downto 0);
             digit_i : out STD_LOGIC_VECTOR (31 downto 0)
         );           
    end component;
    component Display
         Port ( 
             clk_i : in STD_LOGIC;
             rst_i : in STD_LOGIC;
             digit_i : in STD_LOGIC_VECTOR (31 downto 0);
             led7_an_o : out STD_LOGIC_VECTOR (3 downto 0);
             led7_seg_o : out STD_LOGIC_VECTOR (7 downto 0)
         );           
    end component;
begin
 encoder:EncoderAndMemory
    Port Map ( 
        clk_i => clk_i,
        btn_i => btn_i,
        sw_i => sw_i,
        digit_i => encoded_signal
  );
  displayer:Display
    Port Map ( 
        clk_i => clk_i,
        rst_i => '0',
        digit_i => encoded_signal,
        led7_an_o => led7_an_o,
        led7_seg_o => led7_seg_o
  );

end Behavioral;
