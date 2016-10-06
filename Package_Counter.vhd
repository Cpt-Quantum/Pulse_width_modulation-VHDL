----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date: 03.10.2016 16:08:19
-- Design Name: 
-- Module Name: Package_Counter - Behavioral
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

package Package_Counter is

    component Counter is
    Generic(Counter_size : in integer);
    Port(
        reset   : in STD_LOGIC;
        clk     : in STD_LOGIC;
        clear   : in STD_LOGIC;
        inc     : in STD_LOGIC;
        count   : out STD_LOGIC_VECTOR((Counter_size-1) downto 0)
        );
    end component;

end package Package_Counter;


