-- ============================================================================
--	Developer: A.H.
--  Timer: Counts seconds, minutes, and hours 
--  This is a design to be simulated by ModelSim, and implemented on MAX10 FPGA
-- ============================================================================

library IEEE;
use IEEE.std_logic_1164.all;
use IEEE.numeric_std.all;
use ieee.std_logic_unsigned.all;
use ieee.std_logic_arith.all;

entity P005_TimerProcedure is
    generic(ci_ClockFrequencyHz : integer := 50000000); -- 50MHz
    port( 
        -- INPUTs
        in_CLK1_50      : in std_logic; 
        in_Switch1      : in std_logic; -- Avtive low reset 

        -- INOUTs
        in_Seconds      : inout integer; 
        in_Minutes      : inout integer; 
        in_Hours        : inout integer; 

        -- OUTPUTs
        out_LED         : out std_logic_vector(7 downto 0) := (others => '1')
        );
end entity; 

architecture rtl of P005_TimerProcedure is 
	-- Internal signal declaration goes HERE 
    signal si_Ticks    : integer; 

    -- Procedure declaration goes HERE 
    procedure p_IncrementWrap(signal   si_Counter   : inout integer; 
                            constant ci_WrapValue : in    integer; 
                            constant cb_Enable    : in    boolean; 
                            variable vb_Wrapped   : out   boolean) is 
    begin 
        vb_Wrapped := false; 
        if cb_Enable then 
            if si_Counter = ci_WrapValue - 1 then 
                vb_Wrapped := true; 
                si_Counter <= 0; 
            else 
                si_Counter <= si_Counter + 1; 
            end if; 
        end if; 
    end procedure; 

    -- Architecture begins here
begin 
	-- Process 
    -- Timer: Counts seconds, minutes, and hours 
    process(in_CLK1_50) is 
		-- Internal variables declaration goes HERE
        variable vb_Wrap : boolean; 
    begin 
        if rising_edge(in_CLK1_50) then 
            -- Waiting for active low of reset signal
            if in_Switch1 = '0' then 
                si_Ticks   <= 0; 
                in_Seconds <= 0; 
                in_Minutes <= 0; 
                in_Hours   <= 0; 
            else 
                -- Cascade counters 
                p_IncrementWrap(si_Ticks, ci_ClockFrequencyHz,    true, vb_Wrap); 
                p_IncrementWrap(in_Seconds,                60, vb_Wrap, vb_Wrap); 
                p_IncrementWrap(in_Minutes,                60, vb_Wrap, vb_Wrap); 
                p_IncrementWrap(in_Hours,                  24, vb_Wrap, vb_Wrap); 

            end if; 
        end if; 
    end process; 

    -- Assigning integer to std_logic_vector
    out_LED <= not conv_std_logic_vector(in_Seconds, out_LED'length);    
    
end architecture;