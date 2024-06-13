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

entity P006_PWM is
port(
	-- INPUTS
	in_CLK1_50 : in std_logic := '0';

	KEY : in std_logic_vector(1 downto 0) := (others => '0');
	
	-- OUTPUTs
	out_LED : out std_logic_vector(7 downto 0) := (others => '0')
	);
end;

architecture rtl of P006_PWM is
	-- Internal signal declaration goes HERE
	
	-- SIGNALs
	signal reset_n  : std_logic;
	
	-- REGISTERs
	signal counter : std_logic_vector(26 downto 0) register;
	signal PWM_adj : std_logic_vector(5 downto 0) register;
	signal PWM_width : std_logic_vector(6 downto 0) register;
	signal display : std_logic_vector(7 downto 0) register;
begin
	-- Process
	-- Additional details:

	reset_n <= KEY(0);
	process(MAX10_CLK1_50)--, reset_n)
	begin
		if(rising_edge(MAX10_CLK1_50)) then
			if(reset_n = '0') then
				counter <= ( others => '0' );
				display <= ( others => '1' );
			else
				counter   <= counter + 1;
				PWM_width(6 downto 0) <= ('0' & PWM_width(5 downto 0)) + ('0' & PWM_adj(5 downto 0));
				if(counter(26) = '1') then
					PWM_adj(5 downto 0) <= counter(25 downto 20);
				else
					PWM_adj(5 downto 0) <= not counter(25 downto 20);
				end if;
				display(0) <= not PWM_width(6);
				display(1) <= not PWM_width(6);
				display(2) <= not PWM_width(6);
				display(3) <= not PWM_width(6);
				display(4) <= PWM_width(6);
				display(5) <= PWM_width(6);
				display(6) <= PWM_width(6);
				display(7) <= PWM_width(6);
			end if;
		end if;
	end process;

	LED(7 downto 0) <= display(7 downto 0);

end rtl;