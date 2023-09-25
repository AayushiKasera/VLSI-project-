module instruction_memory(
input logic clk, rst,
input logic[2:0] Asw, //address input by swicthes
input logic[3:0] beq_sw, //condition switches for BEQ, these 4 switches are used to input the last digit of your board number
output logic[31:0] RD //output data, instrunction
);

logic [31:0] ins_regs [5:0];

//write sone logic here to achieve BEQ

localparam Number = 2;// beq_sw  
localparam imm = 1; // instruction 

logic [2:0] internal_Addr;

//If our switches match board number go to 1 else move to resting instruction
assign internal_Addr = (Asw == 3'b101)? (beq_sw == Number) ? imm:3'b000 : Asw; 


always @(posedge clk or negedge rst)
begin
	if (!rst) begin
		//I-type instrunction = op[5:0] + rs[4:0] + rt [4:0] + imm[15:0]
		//R-type instrunction = op[5:0] + rs[4:0] + rt [4:0] + rd[4:0] + func[10:0]
		// set Inst[0] as 0, so when A = 0, the instruction does nothing
		ins_regs[0] <= 32'b0;
		//1st Inst : LW load data_reg[5] to rf_reg[1], rs = 0, rt = 7, imm = 2 (result: rf_reg[7] = 2) 
		ins_regs[1] = 32'b010101_00000_00111_0000000000000010;
		//2st Inst : SW store rf_reg[2] to data_reg[2], rs = 0, rt = 6, imm = 4 (result: data_reg[4] = 6) 
		ins_regs[2] <= 32'b010100_00000_00110_0000000000000100;	
		//3rd Inst : ADD rf_reg[5] and rf_reg[1] to rf_reg[2] (result : rf_reg[1] = 3 + 9 = 12)
		ins_regs[3] <= 32'b100100_00011_01001_00001_00000000000;
		//4th Inst : SUB rf_reg[2] and rf_reg[7] to rf_reg[1] (result : rf_reg[1] = 2 - 7 = -5)
		ins_regs[4] <= 32'b101100_00010_00111_00001_00000000000;
		//5th Inst : set traget instruction to 1st instruction, set op=rs=rt=0, imm = 1 (results: rf_reg[7] = 2)
		ins_regs[5] <= 32'b000000_00000_00000_0000000000000001;
	end
	
	else begin
		RD <= ins_regs[internal_Addr];
	end
	
end


endmodule

// inst_a [2] inst_a [1] inst_a [0]
//	0               0          1
//	0               1          0
//	0               1          1
//	1               0          0
//	1               0          1


// beq_sw[3] [2] [1] [0]
// 0 0 0 0 //0
// 0 0 0 1 //1
// 0 0 1 0 //2 
// 0 0 1 1 //3
// 0 1 0 0 //4  
// 0 1 0 1 //5