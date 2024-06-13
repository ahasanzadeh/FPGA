-- ============================================================================
--	Developer: A.H.
--  LED on/off via push button 1 
--  This is a design to be implemented on MAX10 FPGA 
-- ============================================================================

library IEEE;
use IEEE.std_logic_1164.all;
use IEEE.numeric_std.all;
use ieee.std_logic_unsigned.all;
use ieee.std_logic_arith.all;

entity P000_LEDOnOff is
port(
	-- INPUTS
	in_PushButton1 : in std_logic := '0';
	
	-- OUTPUTs
	out_LED : out std_logic_vector(7 downto 0) := (others => '0')
	);
end;

architecture rtl of P000_LEDOnOff is
	-- Internal signal declaration goes HERE
	
	-- SIGNALs
	signal s_LEDOnOffPushPutton  : std_logic;
	
	-- REGISTERs
	signal sr_display : std_logic_vector(7 downto 0) register;
begin
	-- Process
	-- Additional details:

	s_LEDOnOffPushPutton <= in_PushButton1;
	process(s_LEDOnOffPushPutton)
	begin
		if(s_LEDOnOffPushPutton = '0') then
			sr_display(7 downto 0) <= (others => '0');
		else
			sr_display(7 downto 0) <= (others => '1');
		end if;
	end process;

	out_LED(7 downto 0) <= sr_display(7 downto 0);

end rtl;