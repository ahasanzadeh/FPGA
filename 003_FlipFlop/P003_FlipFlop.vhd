-- ============================================================================
--	Developer: A.H.
--  Clocked precess: Flip-Flop with synchronized reset 
--  This is a design to be simulated by ModelSim, and implemented on MAX10 FPGA
-- ============================================================================

library IEEE;
use IEEE.std_logic_1164.all;
use IEEE.numeric_std.all;
--use ieee.std_logic_unsigned.all;
--use ieee.std_logic_arith.all;
  
entity P003_FlipFlop is
	port( 
	-- INPUTs
    in_CLK1_50      : in std_logic; 
    in_Switch1      : in std_logic; -- Avtive low reset 
    in_PushButton1  : in std_logic; -- Should be a pulse wave, but this push button is ued instead

	-- OUTPUTs
    out_LED1        : out std_logic
    );
end entity;    

architecture rtl of P003_FlipFlop is 
	-- Internal signal declaration goes HERE
	
	-- SIGNALs
	
	-- REGISTERs

    -- Architecture begins here
begin 
	-- Process 
    -- Flip-flop with synchronized reset 

    process(in_CLK1_50) is 
		-- Internal variables declaration goes HERE
    begin 
        if rising_edge(in_CLK1_50) then 
            -- Waiting for active low of reset signal
            if in_Switch1 = '0' then 
                out_LED1 <= '1'; 
            else 
                out_LED1 <= in_PushButton1; 
            end if; 
        end if; 
    end process; 

end architecture; 