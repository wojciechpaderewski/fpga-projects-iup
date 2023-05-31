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

    component edge_detector is
        Port(clk_i : in std_logic;
            input : in std_logic;
            edge : out std_logic);   
    end component edge_detector;

    type reciever_state is (WAITING, DELAY, READ_DATA, DATA_READY);
    
    constant BRAKE_SYMBOL : std_logic_vector (7 downto 0) := "11110000";
    constant READ_DELAY : integer := 2500;
    
    signal state : reciever_state := WAITING;
    signal ps2_packet_buff : std_logic_vector(10 downto 0) := (others => '0');
    signal ps2_data_buff : std_logic_vector(7 downto 0) := (others => '0');
    signal edge_detected : std_logic;
begin
    
    detector: edge_detector
    port map(
        clk_i => clk_i,
        input => ps2_clk_i,
        edge => edge_detected
    );
    
    reciever : process(clk_i, rst_i)
        variable recieved_bits : integer := 0;
        variable delay_counter : integer := 0;
    begin
        if (rst_i = '1') then
           recieved_bits := 0;  
           delay_counter := 0;
           state <= waiting;    
        else
            if rising_edge (clk_i) then
            
                case state is
                
                    when WAITING =>
                    
                        if edge_detected = '1' then
                            state <= DELAY;
                        end if;
                        
                    when DELAY =>
                    
                        delay_counter := delay_counter + 1;
                        if delay_counter = READ_DELAY then
                            delay_counter := 0;
                            state <= READ_DATA;
                        end if;
                        
                    when READ_DATA =>
                    
                        ps2_packet_buff(recieved_bits) <= ps2_data_i;
                        recieved_bits := recieved_bits + 1;
                        if recieved_bits >= 11 then
                            state <= DATA_READY;
                        else
                            state <= WAITING;
                        end if;
                        
                    when DATA_READY =>
                    
                        if ps2_packet_buff(8 downto 1) /= BRAKE_SYMBOL then
                            ps2_data_buff <= ps2_packet_buff(8 downto 1);
                            recieved_bits := 0;
                        end if;
                        state <= WAITING;
                        
                    when others =>
                    
                        state <= waiting;
                        
                end case;    
            end if;
        end if;
    end process reciever;
    
    ps2_data_byte <= ps2_data_buff;
    
end Behavioral;
