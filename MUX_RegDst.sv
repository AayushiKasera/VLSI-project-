module  MUX_RegDst(
input logic RegDst,
input logic[4:0] rt, // from 20:16
input logic[4:0] rd, //from 15:11 
output logic[4:0] RegDst_out
);

always_comb
begin
	case (RegDst)
	0 : RegDst_out = rt;
	1 : RegDst_out = rd;
	default : RegDst_out = 0;
	endcase
end

endmodule
