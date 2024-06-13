-- ============================================================================
--	Developer: A.H.
--  LED blinking 
--  This is a design to be implemented on MAX10 FPGA 
-- ============================================================================

library IEEE;
use IEEE.std_logic_1164.all;
use IEEE.numeric_std.all;
use ieee.std_logic_unsigned.all;
use ieee.std_logic_arith.all;

entity P001_LEDBlinking is
port(
	-- INPUTS
	in_CLK1_50 : in std_logic := '0';
	
	-- OUTPUTs
	out_LED : out std_logic_vector(7 downto 0) := (others => '0')
	);
end;

architecture rtl of P001_LEDBlinking is
	-- Internal signal declaration goes HERE
	
	-- SIGNALs
	
	-- REGISTERs
	signal sr_Counter : std_logic_vector(26 downto 0) register;
	signal sr_Display : std_logic_vector(7 downto 0) register;
	
begin
	-- Process 
	-- Additional details:

	process(in_CLK1_50)
	begin
		if(rising_edge(in_CLK1_50)) then
			sr_Counter   <= sr_Counter + 1;
			if(sr_Counter(26) = '1') then
				sr_Counter    <= (others => '0');
				sr_Display(0) <= not sr_Display(0);
				sr_Display(1) <= not sr_Display(0);
				sr_Display(2) <= not sr_Display(0);
				sr_Display(3) <= not sr_Display(0);
				sr_Display(4) <= not sr_Display(0);
				sr_Display(5) <= not sr_Display(0);
				sr_Display(6) <= not sr_Display(0);
				sr_Display(7) <= not sr_Display(0);
			enD if;
		end if;
	end process;

	LEDout_LED(7 downto 0) <= sr_Display(7 downto 0);

end rtl;