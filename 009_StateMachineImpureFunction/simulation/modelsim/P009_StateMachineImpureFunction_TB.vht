-- ============================================================================
--	Developer: A.H.
--  State Machine 
--  Testbench
-- ============================================================================

library IEEE;
use IEEE.std_logic_1164.all;
use IEEE.numeric_std.all;
--use ieee.std_logic_unsigned.all;
--use ieee.std_logic_arith.all;
  
entity P009_StateMachineImpureFunction_TB is 
end entity; 

architecture sim of P009_StateMachineImpureFunction_TB is 

    -- Slow down clock frequency to speed up the simulation 
    constant ci_ClockFrequencyHz : integer := 100; -- 100 Hz 
    constant ct_ClockPeriod : time := 1000 ms / ci_ClockFrequencyHz; 

	-- INPUTs   
    signal in_CLK1_50   : std_logic := '1'; 
    signal in_Switch1   : std_logic := '0'; 

    -- OUTPUTs
    signal out_LED      : std_logic_vector(7 downto 0) := (others => '1');
 
begin 
    -- The Device Under Test (DUT) 
    -- An instance of P009_StateMachineImpureFunction with architecture rtl
    i_TrafficLights : entity work.P009_StateMachineImpureFunction(rtl) 

    generic map(ci_ClockFrequencyHz => ci_ClockFrequencyHz) 

    port map ( 

    in_CLK1_50  => in_CLK1_50, 
    in_Switch1  => in_Switch1, 
    out_LED     => out_LED); 

    -- Process for generating clock 
    in_CLK1_50 <= not in_CLK1_50 after ct_ClockPeriod / 2; 

    -- Testbench process 
    process is 
    begin 
        wait until rising_edge(in_CLK1_50); 
        wait until rising_edge(in_CLK1_50); 

        -- Take the DUT out of reset 
        in_Switch1 <= '1'; 

        wait; 
    end process; 

end architecture; 