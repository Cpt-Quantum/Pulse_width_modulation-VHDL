----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date: 03.10.2016 16:45:01
-- Design Name: 
-- Module Name: PWM_Counter - Behavioral
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

entity PWM_Counter is
    Port(
        reset   : in STD_LOGIC;
        clk     : in STD_LOGIC;
        inc     : in STD_LOGIC;
        clear   : in STD_LOGIC;
        count_to   : in integer;
        count_done  : out STD_LOGIC
        );
end PWM_Counter;

architecture Behavioral of PWM_Counter is
signal internal_count : STD_LOGIC_VECTOR(7 downto 0);
begin
    
    PWM_Counter_proc : process(clk)
        begin
            if rising_edge(clk) then
                --Reset or clear state
                if reset = '1' or clear = '1' then
                    internal_count <= (others=>'0');
                    count_done <= '1';
                end if;
                --Count when signalled
                if inc = '1' then
                    internal_count <= internal_count + 1;
                end if;
                --Send out signal when desired count is reached
                if internal_count = STD_LOGIC_VECTOR(to_unsigned(count_to,8)) then
                    count_done <= '1';
                end if;                
            end if; --clk edge if
        end process PWM_Counter_proc;

end Behavioral;
