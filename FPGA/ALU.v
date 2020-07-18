//ALU for FPGA
//by Yavuz Selim Tozlu

`timescale 1 ns/10 ps

module ALU(
		input  [15:0] src1,
		input  [15:0] src2,
		input  [1:0]  func,
		
		output reg [15:0] ALU_out,
		output wire eq);

always @*
begin
	case(func)
		2'b00 : ALU_out = src1+src2; //add
		2'b01 : ALU_out = ~(src1 & src2); //nand
		2'b10 : ALU_out = {src2[15:6] , 6'b0}; // load upper immediate
		2'b11 : ALU_out = src1; //pass1
	endcase
end	

assign eq = (src1==src2) ? 1 : 0;

endmodule

