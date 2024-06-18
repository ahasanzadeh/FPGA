-- ============================================================================
--	Developer: A.H.
--  Test in simulation environment for a clocked precess: Flip-Flop with synchronized reset 
--  Testbench for simulation of a clocked precess: Flip-Flop with synchronized reset
-- ============================================================================

library IEEE;
use IEEE.std_logic_1164.all;
use IEEE.numeric_std.all;
--use ieee.std_logic_unsigned.all;
--use ieee.std_logic_arith.all;
  
entity P003_FlipFlop_TB is 
end entity; 

architecture sim of P003_FlipFlop_TB is 

    --CONSTANTs
    constant ClockFrequency : integer := 100e6; -- 100 MHz 
    constant ClockPeriod    : time    := 1000 ms / ClockFrequency; 
     
    -- INPUTs
    signal in_CLK1_50       : std_logic := '1'; 
    signal in_Switch1       : std_logic := '0'; 
    signal in_PushButton1   : std_logic := '0'; 

    -- OUTPUTs
    signal out_LED1         : std_logic; 

begin 
    -- The Device Under Test (DUT) 
    -- An instance of P003_FlipFlop with architecture rtl
    i_FlipFlop : entity work.P003_FlipFlop(rtl) 
    port map( 
        in_CLK1_50      => in_CLK1_50, 
        in_Switch1      => in_Switch1, 
        in_PushButton1  => in_PushButton1, 
        out_LED1        => out_LED1
        ); 
  
    -- Process for generating the clock 
    in_CLK1_50 <= not in_CLK1_50 after ClockPeriod / 2; 

    -- Testbench process
    process is 
    begin 
        -- Take the DUT out of reset 
        in_Switch1 <= '1'; 

        wait for 20 ns; 
        in_PushButton1 <= '1'; 
        wait for 22 ns; 
        in_PushButton1 <= '0'; 
        wait for 6 ns; 
        in_PushButton1 <= '1'; 
        wait for 20 ns; 

        -- Reset the DUT 
        in_Switch1 <= '0'; 
    
        wait; 
    end process; 

end architecture; 