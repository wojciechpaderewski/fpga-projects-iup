library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.STD_LOGIC_UNSIGNED.ALL;

entity ps2_transiver is
    Port (clk_i : in STD_LOGIC;
          rst_i : in STD_LOGIC;
          ps2_clk_i : in STD_LOGIC;
          ps2_data_i : in STD_LOGIC;
          ps2_data_byte : out std_logic_vector(7 downto 0));
end ps2_transiver;

architecture Behavioral of ps2_transiver is
    
    constant BRAKE_SYMBOL : std_logic_vector (7 downto 0) := "11110000";
    constant READ_DELAY : integer := 2500;
    
    signal ps2_packet_buff : std_logic_vector(10 downto 0) := (others => '0');
    signal ps2_data_buff : std_logic_vector(7 downto 0) := (others => '0');
begin
    reciever : process(clk_i, rst_i)
        variable fall_edge_flag : integer := 0;
        variable ps2_clk_prev : std_logic := '0';
        variable ps2_clk_curr : std_logic := '0';
        variable recieved_bits : integer := 0;
        variable licznik : integer := 0;
    begin
        if (rst_i = '1') then
           fall_edge_flag := 0; 
           recieved_bits := 0;  
           licznik := 0;    
        else
            if rising_edge (clk_i) then
                ps2_clk_curr := ps2_clk_i;
                if ps2_clk_curr = '0' and ps2_clk_prev = '1' then
                    fall_edge_flag := 1;
                end if;
                if fall_edge_flag = 1 then
                    licznik := licznik + 1;
                    if licznik = READ_DELAY then
                        ps2_packet_buff(recieved_bits) <= ps2_data_i;
                        recieved_bits := recieved_bits + 1;
                        fall_edge_flag := 0;
                    end if;
                end if;
                if recieved_bits >= 11 and ps2_packet_buff(8 downto 1) /= BRAKE_SYMBOL then
                    ps2_data_buff <= ps2_packet_buff(8 downto 1);
                    recieved_bits := 0;
                end if;
            end if;
            ps2_clk_prev := ps2_clk_i;
        end if;
    end process reciever;
    ps2_data_byte <= ps2_data_buff;
end Behavioral;
