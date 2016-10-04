----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date: 03.10.2016 16:37:01
-- Design Name: 
-- Module Name: Package_PWM_Counter - Behavioral
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

package Package_PWM_Counter is

component PWM_Counter is
    Port(
        reset   : in STD_LOGIC;
        clk     : in STD_LOGIC;
        inc     : in STD_LOGIC;
        count_to   : in integer;
        count_done  : out STD_LOGIC
    );
end component;

end package Package_PWM_Counter;


