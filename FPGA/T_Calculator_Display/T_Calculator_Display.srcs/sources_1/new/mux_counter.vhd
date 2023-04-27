----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date: 18.03.2022 12:07:24
-- Design Name: 
-- Module Name: Ring_Counter - Behavioral
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
use IEEE.STD_LOGIC_UNSIGNED.ALL;

-- Uncomment the following library declaration if using
-- arithmetic functions with Signed or Unsigned values
--use IEEE.NUMERIC_STD.ALL;

-- Uncomment the following library declaration if instantiating
-- any Xilinx leaf cells in this code.
--library UNISIM;
--use UNISIM.VComponents.all;

entity mux_counter is
    Port (CLK : in STD_LOGIC;
         count : out STD_LOGIC_VECTOR (1 downto 0));
end mux_counter;

architecture Behavioral of mux_counter is

signal counter : STD_LOGIC_VECTOR (1 downto 0) := "00" ;

begin

    process (CLK)
        begin
           if RISING_EDGE(CLK) then
                if counter = "11" then
                    counter <= "00";
                else 
                    counter <= counter + '1';
                end if;
           end if;
    end process;

count <= counter;

end Behavioral;
