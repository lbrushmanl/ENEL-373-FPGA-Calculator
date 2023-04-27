----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date: 03.03.2022 11:46:22
-- Design Name: 
-- Module Name: Seg_Display - Behavioral
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

entity Seg_Display is
    Port ( SW : in STD_LOGIC_VECTOR (3 downto 0);
           C: out STD_LOGIC_VECTOR (6 downto 0);
           AN: out std_logic_vector (7 downto 0);
           LED : out STD_LOGIC_VECTOR  (15 downto 0);
           CLK100MHZ : in STD_LOGIC);
end Seg_Display;

architecture Behavioral of Seg_Display is

signal clk_div, clk_mux, overflow : std_logic;
signal count, count_1, count_2 : std_logic_vector (3 downto 0);

begin

divider : entity work.clk_divider
    generic map (
        FREQ_OUT => 1)
    port map (
        clk_in => CLK100MHZ,
        clk_out => clk_div);
    
mux_divider : entity work.clk_divider
    generic map (
        FREQ_OUT => 100)
    port map (
        clk_in => CLK100MHZ,
        clk_out => clk_mux);

counter_1 : entity work.counter
    port map (
        clk => clk_div,
        count => count_1,
        overflow => overflow);

counter_2 : entity work.counter
    port map (
        clk => overflow,
        count => count_2);

bdc: entity work.BCD_to_7SEG
    port map(
        bcd_in => count,
        leds_out => C);

count <= count_1 when clk_mux = '0' else count_2;
AN <= "11111110" when clk_mux = '0' else "11111101";

LED(0) <= clk_div;

end Behavioral;
