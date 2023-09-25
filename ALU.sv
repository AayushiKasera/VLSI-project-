module ALU(
input logic[31:0] SrcA,
input logic[31:0] SrcB,
input logic[2:0] ALUControl,
output logic[31:0] ALUResult,
output logic zero
);

always_comb
begin
	case (ALUControl)
	3'b010 : ALUResult = SrcA + SrcB;
	3'b110 : ALUResult = SrcA - SrcB;
	default : ALUResult = 0;
	endcase
	
	if(ALUResult == 0)
		zero <= 1;
	else
		zero <=0;
	
end



endmodule
