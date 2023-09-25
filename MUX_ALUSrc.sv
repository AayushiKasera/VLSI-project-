module  MUX_ALUSrc(
input logic ALUSrc,
input logic[31:0] signImm, // from sign extender
input logic[31:0] RD2, //from register file RD2
output logic[31:0] ALUSrc_out
);

always_comb
begin
	case (ALUSrc)
	0 : ALUSrc_out = RD2;
	1 : ALUSrc_out = signImm;
	default : ALUSrc_out = 0;
	endcase
end

endmodule
