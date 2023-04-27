----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date: 17.03.2022 11:56:10
-- Design Name: 
-- Module Name: T_Calculator_Display - Behavioral
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

entity T_Calculator_Display is
    Port (BTNC : STD_LOGIC;
          BTNU : STD_LOGIC;
          SW : in STD_LOGIC_VECTOR(11 downto 0);
          C : out STD_LOGIC_VECTOR (0 to 6);
          AN : out std_logic_vector (0 to 7);
          CLK100MHZ : in STD_LOGIC
         );
end T_Calculator_Display;

architecture Behavioral of T_Calculator_Display is

--signal--for starting and reseting

--Temporary Switches
signal temp_reset : STD_LOGIC := '0';

--Real stuff
signal clk_mux_for_bcd : STD_LOGIC; --Clock for the Mux for the BCD display
signal bin_num : STD_LOGIC_VECTOR (11 downto 0);

signal bin_to_bcd_value : STD_LOGIC_VECTOR (27 downto 0); 
signal bcd_single_display : STD_LOGIC_VECTOR (3 downto 0);

signal counter : STD_LOGIC_VECTOR (0 to 1);


begin

AN(4 to 7) <= "1111";

bin_num <= SW;

bin_bcd: entity work.bin_to_bcd
    generic map (
        BCD_SIZE => 28,
        NUM_SIZE => 12
    )    
    port map (
        reset => BTNU,
        clock => CLK100MHZ,
        start => clk_mux_for_bcd,
        bin => bin_num,
        bcd => bin_to_bcd_value
    );


bcd: entity work.BCD_to_7SEG
    port map (
        bcd_in => bcd_single_display,
        leds_out => C);


mux_divider : entity work.clk_divider
    generic map (
        FREQ_OUT => 800)
    port map (
        clk_in => CLK100MHZ,
        clk_out => clk_mux_for_bcd);


mux_count : entity work.mux_counter
    port map (
        CLK => clk_mux_for_bcd,
        count => counter);


--process (bin_to_bcd_value)
--begin
--    if (bin_to_bcd_value(15 downto 12) > "0000") then
--        bin_to_bcd_value(11 downto 0) <= "101010111011";
--    end if;

--end process;


process (counter, bin_to_bcd_value)
begin
   case counter is
      when "00" => AN(0 to 3) <= "0111"; bcd_single_display <= bin_to_bcd_value(3 downto 0);
      when "01" => AN(0 to 3) <= "1011"; bcd_single_display <= bin_to_bcd_value(7 downto 4);
      when "10" => AN(0 to 3) <= "1101"; bcd_single_display <= bin_to_bcd_value(11 downto 8);
      when others => AN(0 to 3) <= "1110"; bcd_single_display <= bin_to_bcd_value(15 downto 12);
   end case;
end process;


end Behavioral;
