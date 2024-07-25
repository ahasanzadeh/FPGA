
-- ============================================================================
--	Developer: A.H.
--  SPI (MAX 10 via an SPI stack API communicates (reads/writes) with CY8CMBR3102 IC to read 2 capacitive touch switches) 
--  This is a design to be implemented on MAX10 FPGA 
-- ============================================================================

library IEEE;
use IEEE.std_logic_1164.all;
use IEEE.numeric_std.all;
use ieee.std_logic_unsigned.all;
use ieee.std_logic_arith.all;

entity P015_SPIMotionSensor is
port(
	-- CLOCK 
    in_CLK_ADC_10       : in std_logic;
	in_CLK1_50		    : in std_logic;
	in_CLK2_50		    : in std_logic;
	-- SW 
	in_SlidingSwitch    : in std_logic_vector(1 downto 0);
    --KEY 
    in_PushButton       : in std_logic_vector(1 downto 0);

	-- LED 
	out_LED				: out std_logic_vector(7 downto 0) := (others => '1');

	-- G-Sensor for SPI
	G_SENSOR_CS_n    : out std_logic; --SPI is LOW
	G_SENSOR_INT1    : in std_logic;  
	G_SENSOR_INT2    : in std_logic;
	G_SENSOR_SCLK    : inout std_logic; 
	G_SENSOR_SDI     : inout std_logic; --data to G-SENSOR  
	G_SENSOR_SDO	  : inout std_logic  --data from G-SENSOR  
	);
end;

architecture rtl of P015_SPIMotionSensor is
	-- Internal signal declaration goes HERE
	
	-- SIGNALs
    signal  OUT_X       : std_logic_vector(15 downto 0);
    signal  OUT_Y       : std_logic_vector(15 downto 0);
    signal  OUT_Z       : std_logic_vector(15 downto 0);
    signal  WHO_AM_I    : std_logic_vector(7 downto 0);
    signal  s_data_x    : std_logic_vector(16 downto 0);  
    signal  data_x      : std_logic_vector(16 downto 0);
    signal  led_out     : std_logic_vector(7 downto 0);
    signal  reset_n     : std_logic;
    signal  DATA_RDY    : std_logic;

	--CLOCK TEST
	component SPI_CTL is 
		port(
            DATA_RDY    :out std_logic register;
            RESET_N     :in std_logic; 
            CLK_50      :in std_logic;
            OUT_X       :out std_logic_vector(15 downto 0) register;
            OUT_Y       :out std_logic_vector(15 downto 0) register;
            OUT_Z       :out std_logic_vector(15 downto 0) register;
            WHO_AM_I    :out std_logic_vector(7 downto 0) register;
            CS          :out std_logic register;
            SCLK        :out std_logic register;
            DIN         :out std_logic register;
            DO          :in std_logic
		);
	end component;

	--CAPSENSE TEST--
	component led_driver is 
		port(
            iRSTN       :in std_logic;
            iCLK        :in std_logic;
            iDIG        :in std_logic_vector(9 downto 0);
            iG_INT2     :in std_logic;
            oLED        :out std_logic_vector(7 downto 0) register;
            fine_tune   :in std_logic
		);
	end component;

begin
    -- reset 
    reset_n <= in_PushButton(0); 
    
    --G-Sensor for SPI Controller   
    spi: SPI_CTL
    port map(  
        DATA_RDY                => DATA_RDY,
        RESET_N                 => reset_n, 
        CLK_50                  => in_CLK1_50, 
        OUT_X(15 downto 0)      => OUT_X(15 downto 0),
        OUT_Y(15 downto 0)      => OUT_Y(15 downto 0),
        OUT_Z(15 downto 0)      => OUT_Z(15 downto 0),
        WHO_AM_I(7 downto 0)    => WHO_AM_I(7 downto 0),
        CS                      => G_SENSOR_CS_n,
        SCLK                    => G_SENSOR_SCLK,
        DIN                     => G_SENSOR_SDI,
        DO                      => G_SENSOR_SDO 
    );
    

    --OUT_X : two’s complement left-justified.
    --s_data_x :Shift OUT_X to positive number
    s_data_x(16 downto 0)   <= x"8000" + ('0' & OUT_X(15 downto 0));
    data_x(11 downto 0)     <= s_data_x(15 downto 4); 

    --LED Processor
    u_led_driver: led_driver
    port map(
        iRSTN               => reset_n,
        iCLK                => in_CLK1_50,
        iDIG(9 downto 0)    => data_x(10 downto 1),
        iG_INT2             => DATA_RDY,
        oLED(7 downto 0)    => led_out(7 downto 0),
        fine_tune           => not in_PushButton(0) 
    );

	--OUTPUT LED --
	out_LED(7 downto 0) <= x"FF" XOR (led_out(0) & led_out(1) & led_out(2) & led_out(3)& led_out(4) & led_out(5) & led_out(6) & led_out(7));

end rtl;
