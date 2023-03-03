----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date: 03.03.2023 09:29:44
-- Design Name: 
-- Module Name: sim - Behavioral
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

entity sim is
--  Port ( );
end sim;

architecture Behavioral of sim is

    component top
        port(
             sw_i : in STD_LOGIC_VECTOR (3 downto 0);
             led7_an_o : out STD_LOGIC_VECTOR (3 downto 0);
             led7_seg_o : out STD_LOGIC_VECTOR (7 downto 0)
            );
    end component;
    
    signal sw_i : STD_LOGIC_VECTOR (3 downto 0) := "0000";
    signal led7_an_o : STD_LOGIC_VECTOR (3 downto 0);
    signal led7_seg_o : STD_LOGIC_VECTOR (7 downto 0);
begin

    UUT : top port map(sw_i => sw_i, led7_an_o => led7_an_o, led7_seg_o => led7_seg_o);
   
    tb : PROCESS
        BEGIN
            for i in 0 to 3 loop
                wait for 100 ms;
                sw_i(i) <= '1';
            end loop;
            wait;
        END PROCESS tb;
end Behavioral;
