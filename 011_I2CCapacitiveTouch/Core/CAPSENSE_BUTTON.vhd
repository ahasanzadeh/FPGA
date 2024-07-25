library IEEE;
use IEEE.std_logic_1164.all;
use IEEE.numeric_std.all;
use ieee.std_logic_unsigned.all;
use ieee.std_logic_arith.all;

entity CAPSENSE_BUTTON is
port(
	clk		   	: in std_logic;
	reset_n	   	: in std_logic;
	low_active	: in std_logic; --button_x is low-active?

	button_0	: out std_logic;
	button_1	: out std_logic;

	i2c_scl		: out std_logic;
	i2c_sda	   	: inout std_logic 
);
end;

architecture rtl of CAPSENSE_BUTTON is

-- 50MHZ CLOCK1 TEST
	signal F_STAT_Reg		: std_logic_vector(15 downto 0) register;

	--CAP_CTRL TEST--
	component CAP_CTRL is 
		port(
			RESET_N        : in std_logic;
			CLK_50    : in std_logic;
			CAP_SENSE_I2C_SCL : out std_logic; 
			CAP_SENSE_I2C_SDA   : inout std_logic;
			SW_ACTIVE_POLARITY   : in std_logic;
			F_STAT    : out std_logic_vector(15 downto 0);
			SW_PROX_EN    : in std_logic_vector(15 downto 0)
		);
	end component;
	
begin

	rt1: CAP_CTRL
	port map(
		RESET_N 					=> reset_n,
		CLK_50  					=> clk,
		CAP_SENSE_I2C_SCL		=> i2c_scl,
		CAP_SENSE_I2C_SDA		=> i2c_sda,	
		SW_ACTIVE_POLARITY	=> low_active,
		F_STAT 	=> F_STAT_Reg,
		SW_PROX_EN        	=> (others => '0')
	);

	button_0 <= F_STAT_Reg(0);
	button_1 <= F_STAT_Reg(1);

end rtl;







