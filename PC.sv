module PC(
input logic clk, rst, //reset is assigned to switch
input logic[2:0] instruction_A, //address for instruction memory, input by switches
input logic RegWrite, MemWrite, //write enable signals for register_file and data memory assigned to 2 switches
input logic[3:0] beq_sw, //additional switches to input the last digit of your board number
input logic br,
output logic[31:0] prode_register_file,
output logic[31:0] prode_data_memory,
output logic[13:0] display_led_register, //7-segments display for register file
output logic[13:0] display_led_memory //7-segments display for memory
);

//instantiate all the modules..

logic[31:0] RD1, RD2;

logic[31:0] ALUResult;
logic[31:0] memoryResult;

logic[31:0] inst;

logic[31:0] signExtended;
logic[31:0] shifted;


logic[4:0] RegDst_out;
logic[31:0] ALUSrc_out;
logic[31:0] MemtoReg_out;

logic[31:0] inst_ex;


//logic[31:0] prode_register_file;
//logic[31:0] prode_data_memory;

logic zeroFlag;


MUX_PCSrc mux_pc(
.PCSrc(br&zeroFlag),
.instruction(instruction_A),
.branch(shifted),
.PCSrc_out(inst)
);

instruction_memory inst_mem(
.clk(clk),.rst(rst),
.Asw(instruction_A),
.beq_sw(beq_sw),
.RD(inst_ex)
);

MUX_RegDst mux_reg(
.RegDst(inst_ex[31]),
.rt(inst_ex[20:16]), // from 20:16
.rd(inst_ex[15:11]), //from 15:11 
.RegDst_out(RegDst_out)
);

register_file r_f(.clk(clk),.rst(rst),
.A1(inst_ex[25:21]),.A2(inst_ex[20:16]),.A3(RegDst_out),
.WD3(MemtoReg_out),
.WE3(RegWrite),
.RD1(RD1),
.RD2(RD2),
.prode(prode_register_file)
);


sign_extend sign(
.Imm(inst_ex[15:0]),
.SignImm(signExtended)
);

shiftLeft shift(
.a(signExtended),
.y(shifted)
);

MUX_ALUSrc mux_alu(
.ALUSrc(inst_ex[30]),
.signImm(signExtended),
.RD2(RD2),
.ALUSrc_out(ALUSrc_out)
);

ALU t1(
.SrcA(RD1),
.SrcB(ALUSrc_out),
.ALUControl(inst_ex[29:27]),
.ALUResult(ALUResult),
.zero(zeroFlag)
);

data_memory mem(
.clk(clk),.rst(rst),
.A(ALUResult),
.WD(RD2),
.WE(MemWrite),
.RD(memoryResult),
.prode(prode_data_memory)
);

MUX_MemtoReg mux_mem(
.MemtoReg(inst_ex[26]),
.ALUResult(ALUResult),
.ReadData(memoryResult), //from data memory
.MemtoReg_out(MemtoReg_out)
);

display display_reg(.data_in(prode_register_file), 
.two_segments(display_led_register));

display disaply_mem(.data_in(prode_data_memory), 
.two_segments(display_led_memory));


endmodule
