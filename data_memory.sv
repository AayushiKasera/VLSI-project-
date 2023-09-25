 module data_memory(
input logic clk,rst,
input logic[31:0] A, //address
input logic[31:0] WD, //input data
input logic WE, //enable input
output logic[31:0] RD,
output logic[31:0] prode //to check the data in data memory
);

localparam depth  = 32;
localparam width = 32;

logic [width-1:0] RAM[depth-1:0];

always @(posedge clk or negedge rst)
begin
	if(!rst) // Initalize when reset 0
	begin
		for(int i = 0; i < depth ; i++)
		begin
			RAM[i] <= i;
		end
	end

	else // write on posedge of clk and reset is 1
	begin
		if (WE) 
			RAM[A] <= WD;
	end
end


assign RD = RAM[A];

assign prode = RAM[A];

endmodule
