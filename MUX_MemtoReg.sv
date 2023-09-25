module MUX_MemtoReg(
input logic MemtoReg,
input logic[31:0] ALUResult,
input logic[31:0] ReadData, //from data memory
output logic[31:0] MemtoReg_out
);

always_comb
begin
	case (MemtoReg)
	0 : MemtoReg_out = ALUResult;
	1 : MemtoReg_out = ReadData;
	default : MemtoReg_out = 0;
	endcase
end

endmodule
