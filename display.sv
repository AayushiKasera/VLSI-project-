module display (input logic[31:0] data_in, output logic [13:0] two_segments);
 
logic [31:0] digits [1:0];
logic[31:0] data_in_complement;

assign data_in_complement = ~data_in + 1;

assign digits[1] = data_in / 10;
assign digits[0] = data_in - ((data_in/10)*10);

always_comb
begin
	if (data_in[31])
	begin
		two_segments <= {disp(data_in_complement - ((data_in_complement/10)*10)),7'b011_1111};
	end
	
	else
	begin
		two_segments <= {disp(digits[0]),disp(digits[1])};
	end
end 


function bit [6:0] disp (input logic[31:0] digit);
	
	logic [6:0] segments;
	
	case (digit) // Active low 7-segment dispaly
      //                      gfe_dcba		
      0 : segments =       7'b100_0000;		
      1 : segments =       7'b111_1001;	
      2 : segments =       7'b010_0100;
      3 : segments =       7'b011_0000;
      4 : segments =       7'b001_1001;
      5 : segments =       7'b001_0010;		
      6 : segments =       7'b000_0011;
      7 : segments =       7'b111_1000;	
      8 : segments =       7'b000_0000;		
      9 : segments =       7'b001_1000;		
		10: segments =       7'b000_1000; //A
		11: segments =       7'b000_0011; //b
		12: segments =       7'b010_0111; //c	
		13: segments =       7'b010_0001; //d	
		14: segments =       7'b000_0110; //E
		15: segments =       7'b000_1110; //F

      default: segments =  7'b111_1111;
   endcase
	
	return segments;
	 
endfunction 
	 
endmodule
