module register_file (input logic clk, rst,
input logic[4:0] A1, A2, A3, //A1,A2,A A3 are the address
input logic[31:0] WD3, //data from data memory
input logic WE3, //WE3 = 1, write register file
output logic[31:0] RD1, //output port one for register file
output logic[31:0] RD2, //output port two for register file
output logic[31:0] prode //prode to check the result in the register file
);

localparam numOfReg = 32;
localparam lenOfReg = 32;

logic [lenOfReg-1:0] rf_regs [numOfReg-1:0];

always @(posedge clk or negedge rst) // positive edge of clock and negative edge of reset
begin
	if (!rst) // initialize register[i] = i when reset is 0 (Active Low)
	begin
		for(int i = 0; i < numOfReg ; i++)
		begin
			rf_regs[i] <= i;
			//rf_regs[i] <= 0;
		end
	end
	else
	begin
		if (WE3) // write to register file on rising edge of clock and reset is 1 (active low reset)
		begin
			rf_regs[A3] <= WD3;
		end
	end
end

assign RD1 = rf_regs[A1];
assign RD2 = rf_regs[A2];

assign prode = rf_regs[A3];

endmodule
