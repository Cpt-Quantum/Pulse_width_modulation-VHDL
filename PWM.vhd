----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date: 27.09.2016 11:12:35
-- Design Name: 
-- Module Name: PWM - Behavioral
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
use IEEE.NUMERIC_STD.ALL;

-- Uncomment the following library declaration if instantiating
-- any Xilinx leaf cells in this code.
--library UNISIM;
--use UNISIM.VComponents.all;

library work;

use work.Package_Counter.all;
use work.Package_PWM_Counter.all;

entity PWM is
        Generic(
        --This sets the duty cycle of the PWM
        --The integer sets the number of slow_clk clears to count through
        --256 is one full cycle, this value needs to be at least 256 for the logic to function properly
        duty_cycle  : in integer;
        duty_cycle_count_size : in integer;
        
        --These take values of 0-255, a value of 127 will be cause the corresponding LED to be on for 50%
        -- of one standard PWM cycle
        time_on_R_0    : in integer;
        time_on_G_0    : in integer;
        time_on_B_0    : in integer;
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
        slow_clk_length    : in integer;
        --Variable to define size of slow_clk array 
        slow_clk_size      : in integer
        );
        
        Port( 
        reset       : in STD_LOGIC;
        clk         : in STD_LOGIC;
        
        LED_R       : out STD_LOGIC_VECTOR(3 downto 0);
        LED_G       : out STD_LOGIC_VECTOR(3 downto 0);
        LED_B       : out STD_LOGIC_VECTOR(3 downto 0)
        );

end PWM;

architecture Behavioral of PWM is
 
    --Signals for the slower clock used for PWM
    signal slow_clk_inc     : STD_LOGIC;
    signal slow_clk_clear   : STD_LOGIC;
    signal slow_clk_count   : STD_LOGIC_VECTOR((slow_clk_size-1) downto 0);
    
    --Signal to store PWM counter value
    signal PWM_count        : STD_LOGIC_VECTOR((duty_cycle_count_size-1) downto 0);
    --Signal to clear the counters for each LED/colour
    signal PWM_clear        : STD_LOGIC;
    
    --Signals for LED count done for each colour and LED
    signal LED_R_0          : STD_LOGIC;
    signal LED_G_0          : STD_LOGIC;
    signal LED_B_0          : STD_LOGIC;
    signal LED_R_1          : STD_LOGIC;
    signal LED_G_1          : STD_LOGIC;
    signal LED_B_1          : STD_LOGIC;
    signal LED_R_2          : STD_LOGIC;
    signal LED_G_2          : STD_LOGIC;
    signal LED_B_2          : STD_LOGIC;
    signal LED_R_3          : STD_LOGIC;
    signal LED_G_3          : STD_LOGIC;
    signal LED_B_3          : STD_LOGIC;
    
begin
    
    --Reset block

    --End of reset block
       
    --Slow clock generation block
    slow_clk_proc : process(clk)
        begin
            if rising_edge(clk) then
                slow_clk_inc <= '1';
                if slow_clk_count = STD_LOGIC_VECTOR(to_unsigned(slow_clk_length,slow_clk_size)) then
                    slow_clk_clear <= '1';
                else
                    slow_clk_clear <= '0';
                end if; 
                
                if reset = '1' then
                    slow_clk_clear <= '0';
                end if;
            end if; --clk edge if
        end process slow_clk_proc;
        
    slow_clk_counter : Counter
        Generic map(Counter_size => slow_clk_size)
        Port map(
                reset => reset,
                clk => clk,
                clear => slow_clk_clear,
                inc => slow_clk_inc,
                count => slow_clk_count
                );
    --End of slow clock block
    
    
    --PWM cycle block
    PWM_count_proc : process(clk)
        begin
            if rising_edge(clk) then
                if PWM_count = STD_LOGIC_VECTOR(to_unsigned(duty_cycle,duty_cycle_count_size)) then
                    PWM_clear <= '1';
                else
                    PWM_clear <= '0';
                end if;
            end if;--Clk edge if
        end process PWM_count_proc;
    --Instantiate a counter which increments on the slow clock clear signal
    PWM_cycle : Counter
        Generic Map(Counter_Size => duty_cycle_count_size)
        Port Map(
                reset => reset,
                clk => clk,
                clear => PWM_clear,
                inc => slow_clk_clear,                
                count => PWM_count
                );
    --End of PWM cycle block
    
    
    --Colour counter block
    --Instantiate a PWM_counter for each colour and LED
    LED_R_0_counter : PWM_Counter
        Generic Map(Counter_Size => 9)
        Port Map(
                reset => reset,
                clk => clk,
                inc => slow_clk_clear,
                clear => PWM_clear,
                count_to => time_on_R_0,
                count_done => LED_R_0
                );
    LED_G_0_counter : PWM_Counter
        Generic Map(Counter_Size => 9)
        Port Map(
                reset => reset,
                clk => clk,
                inc => slow_clk_clear,
                clear => PWM_clear,
                count_to => time_on_G_0,
                count_done => LED_G_0
                );
    LED_B_0_counter : PWM_Counter
        Generic Map(Counter_Size => 9)
        Port Map(
                reset => reset,
                clk => clk,
                inc => slow_clk_clear,
                clear => PWM_clear,
                count_to => time_on_B_0,
                count_done => LED_B_0
                );
    LED_R_1_counter : PWM_Counter
        Generic Map(Counter_Size => 9)
        Port Map(
                reset => reset,
                clk => clk,
                inc => slow_clk_clear,
                clear => PWM_clear,
                count_to => time_on_R_1,
                count_done => LED_R_1
                );
    LED_G_1_counter : PWM_Counter
        Generic Map(Counter_Size => 9)
        Port Map(
                reset => reset,
                clk => clk,
                inc => slow_clk_clear,
                clear => PWM_clear,
                count_to => time_on_G_1,
                count_done => LED_G_1
                );
    LED_B_1_counter : PWM_Counter
        Generic Map(Counter_Size => 9)
        Port Map(
                reset => reset,
                clk => clk,
                inc => slow_clk_clear,
                clear => PWM_clear,
                count_to => time_on_B_1,
                count_done => LED_B_1
                );
    LED_R_2_counter : PWM_Counter
        Generic Map(Counter_Size => 9)
        Port Map(
                reset => reset,
                clk => clk,
                inc => slow_clk_clear,
                clear => PWM_clear,
                count_to => time_on_R_2,
                count_done => LED_R_2
                );
    LED_G_2_counter : PWM_Counter
        Generic Map(Counter_Size => 9)
        Port Map(
                reset => reset,
                clk => clk,
                inc => slow_clk_clear,
                clear => PWM_clear,
                count_to => time_on_G_2,
                count_done => LED_G_2
                );
    LED_B_2_counter : PWM_Counter
        Generic Map(Counter_Size => 9)
        Port Map(
                reset => reset,
                clk => clk,
                inc => slow_clk_clear,
                clear => PWM_clear,
                count_to => time_on_B_2,
                count_done => LED_B_2
                );
    LED_R_3_counter : PWM_Counter
        Generic Map(Counter_Size => 9)
        Port Map(
                reset => reset,
                clk => clk,
                inc => slow_clk_clear,
                clear => PWM_clear,
                count_to => time_on_R_3,
                count_done => LED_R_3
                );
    LED_G_3_counter : PWM_Counter
        Generic Map(Counter_Size => 9)
        Port Map(
                reset => reset,
                clk => clk,
                inc => slow_clk_clear,
                clear => PWM_clear,
                count_to => time_on_G_3,
                count_done => LED_G_3
                );
    LED_B_3_counter : PWM_Counter
        Generic Map(Counter_Size => 9)
        Port Map(
                reset => reset,
                clk => clk,
                inc => slow_clk_clear,
                clear => PWM_clear,
                count_to => time_on_B_3,
                count_done => LED_B_3
                );
    --End of colour counter block
    
    --Assign and invert the states of the count_done signals to the LEDs
    assign_proc : process(clk)
        begin
            if reset= '1' then
                LED_R <= (others=>'0');
                LED_G <= (others=>'0');
                LED_B <= (others=>'0');
            else
                LED_R(0) <= not(LED_R_0);
                LED_G(0) <= not(LED_G_0);
                LED_B(0) <= not(LED_B_0);
                LED_R(1) <= not(LED_R_1);
                LED_G(1) <= not(LED_G_1);
                LED_B(1) <= not(LED_B_1);
                LED_R(2) <= not(LED_R_2);
                LED_G(2) <= not(LED_G_2);
                LED_B(2) <= not(LED_B_2);
                LED_R(3) <= not(LED_R_3);
                LED_G(3) <= not(LED_G_3);
                LED_B(3) <= not(LED_B_3);
            end if;
        end process assign_proc;
end Behavioral;
