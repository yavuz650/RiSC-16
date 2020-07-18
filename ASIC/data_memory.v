//Data Memory for ASIC
//by Yavuz Selim Tozlu

`timescale 1ns/10ps


module  data_memory(clk0, csb0, web0, addr0, din0, dout0, reset);
	
	input clk0, csb0, web0, reset;
	input [5:0] addr0;
	input [15:0] din0;
	output reg [15:0] dout0;
	
	reg [15:0] data_mem_bank [0:63];
	
	always @(posedge clk0)
	begin
		if(!csb0)
		begin
			if(!reset)
			begin
				data_mem_bank[24] <= 16'hff8f; //data initialization
				data_mem_bank[25] <= 16'hffb4;
			end
			else if(web0)
			begin
				dout0 <= data_mem_bank[addr0];
			end
			else
			begin
				data_mem_bank[addr0] <= din0;
			end
		end
	end
endmodule 
