module  MUX_PCSrc(
input logic PCSrc,
input logic[31:0] instruction, // from sign extender
input logic[31:0] branch, //from register file RD2
output logic[31:0] PCSrc_out
);

always_comb
begin
	case (PCSrc)
	0 : PCSrc_out = instruction;
	1 : PCSrc_out = branch;
	default : PCSrc_out = instruction;
	endcase
end

endmodule