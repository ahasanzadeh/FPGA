-- ============================================================================
--	Developer: A.H.
--  Timer with if/else: Counts seconds, minutes, and hours 
--  This is a design to be simulated by ModelSim, and implemented on MAX10 FPGA
-- ============================================================================

library IEEE;
use IEEE.std_logic_1164.all;
use IEEE.numeric_std.all;
use ieee.std_logic_unsigned.all;
use ieee.std_logic_arith.all;

entity P004_TimerIfElse is
    generic(ci_ClockFrequencyHz : integer := 50000000); -- 50MHz
    port( 
        -- INPUTs
        in_CLK1_50      : in std_logic; 
        in_PushButton1  : in std_logic; -- Avtive low reset 

        -- INOUTs
        in_Seconds      : inout integer; 
        in_Minutes      : inout integer; 
        in_Hours        : inout integer; 

        -- OUTPUTs
        out_LED         : out std_logic_vector(7 downto 0) := (others => '1')
        );
end entity; 

architecture rtl of P004_TimerIfElse is 
	-- Internal signal declaration goes HERE 
    signal s_Ticks : integer; 

    -- Procedure declaration goes HERE 

    -- Architecture begins here
begin 
	-- Process 
    -- Timer: Counts seconds, minutes, and hours 
    process(in_CLK1_50) is 
		-- Internal variables declaration goes HERE
    begin 
        if rising_edge(in_CLK1_50) then 
            -- Waiting for active low of reset signal
            if in_PushButton1   = '0' then 
                s_Ticks     <= 0; 
                in_Seconds  <= 0; 
                in_Minutes  <= 0; 
                in_Hours    <= 0; 
            else          
                -- True once every second 
                if s_Ticks = ci_ClockFrequencyHz - 1 then 
                    s_Ticks <= 0; 
                    -- True once every minute 
                    if in_Seconds = 59 then 
                        in_Seconds <= 0; 
                        -- True once every hour 
                        if in_Minutes = 59 then 
                            in_Minutes <= 0; 
                            -- True once a day 
                            if in_Hours = 23 then 
                                in_Hours <= 0; 
                            else 
                                in_Hours <= in_Hours + 1; 
                            end if; 
                        else 
                            in_Minutes <= in_Minutes + 1; 
                        end if; 
                    else 
                        in_Seconds <= in_Seconds + 1; 
                    end if; 
                else 
                    s_Ticks <= s_Ticks + 1; 
                end if; 
            end if; 
        end if; 
    end process; 

    -- Assigning integer to std_logic_vector
    out_LED <= not conv_std_logic_vector(in_Seconds, out_LED'length);    
    
end architecture;