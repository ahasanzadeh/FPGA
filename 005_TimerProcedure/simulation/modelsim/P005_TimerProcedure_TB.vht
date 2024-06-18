-- ============================================================================
--	Developer: A.H.
--  Test in simulation environment for a timer with procedure 
--  Testbench for simulation of a timer with procedure 
-- ============================================================================

library IEEE;
use IEEE.std_logic_1164.all;
use IEEE.numeric_std.all;
use ieee.std_logic_unsigned.all;
use ieee.std_logic_arith.all;
  
entity P005_TimerProcedure_TB is 
end entity; 

architecture sim of P005_TimerProcedure_TB is 

    -- CONSTANTs
    -- Slow down the clock to speed up simulation time 
    constant ci_ClockFrequencyHz   : integer := 10; -- 10 Hz 
    constant ct_ClockPeriod        : time := 1000 ms / ci_ClockFrequencyHz; 

    -- INPUTs
    signal in_CLK1_50           : std_logic := '1'; 
    signal in_PushButton1       : std_logic := '0'; 
    signal in_Seconds           : integer; 
    signal in_Minutes           : integer; 
    signal in_Hours             : integer; 

    -- OUTPUTs
    signal out_LED      : std_logic_vector(7 downto 0) := (others => '1');

begin 

    -- The Device Under Test (DUT) 
    -- An instance of P005_TimerProcedure with architecture rtl
    i_Timer : entity work.P005_TimerProcedure(rtl) 
    generic map(ci_ClockFrequencyHz => ci_ClockFrequencyHz) 
    port map ( 
        in_CLK1_50      => in_CLK1_50, 
        in_PushButton1  => in_PushButton1, 
        in_Seconds      => in_Seconds, 
        in_Minutes      => in_Minutes, 
        in_Hours        => in_Hours,
        out_LED         => out_LED); 

    -- Process for generating clock 
    in_CLK1_50 <= not in_CLK1_50 after ct_ClockPeriod / 2; 

    -- Testbench process 
    process is 
    begin 
        wait until rising_edge(in_CLK1_50); 
        wait until rising_edge(in_CLK1_50); 

        -- Take the DUT out of reset 
        in_PushButton1 <= '1'; 

        wait; 
    end process; 

end architecture; 