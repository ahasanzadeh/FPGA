-- ============================================================================
--	Developer: A.H.
-- ============================================================================

library IEEE;
use IEEE.std_logic_1164.all;
use IEEE.numeric_std.all;
--use ieee.std_logic_unsigned.all;
--use ieee.std_logic_arith.all;
  
entity P000_Multiplexer is
	port( 

    Clk    : in std_logic; 

    nRst   : in std_logic; -- Negative reset 

    Input  : in std_logic; 

    Output : out std_logic); 

end entity; 

   

architecture rtl of P000_Multiplexer is 

begin 

   

    -- Flip-flop with synchronized reset 

    process(Clk) is 

    begin 

   

        if rising_edge(Clk) then 

            if nRst = '0' then 

                Output <= '0'; 

            else 

                Output <= Input; 

            end if; 

        end if; 

   

    end process; 

   

end architecture; 
