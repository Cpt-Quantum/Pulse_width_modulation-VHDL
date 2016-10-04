----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date: 27.09.2016 16:02:04
-- Design Name: 
-- Module Name: Counter - Behavioral
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
use IEEE.NUMERIC_STD.ALL;

-- Uncomment the following library declaration if instantiating
-- any Xilinx leaf cells in this code.
--library UNISIM;
--use UNISIM.VComponents.all;

entity Counter is
    Generic(Counter_size : in integer);
    Port(
        reset   : in STD_LOGIC;
        clk     : in STD_LOGIC;
        clear   : in STD_LOGIC;
        inc     : in STD_LOGIC;
        count   : out STD_LOGIC_VECTOR(Counter_size downto 0)
        );
end Counter;

architecture Behavioral of Counter is
signal internal_count   : STD_LOGIC_VECTOR(Counter_size downto 0);
begin

    Counter_proc : process (clk)
        begin
            if rising_edge(clk) then
                if reset = '1' or clear = '1' then
                    internal_count <= (others=>'0');
                end if;
                
                if inc = '1' then
                internal_count <= internal_count+1;
                end if;
            end if; --clk edge if
        end process Counter_proc;

end Behavioral;
