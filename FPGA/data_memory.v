//Data Memory for FPGA
//by Yavuz Selim Tozlu
//Change the memory content directory accordingly

`timescale 1ns/10ps
module  data_memory(clk0, csb0, web0, addr0, din0, dout0);
	
	input clk0, csb0, web0;
	input [5:0] addr0;
	input [15:0] din0;
	output reg [15:0] dout0;	
	reg [15:0] data_memory_bank [0:63];
	initial $readmemh ("D:/Xilinx/Projects/vlsi_ii/data_memory_contents.mem", data_memory_bank) ;
	always @(posedge clk0)
	begin
		if(!csb0)
		begin
			if(web0)
			begin
				dout0 <= data_memory_bank[addr0];
			end
			else
			begin
				data_memory_bank[addr0] <= din0;
			end
		end
	end
endmodule 
