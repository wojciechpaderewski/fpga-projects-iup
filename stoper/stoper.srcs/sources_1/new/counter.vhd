library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.STD_LOGIC_UNSIGNED.ALL;

entity counter is
    Port(
        clk_i : in std_logic;
        rst_i : in std_logic;
        inhibit_i : in std_logic;
        count : out std_logic_vector(15 downto 0)
    );
end counter;

architecture Behavioral of counter is
    component FrequencyDivider
        generic(
            divider : integer
        ); 
        Port(
            clk_i : in STD_LOGIC;
            clk_out: out STD_LOGIC
        );             
    end component;

    signal divided_clk : std_logic;
    signal inhibited_clk : std_logic; 
    signal mut_count : std_logic_vector(15 downto 0);
begin

    divider : FrequencyDivider
    Generic Map(
        divider => 1000000
    )
    Port Map( 
        clk_i => inhibited_clk,
        clk_out => divided_clk 
    );
    counting : process(divided_clk, rst_i)
        begin
            if(rst_i = '1') then
                mut_count <= (others => '0');
            else
                if rising_edge(divided_clk) then
                    mut_count <= mut_count + 1;
                end if;
            end if;
    end process counting;
    
    count <= mut_count;
    
    inhibited_clk <= '0' when inhibit_i = '1' else clk_i;
end Behavioral;