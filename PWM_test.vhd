----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date: 05.10.2016 16:30:10
-- Design Name: 
-- Module Name: PWM_test - Behavioral
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

library work;
use work.Package_PWM.all;

entity PWM_test is
    Port(
        clk     : in STD_LOGIC;
        
        switches_1  : in STD_LOGIC_VECTOR(7 downto 0);
        switches_2  : in STD_LOGIC_VECTOR(3 downto 0);
        
        LEDS_1      : out STD_LOGIC_VECTOR(7 downto 0);
        LEDS_2      : out STD_LOGIC_VECTOR(3 downto 0);
        
        LED_R   : out STD_LOGIC_VECTOR(3 downto 0);
        LED_G   : out STD_LOGIC_VECTOR(3 downto 0);
        LED_B   : out STD_LOGIC_VECTOR(3 downto 0)
        );
end PWM_test;

architecture Behavioral of PWM_test is
    signal reset : STD_LOGIC;
begin

    --Reset block
    reset_proc : process(clk)
        begin
            if rising_edge(clk) then
                if switches_2(0) = '1' then
                    reset <= '1';
                else 
                    reset <= '0';
                end if;
            end if;--clk edge if
        end process reset_proc;
    --End of reset block

    --Instantiate the PWM module
    PWM_0 : PWM
        Generic map(
                    duty_cycle => 512,
                    duty_cycle_count_size => 11,
                    
                    time_on_R_0 => 128,
                    time_on_G_0 => 128,
                    time_on_B_0 => 0,
                    time_on_R_1 => 128,
                    time_on_G_1 => 0,
                    time_on_B_1 => 128,
                    time_on_R_2 => 0,
                    time_on_G_2 => 128,
                    time_on_B_2 => 128,
                    time_on_R_3 => 128,
                    time_on_G_3 => 128,
                    time_on_B_3 => 64,
                    
                    slow_clk_length => 390,
                    slow_clk_size => 12
                    )
        Port map(
                reset => reset,
                clk => clk,
                
                LED_R => LED_R,
                LED_G => LED_G,
                LED_B => LED_B
                );
    --End of PWM module instatiation
    
    --Tie all LEDs other than RGB to 0
    LEDS_1 <= (others=>'0');
    LEDS_2 <= (others=>'0');
end Behavioral;
