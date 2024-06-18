-- Copyright (C) 2020  Intel Corporation. All rights reserved.
-- Your use of Intel Corporation's design tools, logic functions 
-- and other software and tools, and any partner logic 
-- functions, and any output files from any of the foregoing 
-- (including device programming or simulation files), and any 
-- associated documentation or information are expressly subject 
-- to the terms and conditions of the Intel Program License 
-- Subscription Agreement, the Intel Quartus Prime License Agreement,
-- the Intel FPGA IP License Agreement, or other applicable license
-- agreement, including, without limitation, that your use is for
-- the sole purpose of programming logic devices manufactured by
-- Intel and sold by Intel or its authorized distributors.  Please
-- refer to the applicable agreement for further details, at
-- https://fpgasoftware.intel.com/eula.

-- VENDOR "Altera"
-- PROGRAM "Quartus Prime"
-- VERSION "Version 20.1.1 Build 720 11/11/2020 SJ Lite Edition"

-- DATE "06/13/2024 18:49:16"

-- 
-- Device: Altera 10M50DAF484C6GES Package FBGA484
-- 

-- 
-- This VHDL file should be used for ModelSim-Altera (VHDL) only
-- 

LIBRARY FIFTYFIVENM;
LIBRARY IEEE;
USE FIFTYFIVENM.FIFTYFIVENM_COMPONENTS.ALL;
USE IEEE.STD_LOGIC_1164.ALL;

ENTITY 	hard_block IS
    PORT (
	devoe : IN std_logic;
	devclrn : IN std_logic;
	devpor : IN std_logic
	);
END hard_block;

-- Design Ports Information
-- ~ALTERA_TMS~	=>  Location: PIN_H2,	 I/O Standard: 2.5 V Schmitt Trigger,	 Current Strength: Default
-- ~ALTERA_TCK~	=>  Location: PIN_G2,	 I/O Standard: 2.5 V Schmitt Trigger,	 Current Strength: Default
-- ~ALTERA_TDI~	=>  Location: PIN_L4,	 I/O Standard: 2.5 V Schmitt Trigger,	 Current Strength: Default
-- ~ALTERA_TDO~	=>  Location: PIN_M5,	 I/O Standard: 2.5 V,	 Current Strength: Default
-- ~ALTERA_CONFIG_SEL~	=>  Location: PIN_H10,	 I/O Standard: 2.5 V,	 Current Strength: Default
-- ~ALTERA_nCONFIG~	=>  Location: PIN_H9,	 I/O Standard: 2.5 V Schmitt Trigger,	 Current Strength: Default
-- ~ALTERA_nSTATUS~	=>  Location: PIN_G9,	 I/O Standard: 2.5 V Schmitt Trigger,	 Current Strength: Default
-- ~ALTERA_CONF_DONE~	=>  Location: PIN_F8,	 I/O Standard: 2.5 V Schmitt Trigger,	 Current Strength: Default


ARCHITECTURE structure OF hard_block IS
SIGNAL gnd : std_logic := '0';
SIGNAL vcc : std_logic := '1';
SIGNAL unknown : std_logic := 'X';
SIGNAL ww_devoe : std_logic;
SIGNAL ww_devclrn : std_logic;
SIGNAL ww_devpor : std_logic;
SIGNAL \~ALTERA_TMS~~padout\ : std_logic;
SIGNAL \~ALTERA_TCK~~padout\ : std_logic;
SIGNAL \~ALTERA_TDI~~padout\ : std_logic;
SIGNAL \~ALTERA_CONFIG_SEL~~padout\ : std_logic;
SIGNAL \~ALTERA_nCONFIG~~padout\ : std_logic;
SIGNAL \~ALTERA_nSTATUS~~padout\ : std_logic;
SIGNAL \~ALTERA_CONF_DONE~~padout\ : std_logic;
SIGNAL \~ALTERA_TMS~~ibuf_o\ : std_logic;
SIGNAL \~ALTERA_TCK~~ibuf_o\ : std_logic;
SIGNAL \~ALTERA_TDI~~ibuf_o\ : std_logic;
SIGNAL \~ALTERA_CONFIG_SEL~~ibuf_o\ : std_logic;
SIGNAL \~ALTERA_nCONFIG~~ibuf_o\ : std_logic;
SIGNAL \~ALTERA_nSTATUS~~ibuf_o\ : std_logic;
SIGNAL \~ALTERA_CONF_DONE~~ibuf_o\ : std_logic;

BEGIN

ww_devoe <= devoe;
ww_devclrn <= devclrn;
ww_devpor <= devpor;
END structure;


LIBRARY FIFTYFIVENM;
LIBRARY IEEE;
USE FIFTYFIVENM.FIFTYFIVENM_COMPONENTS.ALL;
USE IEEE.NUMERIC_STD.ALL;
USE IEEE.STD_LOGIC_1164.ALL;

ENTITY 	P002_Multiplexer IS
    PORT (
	in_sig1_MUX4to1 : IN IEEE.NUMERIC_STD.unsigned(7 DOWNTO 0);
	in_sig2_MUX4to1 : IN IEEE.NUMERIC_STD.unsigned(7 DOWNTO 0);
	in_sig3_MUX4to1 : IN IEEE.NUMERIC_STD.unsigned(7 DOWNTO 0);
	in_sig4_MUX4to1 : IN IEEE.NUMERIC_STD.unsigned(7 DOWNTO 0);
	in_sel_MUX4to1 : IN IEEE.NUMERIC_STD.unsigned(1 DOWNTO 0);
	out_sig_MUX4to1 : OUT IEEE.NUMERIC_STD.unsigned(7 DOWNTO 0)
	);
END P002_Multiplexer;

-- Design Ports Information
-- out_sig_MUX4to1[0]	=>  Location: PIN_G1,	 I/O Standard: 2.5 V,	 Current Strength: Default
-- out_sig_MUX4to1[1]	=>  Location: PIN_E8,	 I/O Standard: 2.5 V,	 Current Strength: Default
-- out_sig_MUX4to1[2]	=>  Location: PIN_F3,	 I/O Standard: 2.5 V,	 Current Strength: Default
-- out_sig_MUX4to1[3]	=>  Location: PIN_F2,	 I/O Standard: 2.5 V,	 Current Strength: Default
-- out_sig_MUX4to1[4]	=>  Location: PIN_N4,	 I/O Standard: 2.5 V,	 Current Strength: Default
-- out_sig_MUX4to1[5]	=>  Location: PIN_L1,	 I/O Standard: 2.5 V,	 Current Strength: Default
-- out_sig_MUX4to1[6]	=>  Location: PIN_D6,	 I/O Standard: 2.5 V,	 Current Strength: Default
-- out_sig_MUX4to1[7]	=>  Location: PIN_F4,	 I/O Standard: 2.5 V,	 Current Strength: Default
-- in_sig3_MUX4to1[0]	=>  Location: PIN_D3,	 I/O Standard: 2.5 V,	 Current Strength: Default
-- in_sel_MUX4to1[1]	=>  Location: PIN_B2,	 I/O Standard: 2.5 V,	 Current Strength: Default
-- in_sig2_MUX4to1[0]	=>  Location: PIN_G3,	 I/O Standard: 2.5 V,	 Current Strength: Default
-- in_sel_MUX4to1[0]	=>  Location: PIN_K4,	 I/O Standard: 2.5 V,	 Current Strength: Default
-- in_sig1_MUX4to1[0]	=>  Location: PIN_B1,	 I/O Standard: 2.5 V,	 Current Strength: Default
-- in_sig4_MUX4to1[0]	=>  Location: PIN_C2,	 I/O Standard: 2.5 V,	 Current Strength: Default
-- in_sig2_MUX4to1[1]	=>  Location: PIN_C1,	 I/O Standard: 2.5 V,	 Current Strength: Default
-- in_sig3_MUX4to1[1]	=>  Location: PIN_J4,	 I/O Standard: 2.5 V,	 Current Strength: Default
-- in_sig1_MUX4to1[1]	=>  Location: PIN_F1,	 I/O Standard: 2.5 V,	 Current Strength: Default
-- in_sig4_MUX4to1[1]	=>  Location: PIN_F5,	 I/O Standard: 2.5 V,	 Current Strength: Default
-- in_sig3_MUX4to1[2]	=>  Location: PIN_K5,	 I/O Standard: 2.5 V,	 Current Strength: Default
-- in_sig2_MUX4to1[2]	=>  Location: PIN_E3,	 I/O Standard: 2.5 V,	 Current Strength: Default
-- in_sig1_MUX4to1[2]	=>  Location: PIN_K2,	 I/O Standard: 2.5 V,	 Current Strength: Default
-- in_sig4_MUX4to1[2]	=>  Location: PIN_G4,	 I/O Standard: 2.5 V,	 Current Strength: Default
-- in_sig2_MUX4to1[3]	=>  Location: PIN_D1,	 I/O Standard: 2.5 V,	 Current Strength: Default
-- in_sig3_MUX4to1[3]	=>  Location: PIN_D2,	 I/O Standard: 2.5 V,	 Current Strength: Default
-- in_sig1_MUX4to1[3]	=>  Location: PIN_K8,	 I/O Standard: 2.5 V,	 Current Strength: Default
-- in_sig4_MUX4to1[3]	=>  Location: PIN_K1,	 I/O Standard: 2.5 V,	 Current Strength: Default
-- in_sig3_MUX4to1[4]	=>  Location: PIN_J1,	 I/O Standard: 2.5 V,	 Current Strength: Default
-- in_sig2_MUX4to1[4]	=>  Location: PIN_C3,	 I/O Standard: 2.5 V,	 Current Strength: Default
-- in_sig1_MUX4to1[4]	=>  Location: PIN_J3,	 I/O Standard: 2.5 V,	 Current Strength: Default
-- in_sig4_MUX4to1[4]	=>  Location: PIN_H3,	 I/O Standard: 2.5 V,	 Current Strength: Default
-- in_sig2_MUX4to1[5]	=>  Location: PIN_H4,	 I/O Standard: 2.5 V,	 Current Strength: Default
-- in_sig3_MUX4to1[5]	=>  Location: PIN_L9,	 I/O Standard: 2.5 V,	 Current Strength: Default
-- in_sig1_MUX4to1[5]	=>  Location: PIN_J8,	 I/O Standard: 2.5 V,	 Current Strength: Default
-- in_sig4_MUX4to1[5]	=>  Location: PIN_E4,	 I/O Standard: 2.5 V,	 Current Strength: Default
-- in_sig3_MUX4to1[6]	=>  Location: PIN_K6,	 I/O Standard: 2.5 V,	 Current Strength: Default
-- in_sig2_MUX4to1[6]	=>  Location: PIN_E1,	 I/O Standard: 2.5 V,	 Current Strength: Default
-- in_sig1_MUX4to1[6]	=>  Location: PIN_H1,	 I/O Standard: 2.5 V,	 Current Strength: Default
-- in_sig4_MUX4to1[6]	=>  Location: PIN_L2,	 I/O Standard: 2.5 V,	 Current Strength: Default
-- in_sig2_MUX4to1[7]	=>  Location: PIN_K9,	 I/O Standard: 2.5 V,	 Current Strength: Default
-- in_sig3_MUX4to1[7]	=>  Location: PIN_L8,	 I/O Standard: 2.5 V,	 Current Strength: Default
-- in_sig1_MUX4to1[7]	=>  Location: PIN_J9,	 I/O Standard: 2.5 V,	 Current Strength: Default
-- in_sig4_MUX4to1[7]	=>  Location: PIN_E6,	 I/O Standard: 2.5 V,	 Current Strength: Default


ARCHITECTURE structure OF P002_Multiplexer IS
SIGNAL gnd : std_logic := '0';
SIGNAL vcc : std_logic := '1';
SIGNAL unknown : std_logic := 'X';
SIGNAL devoe : std_logic := '1';
SIGNAL devclrn : std_logic := '1';
SIGNAL devpor : std_logic := '1';
SIGNAL ww_devoe : std_logic;
SIGNAL ww_devclrn : std_logic;
SIGNAL ww_devpor : std_logic;
SIGNAL ww_in_sig1_MUX4to1 : std_logic_vector(7 DOWNTO 0);
SIGNAL ww_in_sig2_MUX4to1 : std_logic_vector(7 DOWNTO 0);
SIGNAL ww_in_sig3_MUX4to1 : std_logic_vector(7 DOWNTO 0);
SIGNAL ww_in_sig4_MUX4to1 : std_logic_vector(7 DOWNTO 0);
SIGNAL ww_in_sel_MUX4to1 : std_logic_vector(1 DOWNTO 0);
SIGNAL ww_out_sig_MUX4to1 : std_logic_vector(7 DOWNTO 0);
SIGNAL \~QUARTUS_CREATED_ADC1~_CHSEL_bus\ : std_logic_vector(4 DOWNTO 0);
SIGNAL \~QUARTUS_CREATED_ADC2~_CHSEL_bus\ : std_logic_vector(4 DOWNTO 0);
SIGNAL \~QUARTUS_CREATED_GND~I_combout\ : std_logic;
SIGNAL \~QUARTUS_CREATED_UNVM~~busy\ : std_logic;
SIGNAL \~QUARTUS_CREATED_ADC1~~eoc\ : std_logic;
SIGNAL \~QUARTUS_CREATED_ADC2~~eoc\ : std_logic;
SIGNAL \out_sig_MUX4to1[0]~output_o\ : std_logic;
SIGNAL \out_sig_MUX4to1[1]~output_o\ : std_logic;
SIGNAL \out_sig_MUX4to1[2]~output_o\ : std_logic;
SIGNAL \out_sig_MUX4to1[3]~output_o\ : std_logic;
SIGNAL \out_sig_MUX4to1[4]~output_o\ : std_logic;
SIGNAL \out_sig_MUX4to1[5]~output_o\ : std_logic;
SIGNAL \out_sig_MUX4to1[6]~output_o\ : std_logic;
SIGNAL \out_sig_MUX4to1[7]~output_o\ : std_logic;
SIGNAL \in_sig3_MUX4to1[0]~input_o\ : std_logic;
SIGNAL \in_sig4_MUX4to1[0]~input_o\ : std_logic;
SIGNAL \in_sel_MUX4to1[1]~input_o\ : std_logic;
SIGNAL \in_sel_MUX4to1[0]~input_o\ : std_logic;
SIGNAL \in_sig2_MUX4to1[0]~input_o\ : std_logic;
SIGNAL \in_sig1_MUX4to1[0]~input_o\ : std_logic;
SIGNAL \Mux7~0_combout\ : std_logic;
SIGNAL \Mux7~1_combout\ : std_logic;
SIGNAL \in_sig4_MUX4to1[1]~input_o\ : std_logic;
SIGNAL \in_sig2_MUX4to1[1]~input_o\ : std_logic;
SIGNAL \in_sig3_MUX4to1[1]~input_o\ : std_logic;
SIGNAL \in_sig1_MUX4to1[1]~input_o\ : std_logic;
SIGNAL \Mux6~0_combout\ : std_logic;
SIGNAL \Mux6~1_combout\ : std_logic;
SIGNAL \in_sig3_MUX4to1[2]~input_o\ : std_logic;
SIGNAL \in_sig4_MUX4to1[2]~input_o\ : std_logic;
SIGNAL \in_sig1_MUX4to1[2]~input_o\ : std_logic;
SIGNAL \in_sig2_MUX4to1[2]~input_o\ : std_logic;
SIGNAL \Mux5~0_combout\ : std_logic;
SIGNAL \Mux5~1_combout\ : std_logic;
SIGNAL \in_sig2_MUX4to1[3]~input_o\ : std_logic;
SIGNAL \in_sig1_MUX4to1[3]~input_o\ : std_logic;
SIGNAL \in_sig3_MUX4to1[3]~input_o\ : std_logic;
SIGNAL \Mux4~0_combout\ : std_logic;
SIGNAL \in_sig4_MUX4to1[3]~input_o\ : std_logic;
SIGNAL \Mux4~1_combout\ : std_logic;
SIGNAL \in_sig3_MUX4to1[4]~input_o\ : std_logic;
SIGNAL \in_sig4_MUX4to1[4]~input_o\ : std_logic;
SIGNAL \in_sig1_MUX4to1[4]~input_o\ : std_logic;
SIGNAL \in_sig2_MUX4to1[4]~input_o\ : std_logic;
SIGNAL \Mux3~0_combout\ : std_logic;
SIGNAL \Mux3~1_combout\ : std_logic;
SIGNAL \in_sig4_MUX4to1[5]~input_o\ : std_logic;
SIGNAL \in_sig2_MUX4to1[5]~input_o\ : std_logic;
SIGNAL \in_sig1_MUX4to1[5]~input_o\ : std_logic;
SIGNAL \in_sig3_MUX4to1[5]~input_o\ : std_logic;
SIGNAL \Mux2~0_combout\ : std_logic;
SIGNAL \Mux2~1_combout\ : std_logic;
SIGNAL \in_sig4_MUX4to1[6]~input_o\ : std_logic;
SIGNAL \in_sig2_MUX4to1[6]~input_o\ : std_logic;
SIGNAL \in_sig1_MUX4to1[6]~input_o\ : std_logic;
SIGNAL \Mux1~0_combout\ : std_logic;
SIGNAL \in_sig3_MUX4to1[6]~input_o\ : std_logic;
SIGNAL \Mux1~1_combout\ : std_logic;
SIGNAL \in_sig2_MUX4to1[7]~input_o\ : std_logic;
SIGNAL \in_sig4_MUX4to1[7]~input_o\ : std_logic;
SIGNAL \in_sig1_MUX4to1[7]~input_o\ : std_logic;
SIGNAL \in_sig3_MUX4to1[7]~input_o\ : std_logic;
SIGNAL \Mux0~0_combout\ : std_logic;
SIGNAL \Mux0~1_combout\ : std_logic;

COMPONENT hard_block
    PORT (
	devoe : IN std_logic;
	devclrn : IN std_logic;
	devpor : IN std_logic);
END COMPONENT;

BEGIN

ww_in_sig1_MUX4to1 <= IEEE.STD_LOGIC_1164.STD_LOGIC_VECTOR(in_sig1_MUX4to1);
ww_in_sig2_MUX4to1 <= IEEE.STD_LOGIC_1164.STD_LOGIC_VECTOR(in_sig2_MUX4to1);
ww_in_sig3_MUX4to1 <= IEEE.STD_LOGIC_1164.STD_LOGIC_VECTOR(in_sig3_MUX4to1);
ww_in_sig4_MUX4to1 <= IEEE.STD_LOGIC_1164.STD_LOGIC_VECTOR(in_sig4_MUX4to1);
ww_in_sel_MUX4to1 <= IEEE.STD_LOGIC_1164.STD_LOGIC_VECTOR(in_sel_MUX4to1);
out_sig_MUX4to1 <= IEEE.NUMERIC_STD.UNSIGNED(ww_out_sig_MUX4to1);
ww_devoe <= devoe;
ww_devclrn <= devclrn;
ww_devpor <= devpor;

\~QUARTUS_CREATED_ADC1~_CHSEL_bus\ <= (\~QUARTUS_CREATED_GND~I_combout\ & \~QUARTUS_CREATED_GND~I_combout\ & \~QUARTUS_CREATED_GND~I_combout\ & \~QUARTUS_CREATED_GND~I_combout\ & \~QUARTUS_CREATED_GND~I_combout\);

\~QUARTUS_CREATED_ADC2~_CHSEL_bus\ <= (\~QUARTUS_CREATED_GND~I_combout\ & \~QUARTUS_CREATED_GND~I_combout\ & \~QUARTUS_CREATED_GND~I_combout\ & \~QUARTUS_CREATED_GND~I_combout\ & \~QUARTUS_CREATED_GND~I_combout\);
auto_generated_inst : hard_block
PORT MAP (
	devoe => ww_devoe,
	devclrn => ww_devclrn,
	devpor => ww_devpor);

-- Location: LCCOMB_X44_Y52_N8
\~QUARTUS_CREATED_GND~I\ : fiftyfivenm_lcell_comb
-- Equation(s):
-- \~QUARTUS_CREATED_GND~I_combout\ = GND

-- pragma translate_off
GENERIC MAP (
	lut_mask => "0000000000000000",
	sum_lutc_input => "datac")
-- pragma translate_on
PORT MAP (
	combout => \~QUARTUS_CREATED_GND~I_combout\);

-- Location: IOOBUF_X0_Y26_N2
\out_sig_MUX4to1[0]~output\ : fiftyfivenm_io_obuf
-- pragma translate_off
GENERIC MAP (
	bus_hold => "false",
	open_drain_output => "false")
-- pragma translate_on
PORT MAP (
	i => \Mux7~1_combout\,
	devoe => ww_devoe,
	o => \out_sig_MUX4to1[0]~output_o\);

-- Location: IOOBUF_X24_Y39_N9
\out_sig_MUX4to1[1]~output\ : fiftyfivenm_io_obuf
-- pragma translate_off
GENERIC MAP (
	bus_hold => "false",
	open_drain_output => "false")
-- pragma translate_on
PORT MAP (
	i => \Mux6~1_combout\,
	devoe => ww_devoe,
	o => \out_sig_MUX4to1[1]~output_o\);

-- Location: IOOBUF_X0_Y36_N9
\out_sig_MUX4to1[2]~output\ : fiftyfivenm_io_obuf
-- pragma translate_off
GENERIC MAP (
	bus_hold => "false",
	open_drain_output => "false")
-- pragma translate_on
PORT MAP (
	i => \Mux5~1_combout\,
	devoe => ww_devoe,
	o => \out_sig_MUX4to1[2]~output_o\);

-- Location: IOOBUF_X0_Y27_N9
\out_sig_MUX4to1[3]~output\ : fiftyfivenm_io_obuf
-- pragma translate_off
GENERIC MAP (
	bus_hold => "false",
	open_drain_output => "false")
-- pragma translate_on
PORT MAP (
	i => \Mux4~1_combout\,
	devoe => ww_devoe,
	o => \out_sig_MUX4to1[3]~output_o\);

-- Location: IOOBUF_X0_Y23_N16
\out_sig_MUX4to1[4]~output\ : fiftyfivenm_io_obuf
-- pragma translate_off
GENERIC MAP (
	bus_hold => "false",
	open_drain_output => "false")
-- pragma translate_on
PORT MAP (
	i => \Mux3~1_combout\,
	devoe => ww_devoe,
	o => \out_sig_MUX4to1[4]~output_o\);

-- Location: IOOBUF_X0_Y25_N9
\out_sig_MUX4to1[5]~output\ : fiftyfivenm_io_obuf
-- pragma translate_off
GENERIC MAP (
	bus_hold => "false",
	open_drain_output => "false")
-- pragma translate_on
PORT MAP (
	i => \Mux2~1_combout\,
	devoe => ww_devoe,
	o => \out_sig_MUX4to1[5]~output_o\);

-- Location: IOOBUF_X22_Y39_N30
\out_sig_MUX4to1[6]~output\ : fiftyfivenm_io_obuf
-- pragma translate_off
GENERIC MAP (
	bus_hold => "false",
	open_drain_output => "false")
-- pragma translate_on
PORT MAP (
	i => \Mux1~1_combout\,
	devoe => ww_devoe,
	o => \out_sig_MUX4to1[6]~output_o\);

-- Location: IOOBUF_X0_Y37_N23
\out_sig_MUX4to1[7]~output\ : fiftyfivenm_io_obuf
-- pragma translate_off
GENERIC MAP (
	bus_hold => "false",
	open_drain_output => "false")
-- pragma translate_on
PORT MAP (
	i => \Mux0~1_combout\,
	devoe => ww_devoe,
	o => \out_sig_MUX4to1[7]~output_o\);

-- Location: IOIBUF_X0_Y30_N1
\in_sig3_MUX4to1[0]~input\ : fiftyfivenm_io_ibuf
-- pragma translate_off
GENERIC MAP (
	bus_hold => "false",
	listen_to_nsleep_signal => "false",
	simulate_z_as => "z")
-- pragma translate_on
PORT MAP (
	i => ww_in_sig3_MUX4to1(0),
	o => \in_sig3_MUX4to1[0]~input_o\);

-- Location: IOIBUF_X20_Y39_N15
\in_sig4_MUX4to1[0]~input\ : fiftyfivenm_io_ibuf
-- pragma translate_off
GENERIC MAP (
	bus_hold => "false",
	listen_to_nsleep_signal => "false",
	simulate_z_as => "z")
-- pragma translate_on
PORT MAP (
	i => ww_in_sig4_MUX4to1(0),
	o => \in_sig4_MUX4to1[0]~input_o\);

-- Location: IOIBUF_X22_Y39_N15
\in_sel_MUX4to1[1]~input\ : fiftyfivenm_io_ibuf
-- pragma translate_off
GENERIC MAP (
	bus_hold => "false",
	listen_to_nsleep_signal => "false",
	simulate_z_as => "z")
-- pragma translate_on
PORT MAP (
	i => ww_in_sel_MUX4to1(1),
	o => \in_sel_MUX4to1[1]~input_o\);

-- Location: IOIBUF_X0_Y34_N1
\in_sel_MUX4to1[0]~input\ : fiftyfivenm_io_ibuf
-- pragma translate_off
GENERIC MAP (
	bus_hold => "false",
	listen_to_nsleep_signal => "false",
	simulate_z_as => "z")
-- pragma translate_on
PORT MAP (
	i => ww_in_sel_MUX4to1(0),
	o => \in_sel_MUX4to1[0]~input_o\);

-- Location: IOIBUF_X0_Y35_N8
\in_sig2_MUX4to1[0]~input\ : fiftyfivenm_io_ibuf
-- pragma translate_off
GENERIC MAP (
	bus_hold => "false",
	listen_to_nsleep_signal => "false",
	simulate_z_as => "z")
-- pragma translate_on
PORT MAP (
	i => ww_in_sig2_MUX4to1(0),
	o => \in_sig2_MUX4to1[0]~input_o\);

-- Location: IOIBUF_X22_Y39_N22
\in_sig1_MUX4to1[0]~input\ : fiftyfivenm_io_ibuf
-- pragma translate_off
GENERIC MAP (
	bus_hold => "false",
	listen_to_nsleep_signal => "false",
	simulate_z_as => "z")
-- pragma translate_on
PORT MAP (
	i => ww_in_sig1_MUX4to1(0),
	o => \in_sig1_MUX4to1[0]~input_o\);

-- Location: LCCOMB_X1_Y31_N24
\Mux7~0\ : fiftyfivenm_lcell_comb
-- Equation(s):
-- \Mux7~0_combout\ = (\in_sel_MUX4to1[0]~input_o\ & ((\in_sig2_MUX4to1[0]~input_o\) # ((\in_sel_MUX4to1[1]~input_o\)))) # (!\in_sel_MUX4to1[0]~input_o\ & (((!\in_sel_MUX4to1[1]~input_o\ & \in_sig1_MUX4to1[0]~input_o\))))

-- pragma translate_off
GENERIC MAP (
	lut_mask => "1010110110101000",
	sum_lutc_input => "datac")
-- pragma translate_on
PORT MAP (
	dataa => \in_sel_MUX4to1[0]~input_o\,
	datab => \in_sig2_MUX4to1[0]~input_o\,
	datac => \in_sel_MUX4to1[1]~input_o\,
	datad => \in_sig1_MUX4to1[0]~input_o\,
	combout => \Mux7~0_combout\);

-- Location: LCCOMB_X1_Y31_N18
\Mux7~1\ : fiftyfivenm_lcell_comb
-- Equation(s):
-- \Mux7~1_combout\ = (\in_sel_MUX4to1[1]~input_o\ & ((\Mux7~0_combout\ & ((\in_sig4_MUX4to1[0]~input_o\))) # (!\Mux7~0_combout\ & (\in_sig3_MUX4to1[0]~input_o\)))) # (!\in_sel_MUX4to1[1]~input_o\ & (((\Mux7~0_combout\))))

-- pragma translate_off
GENERIC MAP (
	lut_mask => "1100111110100000",
	sum_lutc_input => "datac")
-- pragma translate_on
PORT MAP (
	dataa => \in_sig3_MUX4to1[0]~input_o\,
	datab => \in_sig4_MUX4to1[0]~input_o\,
	datac => \in_sel_MUX4to1[1]~input_o\,
	datad => \Mux7~0_combout\,
	combout => \Mux7~1_combout\);

-- Location: IOIBUF_X0_Y37_N15
\in_sig4_MUX4to1[1]~input\ : fiftyfivenm_io_ibuf
-- pragma translate_off
GENERIC MAP (
	bus_hold => "false",
	listen_to_nsleep_signal => "false",
	simulate_z_as => "z")
-- pragma translate_on
PORT MAP (
	i => ww_in_sig4_MUX4to1(1),
	o => \in_sig4_MUX4to1[1]~input_o\);

-- Location: IOIBUF_X0_Y29_N1
\in_sig2_MUX4to1[1]~input\ : fiftyfivenm_io_ibuf
-- pragma translate_off
GENERIC MAP (
	bus_hold => "false",
	listen_to_nsleep_signal => "false",
	simulate_z_as => "z")
-- pragma translate_on
PORT MAP (
	i => ww_in_sig2_MUX4to1(1),
	o => \in_sig2_MUX4to1[1]~input_o\);

-- Location: IOIBUF_X0_Y35_N15
\in_sig3_MUX4to1[1]~input\ : fiftyfivenm_io_ibuf
-- pragma translate_off
GENERIC MAP (
	bus_hold => "false",
	listen_to_nsleep_signal => "false",
	simulate_z_as => "z")
-- pragma translate_on
PORT MAP (
	i => ww_in_sig3_MUX4to1(1),
	o => \in_sig3_MUX4to1[1]~input_o\);

-- Location: IOIBUF_X0_Y26_N8
\in_sig1_MUX4to1[1]~input\ : fiftyfivenm_io_ibuf
-- pragma translate_off
GENERIC MAP (
	bus_hold => "false",
	listen_to_nsleep_signal => "false",
	simulate_z_as => "z")
-- pragma translate_on
PORT MAP (
	i => ww_in_sig1_MUX4to1(1),
	o => \in_sig1_MUX4to1[1]~input_o\);

-- Location: LCCOMB_X1_Y31_N12
\Mux6~0\ : fiftyfivenm_lcell_comb
-- Equation(s):
-- \Mux6~0_combout\ = (\in_sel_MUX4to1[0]~input_o\ & (\in_sel_MUX4to1[1]~input_o\)) # (!\in_sel_MUX4to1[0]~input_o\ & ((\in_sel_MUX4to1[1]~input_o\ & (\in_sig3_MUX4to1[1]~input_o\)) # (!\in_sel_MUX4to1[1]~input_o\ & ((\in_sig1_MUX4to1[1]~input_o\)))))

-- pragma translate_off
GENERIC MAP (
	lut_mask => "1101100111001000",
	sum_lutc_input => "datac")
-- pragma translate_on
PORT MAP (
	dataa => \in_sel_MUX4to1[0]~input_o\,
	datab => \in_sel_MUX4to1[1]~input_o\,
	datac => \in_sig3_MUX4to1[1]~input_o\,
	datad => \in_sig1_MUX4to1[1]~input_o\,
	combout => \Mux6~0_combout\);

-- Location: LCCOMB_X1_Y31_N22
\Mux6~1\ : fiftyfivenm_lcell_comb
-- Equation(s):
-- \Mux6~1_combout\ = (\in_sel_MUX4to1[0]~input_o\ & ((\Mux6~0_combout\ & (\in_sig4_MUX4to1[1]~input_o\)) # (!\Mux6~0_combout\ & ((\in_sig2_MUX4to1[1]~input_o\))))) # (!\in_sel_MUX4to1[0]~input_o\ & (((\Mux6~0_combout\))))

-- pragma translate_off
GENERIC MAP (
	lut_mask => "1101110110100000",
	sum_lutc_input => "datac")
-- pragma translate_on
PORT MAP (
	dataa => \in_sel_MUX4to1[0]~input_o\,
	datab => \in_sig4_MUX4to1[1]~input_o\,
	datac => \in_sig2_MUX4to1[1]~input_o\,
	datad => \Mux6~0_combout\,
	combout => \Mux6~1_combout\);

-- Location: IOIBUF_X0_Y34_N15
\in_sig3_MUX4to1[2]~input\ : fiftyfivenm_io_ibuf
-- pragma translate_off
GENERIC MAP (
	bus_hold => "false",
	listen_to_nsleep_signal => "false",
	simulate_z_as => "z")
-- pragma translate_on
PORT MAP (
	i => ww_in_sig3_MUX4to1(2),
	o => \in_sig3_MUX4to1[2]~input_o\);

-- Location: IOIBUF_X0_Y36_N1
\in_sig4_MUX4to1[2]~input\ : fiftyfivenm_io_ibuf
-- pragma translate_off
GENERIC MAP (
	bus_hold => "false",
	listen_to_nsleep_signal => "false",
	simulate_z_as => "z")
-- pragma translate_on
PORT MAP (
	i => ww_in_sig4_MUX4to1(2),
	o => \in_sig4_MUX4to1[2]~input_o\);

-- Location: IOIBUF_X0_Y28_N1
\in_sig1_MUX4to1[2]~input\ : fiftyfivenm_io_ibuf
-- pragma translate_off
GENERIC MAP (
	bus_hold => "false",
	listen_to_nsleep_signal => "false",
	simulate_z_as => "z")
-- pragma translate_on
PORT MAP (
	i => ww_in_sig1_MUX4to1(2),
	o => \in_sig1_MUX4to1[2]~input_o\);

-- Location: IOIBUF_X0_Y37_N8
\in_sig2_MUX4to1[2]~input\ : fiftyfivenm_io_ibuf
-- pragma translate_off
GENERIC MAP (
	bus_hold => "false",
	listen_to_nsleep_signal => "false",
	simulate_z_as => "z")
-- pragma translate_on
PORT MAP (
	i => ww_in_sig2_MUX4to1(2),
	o => \in_sig2_MUX4to1[2]~input_o\);

-- Location: LCCOMB_X1_Y31_N16
\Mux5~0\ : fiftyfivenm_lcell_comb
-- Equation(s):
-- \Mux5~0_combout\ = (\in_sel_MUX4to1[0]~input_o\ & (((\in_sel_MUX4to1[1]~input_o\) # (\in_sig2_MUX4to1[2]~input_o\)))) # (!\in_sel_MUX4to1[0]~input_o\ & (\in_sig1_MUX4to1[2]~input_o\ & (!\in_sel_MUX4to1[1]~input_o\)))

-- pragma translate_off
GENERIC MAP (
	lut_mask => "1010111010100100",
	sum_lutc_input => "datac")
-- pragma translate_on
PORT MAP (
	dataa => \in_sel_MUX4to1[0]~input_o\,
	datab => \in_sig1_MUX4to1[2]~input_o\,
	datac => \in_sel_MUX4to1[1]~input_o\,
	datad => \in_sig2_MUX4to1[2]~input_o\,
	combout => \Mux5~0_combout\);

-- Location: LCCOMB_X1_Y31_N2
\Mux5~1\ : fiftyfivenm_lcell_comb
-- Equation(s):
-- \Mux5~1_combout\ = (\in_sel_MUX4to1[1]~input_o\ & ((\Mux5~0_combout\ & ((\in_sig4_MUX4to1[2]~input_o\))) # (!\Mux5~0_combout\ & (\in_sig3_MUX4to1[2]~input_o\)))) # (!\in_sel_MUX4to1[1]~input_o\ & (((\Mux5~0_combout\))))

-- pragma translate_off
GENERIC MAP (
	lut_mask => "1100111110100000",
	sum_lutc_input => "datac")
-- pragma translate_on
PORT MAP (
	dataa => \in_sig3_MUX4to1[2]~input_o\,
	datab => \in_sig4_MUX4to1[2]~input_o\,
	datac => \in_sel_MUX4to1[1]~input_o\,
	datad => \Mux5~0_combout\,
	combout => \Mux5~1_combout\);

-- Location: IOIBUF_X0_Y29_N8
\in_sig2_MUX4to1[3]~input\ : fiftyfivenm_io_ibuf
-- pragma translate_off
GENERIC MAP (
	bus_hold => "false",
	listen_to_nsleep_signal => "false",
	simulate_z_as => "z")
-- pragma translate_on
PORT MAP (
	i => ww_in_sig2_MUX4to1(3),
	o => \in_sig2_MUX4to1[3]~input_o\);

-- Location: IOIBUF_X0_Y30_N15
\in_sig1_MUX4to1[3]~input\ : fiftyfivenm_io_ibuf
-- pragma translate_off
GENERIC MAP (
	bus_hold => "false",
	listen_to_nsleep_signal => "false",
	simulate_z_as => "z")
-- pragma translate_on
PORT MAP (
	i => ww_in_sig1_MUX4to1(3),
	o => \in_sig1_MUX4to1[3]~input_o\);

-- Location: IOIBUF_X0_Y30_N8
\in_sig3_MUX4to1[3]~input\ : fiftyfivenm_io_ibuf
-- pragma translate_off
GENERIC MAP (
	bus_hold => "false",
	listen_to_nsleep_signal => "false",
	simulate_z_as => "z")
-- pragma translate_on
PORT MAP (
	i => ww_in_sig3_MUX4to1(3),
	o => \in_sig3_MUX4to1[3]~input_o\);

-- Location: LCCOMB_X1_Y31_N4
\Mux4~0\ : fiftyfivenm_lcell_comb
-- Equation(s):
-- \Mux4~0_combout\ = (\in_sel_MUX4to1[1]~input_o\ & (((\in_sel_MUX4to1[0]~input_o\) # (\in_sig3_MUX4to1[3]~input_o\)))) # (!\in_sel_MUX4to1[1]~input_o\ & (\in_sig1_MUX4to1[3]~input_o\ & (!\in_sel_MUX4to1[0]~input_o\)))

-- pragma translate_off
GENERIC MAP (
	lut_mask => "1100111011000010",
	sum_lutc_input => "datac")
-- pragma translate_on
PORT MAP (
	dataa => \in_sig1_MUX4to1[3]~input_o\,
	datab => \in_sel_MUX4to1[1]~input_o\,
	datac => \in_sel_MUX4to1[0]~input_o\,
	datad => \in_sig3_MUX4to1[3]~input_o\,
	combout => \Mux4~0_combout\);

-- Location: IOIBUF_X0_Y25_N1
\in_sig4_MUX4to1[3]~input\ : fiftyfivenm_io_ibuf
-- pragma translate_off
GENERIC MAP (
	bus_hold => "false",
	listen_to_nsleep_signal => "false",
	simulate_z_as => "z")
-- pragma translate_on
PORT MAP (
	i => ww_in_sig4_MUX4to1(3),
	o => \in_sig4_MUX4to1[3]~input_o\);

-- Location: LCCOMB_X1_Y31_N14
\Mux4~1\ : fiftyfivenm_lcell_comb
-- Equation(s):
-- \Mux4~1_combout\ = (\Mux4~0_combout\ & (((\in_sig4_MUX4to1[3]~input_o\) # (!\in_sel_MUX4to1[0]~input_o\)))) # (!\Mux4~0_combout\ & (\in_sig2_MUX4to1[3]~input_o\ & (\in_sel_MUX4to1[0]~input_o\)))

-- pragma translate_off
GENERIC MAP (
	lut_mask => "1110110000101100",
	sum_lutc_input => "datac")
-- pragma translate_on
PORT MAP (
	dataa => \in_sig2_MUX4to1[3]~input_o\,
	datab => \Mux4~0_combout\,
	datac => \in_sel_MUX4to1[0]~input_o\,
	datad => \in_sig4_MUX4to1[3]~input_o\,
	combout => \Mux4~1_combout\);

-- Location: IOIBUF_X0_Y26_N22
\in_sig3_MUX4to1[4]~input\ : fiftyfivenm_io_ibuf
-- pragma translate_off
GENERIC MAP (
	bus_hold => "false",
	listen_to_nsleep_signal => "false",
	simulate_z_as => "z")
-- pragma translate_on
PORT MAP (
	i => ww_in_sig3_MUX4to1(4),
	o => \in_sig3_MUX4to1[4]~input_o\);

-- Location: IOIBUF_X0_Y35_N22
\in_sig4_MUX4to1[4]~input\ : fiftyfivenm_io_ibuf
-- pragma translate_off
GENERIC MAP (
	bus_hold => "false",
	listen_to_nsleep_signal => "false",
	simulate_z_as => "z")
-- pragma translate_on
PORT MAP (
	i => ww_in_sig4_MUX4to1(4),
	o => \in_sig4_MUX4to1[4]~input_o\);

-- Location: IOIBUF_X0_Y34_N8
\in_sig1_MUX4to1[4]~input\ : fiftyfivenm_io_ibuf
-- pragma translate_off
GENERIC MAP (
	bus_hold => "false",
	listen_to_nsleep_signal => "false",
	simulate_z_as => "z")
-- pragma translate_on
PORT MAP (
	i => ww_in_sig1_MUX4to1(4),
	o => \in_sig1_MUX4to1[4]~input_o\);

-- Location: IOIBUF_X20_Y39_N8
\in_sig2_MUX4to1[4]~input\ : fiftyfivenm_io_ibuf
-- pragma translate_off
GENERIC MAP (
	bus_hold => "false",
	listen_to_nsleep_signal => "false",
	simulate_z_as => "z")
-- pragma translate_on
PORT MAP (
	i => ww_in_sig2_MUX4to1(4),
	o => \in_sig2_MUX4to1[4]~input_o\);

-- Location: LCCOMB_X1_Y31_N0
\Mux3~0\ : fiftyfivenm_lcell_comb
-- Equation(s):
-- \Mux3~0_combout\ = (\in_sel_MUX4to1[0]~input_o\ & (((\in_sel_MUX4to1[1]~input_o\) # (\in_sig2_MUX4to1[4]~input_o\)))) # (!\in_sel_MUX4to1[0]~input_o\ & (\in_sig1_MUX4to1[4]~input_o\ & (!\in_sel_MUX4to1[1]~input_o\)))

-- pragma translate_off
GENERIC MAP (
	lut_mask => "1010111010100100",
	sum_lutc_input => "datac")
-- pragma translate_on
PORT MAP (
	dataa => \in_sel_MUX4to1[0]~input_o\,
	datab => \in_sig1_MUX4to1[4]~input_o\,
	datac => \in_sel_MUX4to1[1]~input_o\,
	datad => \in_sig2_MUX4to1[4]~input_o\,
	combout => \Mux3~0_combout\);

-- Location: LCCOMB_X1_Y31_N10
\Mux3~1\ : fiftyfivenm_lcell_comb
-- Equation(s):
-- \Mux3~1_combout\ = (\in_sel_MUX4to1[1]~input_o\ & ((\Mux3~0_combout\ & ((\in_sig4_MUX4to1[4]~input_o\))) # (!\Mux3~0_combout\ & (\in_sig3_MUX4to1[4]~input_o\)))) # (!\in_sel_MUX4to1[1]~input_o\ & (((\Mux3~0_combout\))))

-- pragma translate_off
GENERIC MAP (
	lut_mask => "1100111110100000",
	sum_lutc_input => "datac")
-- pragma translate_on
PORT MAP (
	dataa => \in_sig3_MUX4to1[4]~input_o\,
	datab => \in_sig4_MUX4to1[4]~input_o\,
	datac => \in_sel_MUX4to1[1]~input_o\,
	datad => \Mux3~0_combout\,
	combout => \Mux3~1_combout\);

-- Location: IOIBUF_X0_Y37_N1
\in_sig4_MUX4to1[5]~input\ : fiftyfivenm_io_ibuf
-- pragma translate_off
GENERIC MAP (
	bus_hold => "false",
	listen_to_nsleep_signal => "false",
	simulate_z_as => "z")
-- pragma translate_on
PORT MAP (
	i => ww_in_sig4_MUX4to1(5),
	o => \in_sig4_MUX4to1[5]~input_o\);

-- Location: IOIBUF_X0_Y35_N1
\in_sig2_MUX4to1[5]~input\ : fiftyfivenm_io_ibuf
-- pragma translate_off
GENERIC MAP (
	bus_hold => "false",
	listen_to_nsleep_signal => "false",
	simulate_z_as => "z")
-- pragma translate_on
PORT MAP (
	i => ww_in_sig2_MUX4to1(5),
	o => \in_sig2_MUX4to1[5]~input_o\);

-- Location: IOIBUF_X0_Y36_N15
\in_sig1_MUX4to1[5]~input\ : fiftyfivenm_io_ibuf
-- pragma translate_off
GENERIC MAP (
	bus_hold => "false",
	listen_to_nsleep_signal => "false",
	simulate_z_as => "z")
-- pragma translate_on
PORT MAP (
	i => ww_in_sig1_MUX4to1(5),
	o => \in_sig1_MUX4to1[5]~input_o\);

-- Location: IOIBUF_X0_Y27_N22
\in_sig3_MUX4to1[5]~input\ : fiftyfivenm_io_ibuf
-- pragma translate_off
GENERIC MAP (
	bus_hold => "false",
	listen_to_nsleep_signal => "false",
	simulate_z_as => "z")
-- pragma translate_on
PORT MAP (
	i => ww_in_sig3_MUX4to1(5),
	o => \in_sig3_MUX4to1[5]~input_o\);

-- Location: LCCOMB_X1_Y31_N20
\Mux2~0\ : fiftyfivenm_lcell_comb
-- Equation(s):
-- \Mux2~0_combout\ = (\in_sel_MUX4to1[0]~input_o\ & (((\in_sel_MUX4to1[1]~input_o\)))) # (!\in_sel_MUX4to1[0]~input_o\ & ((\in_sel_MUX4to1[1]~input_o\ & ((\in_sig3_MUX4to1[5]~input_o\))) # (!\in_sel_MUX4to1[1]~input_o\ & (\in_sig1_MUX4to1[5]~input_o\))))

-- pragma translate_off
GENERIC MAP (
	lut_mask => "1111010010100100",
	sum_lutc_input => "datac")
-- pragma translate_on
PORT MAP (
	dataa => \in_sel_MUX4to1[0]~input_o\,
	datab => \in_sig1_MUX4to1[5]~input_o\,
	datac => \in_sel_MUX4to1[1]~input_o\,
	datad => \in_sig3_MUX4to1[5]~input_o\,
	combout => \Mux2~0_combout\);

-- Location: LCCOMB_X1_Y31_N6
\Mux2~1\ : fiftyfivenm_lcell_comb
-- Equation(s):
-- \Mux2~1_combout\ = (\in_sel_MUX4to1[0]~input_o\ & ((\Mux2~0_combout\ & (\in_sig4_MUX4to1[5]~input_o\)) # (!\Mux2~0_combout\ & ((\in_sig2_MUX4to1[5]~input_o\))))) # (!\in_sel_MUX4to1[0]~input_o\ & (((\Mux2~0_combout\))))

-- pragma translate_off
GENERIC MAP (
	lut_mask => "1101110110100000",
	sum_lutc_input => "datac")
-- pragma translate_on
PORT MAP (
	dataa => \in_sel_MUX4to1[0]~input_o\,
	datab => \in_sig4_MUX4to1[5]~input_o\,
	datac => \in_sig2_MUX4to1[5]~input_o\,
	datad => \Mux2~0_combout\,
	combout => \Mux2~1_combout\);

-- Location: IOIBUF_X0_Y28_N8
\in_sig4_MUX4to1[6]~input\ : fiftyfivenm_io_ibuf
-- pragma translate_off
GENERIC MAP (
	bus_hold => "false",
	listen_to_nsleep_signal => "false",
	simulate_z_as => "z")
-- pragma translate_on
PORT MAP (
	i => ww_in_sig4_MUX4to1(6),
	o => \in_sig4_MUX4to1[6]~input_o\);

-- Location: IOIBUF_X0_Y27_N1
\in_sig2_MUX4to1[6]~input\ : fiftyfivenm_io_ibuf
-- pragma translate_off
GENERIC MAP (
	bus_hold => "false",
	listen_to_nsleep_signal => "false",
	simulate_z_as => "z")
-- pragma translate_on
PORT MAP (
	i => ww_in_sig2_MUX4to1(6),
	o => \in_sig2_MUX4to1[6]~input_o\);

-- Location: IOIBUF_X0_Y26_N15
\in_sig1_MUX4to1[6]~input\ : fiftyfivenm_io_ibuf
-- pragma translate_off
GENERIC MAP (
	bus_hold => "false",
	listen_to_nsleep_signal => "false",
	simulate_z_as => "z")
-- pragma translate_on
PORT MAP (
	i => ww_in_sig1_MUX4to1(6),
	o => \in_sig1_MUX4to1[6]~input_o\);

-- Location: LCCOMB_X1_Y31_N8
\Mux1~0\ : fiftyfivenm_lcell_comb
-- Equation(s):
-- \Mux1~0_combout\ = (\in_sel_MUX4to1[1]~input_o\ & (((\in_sel_MUX4to1[0]~input_o\)))) # (!\in_sel_MUX4to1[1]~input_o\ & ((\in_sel_MUX4to1[0]~input_o\ & (\in_sig2_MUX4to1[6]~input_o\)) # (!\in_sel_MUX4to1[0]~input_o\ & ((\in_sig1_MUX4to1[6]~input_o\)))))

-- pragma translate_off
GENERIC MAP (
	lut_mask => "1110001111100000",
	sum_lutc_input => "datac")
-- pragma translate_on
PORT MAP (
	dataa => \in_sig2_MUX4to1[6]~input_o\,
	datab => \in_sel_MUX4to1[1]~input_o\,
	datac => \in_sel_MUX4to1[0]~input_o\,
	datad => \in_sig1_MUX4to1[6]~input_o\,
	combout => \Mux1~0_combout\);

-- Location: IOIBUF_X0_Y34_N22
\in_sig3_MUX4to1[6]~input\ : fiftyfivenm_io_ibuf
-- pragma translate_off
GENERIC MAP (
	bus_hold => "false",
	listen_to_nsleep_signal => "false",
	simulate_z_as => "z")
-- pragma translate_on
PORT MAP (
	i => ww_in_sig3_MUX4to1(6),
	o => \in_sig3_MUX4to1[6]~input_o\);

-- Location: LCCOMB_X1_Y31_N26
\Mux1~1\ : fiftyfivenm_lcell_comb
-- Equation(s):
-- \Mux1~1_combout\ = (\Mux1~0_combout\ & ((\in_sig4_MUX4to1[6]~input_o\) # ((!\in_sel_MUX4to1[1]~input_o\)))) # (!\Mux1~0_combout\ & (((\in_sel_MUX4to1[1]~input_o\ & \in_sig3_MUX4to1[6]~input_o\))))

-- pragma translate_off
GENERIC MAP (
	lut_mask => "1011110010001100",
	sum_lutc_input => "datac")
-- pragma translate_on
PORT MAP (
	dataa => \in_sig4_MUX4to1[6]~input_o\,
	datab => \Mux1~0_combout\,
	datac => \in_sel_MUX4to1[1]~input_o\,
	datad => \in_sig3_MUX4to1[6]~input_o\,
	combout => \Mux1~1_combout\);

-- Location: IOIBUF_X0_Y30_N22
\in_sig2_MUX4to1[7]~input\ : fiftyfivenm_io_ibuf
-- pragma translate_off
GENERIC MAP (
	bus_hold => "false",
	listen_to_nsleep_signal => "false",
	simulate_z_as => "z")
-- pragma translate_on
PORT MAP (
	i => ww_in_sig2_MUX4to1(7),
	o => \in_sig2_MUX4to1[7]~input_o\);

-- Location: IOIBUF_X20_Y39_N1
\in_sig4_MUX4to1[7]~input\ : fiftyfivenm_io_ibuf
-- pragma translate_off
GENERIC MAP (
	bus_hold => "false",
	listen_to_nsleep_signal => "false",
	simulate_z_as => "z")
-- pragma translate_on
PORT MAP (
	i => ww_in_sig4_MUX4to1(7),
	o => \in_sig4_MUX4to1[7]~input_o\);

-- Location: IOIBUF_X0_Y36_N22
\in_sig1_MUX4to1[7]~input\ : fiftyfivenm_io_ibuf
-- pragma translate_off
GENERIC MAP (
	bus_hold => "false",
	listen_to_nsleep_signal => "false",
	simulate_z_as => "z")
-- pragma translate_on
PORT MAP (
	i => ww_in_sig1_MUX4to1(7),
	o => \in_sig1_MUX4to1[7]~input_o\);

-- Location: IOIBUF_X0_Y27_N15
\in_sig3_MUX4to1[7]~input\ : fiftyfivenm_io_ibuf
-- pragma translate_off
GENERIC MAP (
	bus_hold => "false",
	listen_to_nsleep_signal => "false",
	simulate_z_as => "z")
-- pragma translate_on
PORT MAP (
	i => ww_in_sig3_MUX4to1(7),
	o => \in_sig3_MUX4to1[7]~input_o\);

-- Location: LCCOMB_X1_Y31_N28
\Mux0~0\ : fiftyfivenm_lcell_comb
-- Equation(s):
-- \Mux0~0_combout\ = (\in_sel_MUX4to1[0]~input_o\ & (\in_sel_MUX4to1[1]~input_o\)) # (!\in_sel_MUX4to1[0]~input_o\ & ((\in_sel_MUX4to1[1]~input_o\ & ((\in_sig3_MUX4to1[7]~input_o\))) # (!\in_sel_MUX4to1[1]~input_o\ & (\in_sig1_MUX4to1[7]~input_o\))))

-- pragma translate_off
GENERIC MAP (
	lut_mask => "1101110010011000",
	sum_lutc_input => "datac")
-- pragma translate_on
PORT MAP (
	dataa => \in_sel_MUX4to1[0]~input_o\,
	datab => \in_sel_MUX4to1[1]~input_o\,
	datac => \in_sig1_MUX4to1[7]~input_o\,
	datad => \in_sig3_MUX4to1[7]~input_o\,
	combout => \Mux0~0_combout\);

-- Location: LCCOMB_X1_Y31_N30
\Mux0~1\ : fiftyfivenm_lcell_comb
-- Equation(s):
-- \Mux0~1_combout\ = (\in_sel_MUX4to1[0]~input_o\ & ((\Mux0~0_combout\ & ((\in_sig4_MUX4to1[7]~input_o\))) # (!\Mux0~0_combout\ & (\in_sig2_MUX4to1[7]~input_o\)))) # (!\in_sel_MUX4to1[0]~input_o\ & (((\Mux0~0_combout\))))

-- pragma translate_off
GENERIC MAP (
	lut_mask => "1111010110001000",
	sum_lutc_input => "datac")
-- pragma translate_on
PORT MAP (
	dataa => \in_sel_MUX4to1[0]~input_o\,
	datab => \in_sig2_MUX4to1[7]~input_o\,
	datac => \in_sig4_MUX4to1[7]~input_o\,
	datad => \Mux0~0_combout\,
	combout => \Mux0~1_combout\);

-- Location: UNVM_X0_Y40_N40
\~QUARTUS_CREATED_UNVM~\ : fiftyfivenm_unvm
-- pragma translate_off
GENERIC MAP (
	addr_range1_end_addr => -1,
	addr_range1_offset => -1,
	addr_range2_end_addr => -1,
	addr_range2_offset => -1,
	addr_range3_offset => -1,
	is_compressed_image => "false",
	is_dual_boot => "false",
	is_eram_skip => "false",
	max_ufm_valid_addr => -1,
	max_valid_addr => -1,
	min_ufm_valid_addr => -1,
	min_valid_addr => -1,
	part_name => "quartus_created_unvm",
	reserve_block => "true")
-- pragma translate_on
PORT MAP (
	nosc_ena => \~QUARTUS_CREATED_GND~I_combout\,
	xe_ye => \~QUARTUS_CREATED_GND~I_combout\,
	se => \~QUARTUS_CREATED_GND~I_combout\,
	busy => \~QUARTUS_CREATED_UNVM~~busy\);

-- Location: ADCBLOCK_X43_Y52_N0
\~QUARTUS_CREATED_ADC1~\ : fiftyfivenm_adcblock
-- pragma translate_off
GENERIC MAP (
	analog_input_pin_mask => 0,
	clkdiv => 1,
	device_partname_fivechar_prefix => "none",
	is_this_first_or_second_adc => 1,
	prescalar => 0,
	pwd => 1,
	refsel => 0,
	reserve_block => "true",
	testbits => 66,
	tsclkdiv => 1,
	tsclksel => 0)
-- pragma translate_on
PORT MAP (
	soc => \~QUARTUS_CREATED_GND~I_combout\,
	usr_pwd => VCC,
	tsen => \~QUARTUS_CREATED_GND~I_combout\,
	chsel => \~QUARTUS_CREATED_ADC1~_CHSEL_bus\,
	eoc => \~QUARTUS_CREATED_ADC1~~eoc\);

-- Location: ADCBLOCK_X43_Y51_N0
\~QUARTUS_CREATED_ADC2~\ : fiftyfivenm_adcblock
-- pragma translate_off
GENERIC MAP (
	analog_input_pin_mask => 0,
	clkdiv => 1,
	device_partname_fivechar_prefix => "none",
	is_this_first_or_second_adc => 2,
	prescalar => 0,
	pwd => 1,
	refsel => 0,
	reserve_block => "true",
	testbits => 66,
	tsclkdiv => 1,
	tsclksel => 0)
-- pragma translate_on
PORT MAP (
	soc => \~QUARTUS_CREATED_GND~I_combout\,
	usr_pwd => VCC,
	tsen => \~QUARTUS_CREATED_GND~I_combout\,
	chsel => \~QUARTUS_CREATED_ADC2~_CHSEL_bus\,
	eoc => \~QUARTUS_CREATED_ADC2~~eoc\);

ww_out_sig_MUX4to1(0) <= \out_sig_MUX4to1[0]~output_o\;

ww_out_sig_MUX4to1(1) <= \out_sig_MUX4to1[1]~output_o\;

ww_out_sig_MUX4to1(2) <= \out_sig_MUX4to1[2]~output_o\;

ww_out_sig_MUX4to1(3) <= \out_sig_MUX4to1[3]~output_o\;

ww_out_sig_MUX4to1(4) <= \out_sig_MUX4to1[4]~output_o\;

ww_out_sig_MUX4to1(5) <= \out_sig_MUX4to1[5]~output_o\;

ww_out_sig_MUX4to1(6) <= \out_sig_MUX4to1[6]~output_o\;

ww_out_sig_MUX4to1(7) <= \out_sig_MUX4to1[7]~output_o\;
END structure;


