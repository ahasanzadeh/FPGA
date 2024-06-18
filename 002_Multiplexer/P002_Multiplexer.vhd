-- ============================================================================
--	Developer: A.H.
--  Multiplexer 
--  This is a design to be simulated by ModelSim 
-- ============================================================================

library IEEE;
use IEEE.std_logic_1164.all;
use IEEE.numeric_std.all;
--use ieee.std_logic_unsigned.all;
--use ieee.std_logic_arith.all;
  
entity P002_Multiplexer is
generic(
	-- CONSTANTs
	dataWidth : integer := 8
);
port(
	-- INPUTs
	in_sig1_MUX4to1 : in unsigned((dataWidth - 1) downto 0);
	in_sig2_MUX4to1 : in unsigned((dataWidth - 1) downto 0);
	in_sig3_MUX4to1 : in unsigned((dataWidth - 1) downto 0);
	in_sig4_MUX4to1 : in unsigned((dataWidth - 1) downto 0);
	in_sel_MUX4to1  : in unsigned(1 downto 0);
	
	-- OUTPUTs
	out_sig_MUX4to1 : out unsigned((dataWidth - 1) downto 0)
	);
end entity;

architecture rtl of P002_Multiplexer is
	-- Internal signal declaration goes HERE
	
	-- SIGNALs
	
	-- REGISTERs
	
begin
	-- Process 
	-- Additional details:

	process(in_sel_MUX4to1, in_sig1_MUX4to1, in_sig2_MUX4to1, in_sig3_MUX4to1, in_sig4_MUX4to1) is
		-- Internal variables declaration goes HERE
	begin
		case in_sel_MUX4to1 is 
			when "00" =>
				out_sig_MUX4to1 <= in_sig1_MUX4to1;
			when "01" =>
				out_sig_MUX4to1 <= in_sig2_MUX4to1;
			when "10" =>
				out_sig_MUX4to1 <= in_sig3_MUX4to1;
			when "11" =>
				out_sig_MUX4to1 <= in_sig4_MUX4to1;
			when others => --'U', 'X', '-', etc.
				out_sig_MUX4to1 <= (others => 'X');
		end case;
	end process;

end architecture;