library IEEE;
use IEEE.std_logic_1164.all;
use IEEE.numeric_std.all;

entity counter is
    port (
        clk      : in std_logic;
        count    : out std_logic_vector (3 downto 0);
        overflow : out std_logic);
end counter;

architecture Behavioral of counter is
    constant MAX_COUNT : integer := 9;
begin
    process (clk)
        variable counter : integer range 0 to MAX_COUNT := 0;
    begin
        if rising_edge(clk) then
            if counter = MAX_COUNT then
                -- Reset counter and assert overflow
                counter := 0;
                ----assert overflow here--
                overflow <= '1';
            else
                -- Increment counter and reset overflow
                counter := counter + 1;
              --reset overflow here---
                overflow <= '0';
            end if;

            -- Convert value of counter to std_logic_vector
            count <= std_logic_vector(to_unsigned(counter, count'length));
        end if;
    end process;
end Behavioral;