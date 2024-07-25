
-- ============================================================================
--	Developer: A.H.
--  I2C (MAX 10 via an I2C stack API communicates (reads/writes) with CY8CMBR3102 IC to read 2 capacitive touch switches) 
--  This is a design to be implemented on MAX10 FPGA 
-- ============================================================================

library IEEE;
use IEEE.std_logic_1164.all;
use IEEE.numeric_std.all;
use ieee.std_logic_unsigned.all;
use ieee.std_logic_arith.all;

entity P011_I2CCapacitiveTouch is
port(
	-- CLOCK 
	in_CLK1_50		: in std_logic;
	in_CLK2_50		: in std_logic;

	-- LED 
	out_LED					: out std_logic_vector(7 downto 0) := (others => '1');

	-- CapSense Button
	CAP_SENSE_I2C_SCL	: inout std_logic;
	CAP_SENSE_I2C_SDA	: inout std_logic
	);
end;

architecture rtl of P011_I2CCapacitiveTouch is
	-- Internal signal declaration goes HERE
	
	-- SIGNALs
	signal CK50_1_1HZ		: std_logic;
	signal CK50_2_1HZ		: std_logic;
	signal button_0		: std_logic;
	signal button_1		: std_logic;

	--CLOCK TEST
	component CLOCKMEM is 
		port(
			CLK			: in std_logic;
			CLK_FREQ	   : in std_logic_vector(31 downto 0);
			CK_1HZ		: inout std_logic 
		);
	end component;

	--CAPSENSE TEST--
	component CAPSENSE_BUTTON is 
		port(
			clk        : in std_logic;
			reset_n    : in std_logic;
			low_active : in std_logic; 
			button_0   : out std_logic;
			button_1   : out std_logic;
			i2c_scl    : out std_logic;
			i2c_sda    : inout std_logic
		);
	end component;

begin
		C2: CLOCKMEM
		port map(  
			CLK 			=> in_CLK1_50,
			CLK_FREQ 	=> x"02FAF080",
			CK_1HZ 		=> CK50_1_1HZ   
		);

		C3: CLOCKMEM
		port map(  
			CLK 			=> in_CLK2_50,
			CLK_FREQ 	=> x"02FAF080",
			CK_1HZ 		=> CK50_2_1HZ  
		);

		ip: CAPSENSE_BUTTON
		port map(
			clk         => in_CLK1_50,
			reset_n     => '1',
			low_active  => '1', 
			button_0    => button_0,
			button_1    => button_1,
			i2c_scl     => CAP_SENSE_I2C_SCL,
			i2c_sda     => CAP_SENSE_I2C_SDA
		);

	--OUTPUT LED --
	out_LED(7 downto 0) <= x"FF" XOR (button_1 & button_1 & CK50_2_1HZ & CK50_2_1HZ & CK50_1_1HZ & CK50_1_1HZ & button_0 & button_0);

end rtl;
