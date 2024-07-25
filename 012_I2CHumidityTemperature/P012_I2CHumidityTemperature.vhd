
-- ============================================================================
--	Developer: A.H.
--  I2C (MAX 10 via an I2C stack API communicates (reads/writes) with HDC1000YPAR IC to read humidity and temperature) 
--  This is a design to be implemented on MAX10 FPGA 
-- ============================================================================

library IEEE;
use IEEE.std_logic_1164.all;
use IEEE.numeric_std.all;
use ieee.std_logic_unsigned.all;
use ieee.std_logic_arith.all;

entity P012_I2CHumidityTemperature is
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

	-- Humidity and Temperature Sensor //////////
	RH_TEMP_DRDY_n     :in std_logic;
	RH_TEMP_I2C_SCL     :inout std_logic;
	RH_TEMP_I2C_SDA     :inout std_logic
	);
end;

architecture rtl of P012_I2CHumidityTemperature is
	-- Internal signal declaration goes HERE
	
	-- SIGNALs
    --Humidity_Temperature Set 	
    signal CONFIGURATION_S  :std_logic_vector(15 downto 0);

    --Humidity_Temperature Result	
    signal DEVICE_ID        :std_logic_vector(15 downto 0);
    signal MANUFACTURER_ID  :std_logic_vector(15 downto 0);
    signal TEMP_CURRENT     :std_logic_vector(15 downto 0);   
    signal RH_CURRENT       :std_logic_vector(15 downto 0);

    --FOR SYSTEM RESET 	
    signal RESET_N          :std_logic;

    --I2C CLOCK --	
    signal CLK_400K         :std_logic;

    --FOR CLOCK TEST 	
    signal CK50_1_1HZ       :std_logic;
    signal CK50_2_1HZ       :std_logic;
    signal AD_1HZ           :std_logic;
    signal I2C_1HZ          :std_logic;

    --FOR SIGNALTAPEII	
    signal ST               :std_logic_vector(7 downto 0);
    signal CNT              :std_logic_vector(7 downto 0);
    signal W_WORD_END       :std_logic;
    signal W_WORD_GO        :std_logic;
    signal WORD_ST          :std_logic_vector(7 downto 0);
    signal WORD_CNT         :std_logic_vector(7 downto 0);
    signal WORD_BYTE        :std_logic_vector(7 downto 0);	
    signal R_DATA           :std_logic_vector(15 downto 0);
	 signal TEMP_CURRENT_S   :std_logic_vector(23 downto 0);
	 signal RH_CURRENT_S   	 :std_logic_vector(23 downto 0);

	--Humidity_Temperature	
	component RH_TEMP is 
		port(
            --SYSTEM--   
            RESET_N         :in std_logic;
            CLK_50          :in std_logic;
            --IC SIDE 
            RH_TEMP_DRDY_n  :in std_logic;  
            RH_TEMP_I2C_SCL :out std_logic;
            RH_TEMP_I2C_SDA :inout std_logic;  
            --Configuration
            Configuration_S :in std_logic_vector(15 downto 0);
            --Temperature
            Temperature     :out std_logic_vector(15 downto 0) register;
            --Humidity
            Humidity        :out std_logic_vector(15 downto 0) register; 
            --ID
            DeviceID        :out std_logic_vector(15 downto 0) register;
            ManufacturerID  :out std_logic_vector(15 downto 0) register;
            --FOR TEST
            CLK_400K        :out std_logic register;
            --I2C_LO0P        :out std_logic register;	
            ST              :out std_logic_vector(7 downto 0) register;
            CNT             :out std_logic_vector(7 downto 0) register;
            W_WORD_END      :out std_logic;
            W_WORD_GO       :out std_logic register;
            WORD_ST         :out std_logic_vector(7 downto 0);    
            WORD_CNT        :out std_logic_vector(7 downto 0);    
            WORD_BYTE       :out std_logic_vector(7 downto 0);    
            R_DATA          :out std_logic_vector(15 downto 0)	
		);
	end component;

	--FOR SIGNALTAPEII
	component TP is 
		port(
            I2C_SCL         :in std_logic;
            I2C_SDA         :in std_logic;  
            R_DATA          :in std_logic_vector(15 downto 0);
            WORD_ST         :in std_logic_vector(7 downto 0);
            WORD_CNT        :in std_logic_vector(7 downto 0);
            WORD_BYTE       :in std_logic_vector(7 downto 0);
            W_WORD_END      :in std_logic;
            W_WORD_GO       :in std_logic;
            RESET_N         :in std_logic;
            SYS_CLK         :in std_logic;
            ST              :in std_logic_vector(7 downto 0);
            CNT             :in std_logic_vector(7 downto 0);	
            Configuration_S :in std_logic_vector(15 downto 0);
            Temperature     :in std_logic_vector(15 downto 0);
            Humidity        :in std_logic_vector(15 downto 0); 
            Temperature_S   :in std_logic_vector(13 downto 0);
            Humidity_S      :in std_logic_vector(13 downto 0);      
            DeviceID        :in std_logic_vector(15 downto 0);
            ManufacturerID  :in std_logic_vector(15 downto 0);
            RH_TEMP_DRDY_n  :std_logic
		);
	end component;

begin
    -- RESET 
    RESET_N <= in_PushButton(0);

    --Power Monitor IC Connfiguration 
    CONFIGURATION_S <= x"1000";
    
    --Humidity_Temperature  
    ctl: RH_TEMP
    port map(  
        --SYSTEM--   
        RESET_N 			=> RESET_N,
        CLK_50              => in_CLK1_50,
        --IC SIDE 
        RH_TEMP_DRDY_n      => RH_TEMP_DRDY_n,   
        RH_TEMP_I2C_SCL     => RH_TEMP_I2C_SCL,
        RH_TEMP_I2C_SDA     => RH_TEMP_I2C_SDA,  
        --Configuration
        Configuration_S     => CONFIGURATION_S,
        --Temperature
        Temperature         => TEMP_CURRENT, 
        --Humidity
        Humidity            => RH_CURRENT, 
        --ID
        DeviceID            => DEVICE_ID,
        ManufacturerID      => MANUFACTURER_ID,
        --FOR TEST
        CLK_400K            => CLK_400K,
        --I2C_LO0P            => I2C_LO0P,	
        ST                  => ST,
        CNT                 => CNT ,
        W_WORD_END          => W_WORD_END,
        W_WORD_GO           => W_WORD_GO,
        WORD_ST             => WORD_ST,
        WORD_CNT            => WORD_CNT,
        WORD_BYTE           => WORD_BYTE,
        R_DATA              => R_DATA	
    );

	TEMP_CURRENT_S <= TEMP_CURRENT * std_logic_vector(to_unsigned(165, 8));
	RH_CURRENT_S <= RH_CURRENT * std_logic_vector(to_unsigned(100, 8));
	
    --FOR SIGNALTAPEII
    t: TP
    port map(
        I2C_SCL         => RH_TEMP_I2C_SCL,
        I2C_SDA         => RH_TEMP_I2C_SDA,  
        R_DATA          => R_DATA,
        WORD_ST         => WORD_ST,
        WORD_CNT        => WORD_CNT,
        WORD_BYTE       => WORD_BYTE,
        W_WORD_END      => W_WORD_END,
        W_WORD_GO       => W_WORD_GO,
        RESET_N         => RESET_N,
        SYS_CLK         => CLK_400K,
        ST              => ST,
        CNT             => CNT,	
        Configuration_S => CONFIGURATION_S(15 downto 0),
        Temperature     => TEMP_CURRENT(15 downto 0),
        Humidity        => RH_CURRENT(15 downto 0), 
        Temperature_S   => ("000000" & TEMP_CURRENT_S(23 downto 16)) - 40,
        Humidity_S      => ("000000" & RH_CURRENT_S(23 downto 16)),      
        DeviceID        => DEVICE_ID,
        ManufacturerID  => MANUFACTURER_ID,
        RH_TEMP_DRDY_n  => RH_TEMP_DRDY_n
    );

    --CLOCK TEST--
    --CLOCKMEM C2  (  .CLK  (MAX10_CLK1_50) , .CLK_FREQ (50000000), . CK_1HZ (CK50_1_1HZ )  ) ; //50MHZ
    --CLOCKMEM C3  (  .CLK  (MAX10_CLK2_50) , .CLK_FREQ (50000000), . CK_1HZ (CK50_2_1HZ )  ) ; //50MHZ
    --CLOCKMEM C4  (  .CLK  (ADC_CLK_10)    , .CLK_FREQ (10000000), . CK_1HZ (AD_1HZ)  ) ;      //10MHZ
    --CLOCKMEM C5  (  .CLK  (CLK_400K)      , .CLK_FREQ (400000)  , . CK_1HZ (I2C_1HZ )  ) ;    //400KHZ

    --OUTPUT LED --
	out_LED(7 downto 0) <= x"FF" XOR (I2C_1HZ & I2C_1HZ & AD_1HZ & AD_1HZ & CK50_2_1HZ & CK50_2_1HZ & CK50_1_1HZ & CK50_1_1HZ);

end rtl;
