-- ============================================================================
--	Developer: A.H.
-- ============================================================================

library IEEE;
use IEEE.std_logic_1164.all;
use IEEE.numeric_std.all;
--use ieee.std_logic_unsigned.all;
--use ieee.std_logic_arith.all;
  
entity P000_Multiplexer_TB is
end entity;
  
architecture sim of P000_Multiplexer_TB is

    --CONSTANTs
    constant dataWidth : integer := 8;
    
    -- INPUTs
    signal in_sig1_MUX4to1 : unsigned((dataWidth - 1) downto 0) := x"AA";
    signal in_sig2_MUX4to1 : unsigned((dataWidth - 1) downto 0) := x"BB";
    signal in_sig3_MUX4to1 : unsigned((dataWidth - 1) downto 0) := x"CC";
    signal in_sig4_MUX4to1 : unsigned((dataWidth - 1) downto 0) := x"DD";
  
    signal in_sel_MUX4to1  : unsigned(1 downto 0) := (others => '0');
    
    -- OUTPUTs
    signal out_sig_MUX4to1 : unsigned((dataWidth - 1) downto 0);
  
begin
  
    -- An instance of P000_Multiplexer with architecture rtl
    i_Multiplexer : entity work.P000_Multiplexer(rtl) 
    generic map(
        dataWidth       => dataWidth
    )
    port map(
        in_sel_MUX4to1  => in_sel_MUX4to1,
        in_sig1_MUX4to1 => in_sig1_MUX4to1,
        in_sig2_MUX4to1 => in_sig2_MUX4to1,
        in_sig3_MUX4to1 => in_sig3_MUX4to1,
        in_sig4_MUX4to1 => in_sig4_MUX4to1,
        out_sig_MUX4to1 => out_sig_MUX4to1
        );
  
    -- Testbench process
    process is
    begin
        wait for 10 ns;
        in_sel_MUX4to1 <= in_sel_MUX4to1 + 1;
        wait for 10 ns;
        in_sel_MUX4to1 <= in_sel_MUX4to1 + 1;
        wait for 10 ns;
        in_sel_MUX4to1 <= in_sel_MUX4to1 + 1;
        wait for 10 ns;
        in_sel_MUX4to1 <= in_sel_MUX4to1 + 1;
        wait for 10 ns;
        in_sel_MUX4to1 <= "UU";
        wait;
    end process;
  
end architecture;