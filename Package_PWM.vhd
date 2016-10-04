----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date: 03.10.2016 16:59:37
-- Design Name: 
-- Module Name: Package_PWM - Behavioral
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

package Package_PWM is

    component Package_PWM is
        Generic(
               --If this is set to 1 then a minimum duty cycle is enforced.
                minimum_duty_cycle_true  : in STD_LOGIC;
        
               --These take values of 0-255, a value of 127 will be cause the corresponding LED to be on for 50% of the time
                time_on_R_1    : in integer;
                time_on_G_1    : in integer;
                time_on_B_1    : in integer;
                time_on_R_2    : in integer;
                time_on_G_2    : in integer;
                time_on_B_2    : in integer;
                time_on_R_3    : in integer;
                time_on_G_3    : in integer;
                time_on_B_3    : in integer;
            
                --Number of cycles of the clk to count through (e.g 256 kHz=390.625)
                slow_clk_length    : in integer
                );
        Port( 
            reset       : in STD_LOGIC;
            clk         : in STD_LOGIC;
        
            LED_R       : out STD_LOGIC_VECTOR(3 downto 0);
            LED_G       : out STD_LOGIC_VECTOR(3 downto 0);
            LED_B       : out STD_LOGIC_VECTOR(3 downto 0)
            );
    end component;

end package Package_PWM;
