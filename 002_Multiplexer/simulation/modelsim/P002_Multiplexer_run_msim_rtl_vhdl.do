transcript on
if {[file exists rtl_work]} {
	vdel -lib rtl_work -all
}
vlib rtl_work
vmap work rtl_work

vcom -93 -work work {/home/ah/Documents/Workspace/FPGA/002_Multiplexer/P002_Multiplexer.vhd}

