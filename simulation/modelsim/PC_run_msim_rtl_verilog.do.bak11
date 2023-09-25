transcript on
if {[file exists rtl_work]} {
	vdel -lib rtl_work -all
}
vlib rtl_work
vmap work rtl_work

vlog -sv -work work +incdir+E:/vlsi_project/vlsi {E:/vlsi_project/vlsi/instruction_memory.sv}
vlog -sv -work work +incdir+E:/vlsi_project/vlsi {E:/vlsi_project/vlsi/sign_extend.sv}
vlog -sv -work work +incdir+E:/vlsi_project/vlsi {E:/vlsi_project/vlsi/register_file.sv}
vlog -sv -work work +incdir+E:/vlsi_project/vlsi {E:/vlsi_project/vlsi/PC.sv}
vlog -sv -work work +incdir+E:/vlsi_project/vlsi {E:/vlsi_project/vlsi/MUX_RegDst.sv}
vlog -sv -work work +incdir+E:/vlsi_project/vlsi {E:/vlsi_project/vlsi/MUX_MemtoReg.sv}
vlog -sv -work work +incdir+E:/vlsi_project/vlsi {E:/vlsi_project/vlsi/MUX_ALUSrc.sv}
vlog -sv -work work +incdir+E:/vlsi_project/vlsi {E:/vlsi_project/vlsi/display.sv}
vlog -sv -work work +incdir+E:/vlsi_project/vlsi {E:/vlsi_project/vlsi/data_memory.sv}
vlog -sv -work work +incdir+E:/vlsi_project/vlsi {E:/vlsi_project/vlsi/ALU.sv}
vlog -sv -work work +incdir+E:/vlsi_project/vlsi {E:/vlsi_project/vlsi/MUX_PCSrc.sv}
vlog -sv -work work +incdir+E:/vlsi_project/vlsi {E:/vlsi_project/vlsi/shiftLeft.sv}

vlog -sv -work work +incdir+E:/vlsi_project/vlsi {E:/vlsi_project/vlsi/testbench_PC.sv}

vsim -t 1ps -L altera_ver -L lpm_ver -L sgate_ver -L altera_mf_ver -L altera_lnsim_ver -L cycloneive_ver -L rtl_work -L work -voptargs="+acc"  testbench_PC

add wave *
view structure
view signals
run -all
