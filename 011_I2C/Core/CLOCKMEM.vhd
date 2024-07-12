library IEEE;
use IEEE.std_logic_1164.all;
use IEEE.numeric_std.all;
use ieee.std_logic_unsigned.all;
use ieee.std_logic_arith.all;

entity CLOCKMEM is
port(
	CLK		: in std_logic;
	CLK_FREQ	: in std_logic_vector(31 downto 0);
	CK_1HZ	: inout std_logic 
);
end;

architecture rtl of CLOCKMEM is

-- 50MHZ CLOCK1 TEST
	signal CLK_DELAY		: std_logic_vector(31 downto 0) register;

begin
	process(CLK)
	begin
		if (rising_edge(CLK)) then
			if (CLK_DELAY > ('0' & CLK_FREQ(31 downto 1))) then
				CLK_DELAY <= (others => '0');  
				CK_1HZ    <= not CK_1HZ ;
			else
				CLK_DELAY <= CLK_DELAY + 1;
			end if;
		end if;
	end process;
end rtl;
	
	