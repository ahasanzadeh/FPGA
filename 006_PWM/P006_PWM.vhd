-- ============================================================================
--	Developer: A.H.
--  PWM (a VHDL translation of LED breathe already exist Verilog example of this evaluation board) 
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
	in_CLK1_50		: in std_logic := '0';

	in_PushButton1	: in std_logic := '0';
	
	-- OUTPUTs
	out_LED			: out std_logic_vector(7 downto 0) := (others => '0')
	);
end;

architecture rtl of P006_PWM is
	-- Internal signal declaration goes HERE
	
	-- SIGNALs
	signal s_ResetN		: std_logic;
	
	-- REGISTERs
	signal sr_Counter		: std_logic_vector(26 downto 0) register;
	signal sr_PWMAdj		: std_logic_vector(5 downto 0) register;
	signal sr_PWMWidth	: std_logic_vector(6 downto 0) register;
	signal sr_Display		: std_logic_vector(7 downto 0) register;
begin
	-- Process
	-- Additional details:

	s_ResetN <= in_PushButton1;
	process(in_CLK1_50)--, reset_n)
	begin
		if(rising_edge(in_CLK1_50)) then
			if(s_ResetN = '0') then
				sr_Counter <= ( others => '0' );
				sr_Display <= ( others => '1' );
			else
				sr_Counter   <= sr_Counter + 1;
				sr_PWMWidth(6 downto 0) <= ('0' & sr_PWMWidth(5 downto 0)) + ('0' & sr_PWMAdj(5 downto 0));
				if(sr_Counter(26) = '1') then
					sr_PWMAdj(5 downto 0) <= sr_Counter(25 downto 20);
				else
					sr_PWMAdj(5 downto 0) <= not sr_Counter(25 downto 20);
				end if;
				sr_Display(0) <= not sr_PWMWidth(6);
				sr_Display(1) <= not sr_PWMWidth(6);
				sr_Display(2) <= not sr_PWMWidth(6);
				sr_Display(3) <= not sr_PWMWidth(6);
				sr_Display(4) <= sr_PWMWidth(6);
				sr_Display(5) <= sr_PWMWidth(6);
				sr_Display(6) <= sr_PWMWidth(6);
				sr_Display(7) <= sr_PWMWidth(6);
			end if;
		end if;
	end process;

	out_LED(7 downto 0) <= sr_Display(7 downto 0);

end rtl;