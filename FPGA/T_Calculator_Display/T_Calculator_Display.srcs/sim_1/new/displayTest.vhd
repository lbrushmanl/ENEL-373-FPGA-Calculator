----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date: 20.03.2022 18:25:35
-- Design Name: 
-- Module Name: displayTest - Behavioral
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

entity displayTest is
--  Port ( );
end displayTest;

architecture Behavioral of displayTest is

component T_Calculator_Display
Port (BTNC : STD_LOGIC;
          SW : in STD_LOGIC_VECTOR(11 downto 0);
          C : out STD_LOGIC_VECTOR (6 downto 0);
          AN : out std_logic_vector (0 to 7);
          CLK100MHZ : in STD_LOGIC
         );
 end component;

signal SW: std_logic_vector(0 to 11);
signal C: STD_LOGIC_VECTOR (6 downto 0);
signal A: std_logic_vector (0 to 7);
signal BTNC: std_logic;
signal CLK100MHZ: std_logic;
signal ClockPeriod : TIME := 50 ns; 

begin

UUT: T_Calculator_Display port map(CLK100MHZ => CLK100MHZ, BTNC => '1', SW => SW,
 C => C); 

process

 begin
 SW <= "000011000000";
 wait for 5 ns;
 SW <= "000000001110";
 --wait for 1000 ms;
 --SW <= "0000000000000010";
 wait;
 end process;

end Behavioral;
