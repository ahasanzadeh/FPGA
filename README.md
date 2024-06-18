# FPGA Programming

The purpose of this repository is to start from practicing FPGA VHDL programming, and proide a base for embedded code development in Quartus II on INTEL/ALTERA MAX 10 10M50DAF484C6GES FPGA (DECA development board) as well as AMD/XILINX ZU+ MPSoC XCZU1CG-1SBVA484E FPGA (ZUBoard 1CG development board).

## Description

The following topics will be practised here on a MAX 10
* 

## Getting Started

### Dependencies

* Host can be any OS like Fedora 40 Linux in this case or Ubuntu, Windows etc.  

### Installing

* Install Quartus II v20.1.1. You just need to put ModelSim v2020 and MAX10 FPGA in the same folder, and they will be installed along with Quartus automatically. 

### Executing program

#### LED On/Off

* 8 LEDs on MAX 10 FPGA board turn on/off via hitting push button 1 (no clock involved). Each folder comes with Quartus II project file (.qpf), Quartus II setting file (.qsf), top-level design file (.vhd), synopsis design constraints file (.sdc), and ModelSim testbench file (.vht). Some project does not have ModelSim testbench file (.vht). In Quartus II, first each project needs to be compiled (Ctrl + L), then either programmed into FPGA using Tools-> Programmer (Alt + T + P) by selecting right JTAG programmer (blaster) or simulated via ModelSiM using Tools -> Run Simulation Tools -> RTL Simulation (Alt + T + R). No ModelSim simulation for this example.

#### LED Blinking

* 8 LEDs on MAX 10 FPGA board blink on/off (no push button involved). Follow corresponding oder for "LED On/Off" above. No ModelSim simulation for this example.

#### Multiplexer

* 8 bits, 4 to 1 multiplexer is simulated via ModelSim. Follow corresponding oder for "LED On/Off" above. No implementation on MAX 10 FPGA board for this example. 

#### Flip Flop

* A clocked process flip flop is simulated via ModelSim and implemented on MAX 10 FPGA board. Follow corresponding oder for "LED On/Off" above. 

#### Timer with If/Else

* A timer with if/else operands is simulated via ModelSim and implemented on MAX 10 FPGA board. Follow corresponding oder for "LED On/Off" above. 

#### Timer with Procedure

* A timer with procedure operand is simulated via ModelSim and implemented on MAX 10 FPGA board. Follow corresponding oder for "LED On/Off" above. 

#### PWM

* A PWM (a VHDL translation of LED breathe already exist Verilog example of this evaluation board) is implemented on MAX 10 FPGA board. Follow corresponding oder for "LED On/Off" above. 

#### State Machine with If/Else

* A state machine for a trafic light with if/else operands is simulated via ModelSim and implemented on MAX 10 FPGA board. Follow corresponding oder for "LED On/Off" above. 

#### State Machine with Function

* A state machine for a trafic light with function operands is simulated via ModelSim and implemented on MAX 10 FPGA board. Follow corresponding oder for "LED On/Off" above. 

#### State Machine with Impure Function

* A state machine for a trafic light with impure function operands is simulated via ModelSim and implemented on MAX 10 FPGA board. Follow corresponding oder for "LED On/Off" above. 

#### State Machine with Procedure

* A state machine for a trafic light with procedure operands is simulated via ModelSim and implemented on MAX 10 FPGA board. Follow corresponding oder for "LED On/Off" above. 

## Help

TBD

## Authors

Contributors names and contact info

TBD

## Version History

* 0.1
    * Initial Release

## License

This project is licensed under the FREE License - see the LICENSE.md file for details

## Acknowledgments

Inspiration, code snippets, etc.
* [ah](https://github.com/ahasanzadeh/)