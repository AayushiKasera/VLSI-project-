module testbench_PC();

logic clk, rst;
logic[2:0] instruction_A; 
logic RegWrite, MemWrite;
logic[3:0] beq_sw;
logic[31:0] prode_register_file;
logic[31:0] prode_data_memory;
logic[6:0] display_led_register; 
logic[6:0] display_led_memory;

PC uut(
clk, rst,
instruction_A,
RegWrite, MemWrite,
beq_sw,
br,
prode_register_file,
prode_data_memory,
display_led_register,
display_led_memory
);

initial begin
	rst = 0;
	#50 rst = 1;
end

initial begin
	clk = 0;
	forever #25 clk = ~clk;
end

initial begin
	instruction_A = 0;
	#100
	instruction_A = 1;
	#100
	instruction_A = 2;
	#100
	instruction_A = 3;
	#100
	instruction_A = 4;
	#100
	instruction_A = 5;
end

initial begin
	beq_sw = 0;
	MemWrite = 0;
	RegWrite = 0;
	#100
	MemWrite = 0;
	RegWrite = 1;
	#100
	MemWrite = 1;
	RegWrite = 0;
	#100
	MemWrite = 0;
	RegWrite = 1;
	#200
	MemWrite = 0;
	RegWrite = 0;
	beq_sw = 1;
	#100
	MemWrite = 0;
	RegWrite = 1;
	beq_sw = 2;
end

endmodule
