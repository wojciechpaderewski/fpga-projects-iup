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
 port( 
     clk_i : in STD_LOGIC;
     rst_i : in STD_LOGIC;
     start_stop_button_i : in STD_LOGIC;
     led7_an_o : out STD_LOGIC_VECTOR (3 downto 0);
     led7_seg_o : out STD_LOGIC_VECTOR (7 downto 0)
    );
end top;


architecture Behavioral of top is
    component debouncer
        port(
            clk_i : in std_logic;
            input_i : in std_logic;
            output_i : out std_logic
            );
    end component debouncer;
    
    component counter is
        port(
            clk_i : in std_logic;
            rst_i : in std_logic;
            inhibit_i : in std_logic;
            count : out std_logic_vector(15 downto 0)
            );
    end component counter;
    
    type stopwatch_state is (WAITING, COUNTING, STOPPED, OVERFLOW);
    
    constant ovf_symbol : std_logic_vector (15 downto 0) := "0010001010111000";
    
    signal state : stopwatch_state := WAITING; 
    
    signal rst_i_deb : std_logic; 
    signal start_stop_button_i_deb : std_logic;
    
    signal counter_rst : std_logic := '0';
    signal counter_inhibit : std_logic := '0';
    signal counter_ovf_flag : std_logic := '0';
    signal counter_output : std_logic_vector (15 downto 0);
    signal counter_output_buffer : std_logic_vector (15 downto 0);
    
    
begin
    
    r_debouncer : debouncer
    port map(
        clk_i => clk_i,
        input_i => rst_i,
        output_i => rst_i_deb
    );

    s_debouncer : debouncer
    port map(
        clk_i => clk_i,
        input_i => start_stop_button_i,
        output_i => start_stop_button_i_deb
    );
    
    c_counter : counter
    port map(
        clk_i => clk_i,
        rst_i => counter_rst,
        inhibit_i => counter_inhibit,
        count => counter_output
    );      
    
    stopwatch : process(clk_i, rst_i_deb)
    variable btn_flag : integer := 0;
    variable btn_pressed : integer := 0;
        begin
            if (rst_i_deb = '1') then
                counter_rst <= '1';
                state <= WAITING;
                --possibly add sth
            elsif rising_edge (clk_i) then
            
                if btn_flag = 0 and start_stop_button_i_deb = '1' then
                    btn_flag := 1;
                elsif btn_flag = 1 and start_stop_button_i_deb = '0' then
                    btn_pressed := 1;
                    btn_flag := 0;
                end if;
                
                case state is
                
                    when WAITING =>
                        counter_rst <= '1';
                        counter_ovf_flag <= '0';
                        
                        if btn_pressed = 1 then
                            state <= COUNTING;
                        end if;
                        
                    when COUNTING => 
                        counter_rst <= '0';
                        
                        if btn_pressed = 1 then
                            state <= STOPPED;
                        end if;
                        
                    when STOPPED =>
                        counter_inhibit <= '1';
                        
                        if btn_pressed = 1 then
                            state <= WAITING;
                        end if;
                        
                    when OVERFLOW =>
                        counter_ovf_flag <= '1';
                        
                        if btn_pressed = 1 then
                            state <= WAITING;
                        end if;
                        
                    when others =>
                        state <= WAITING;
                        
                end case;
                
                btn_pressed := 0;
                
            end if;
            
    end process stopwatch;
    
    counter_output_buffer <= ovf_symbol when counter_ovf_flag = '1' else counter_output;
    
end Behavioral;
