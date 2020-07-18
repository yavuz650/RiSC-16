//Instruction Memory for ASIC
//by Yavuz Selim Tozlu

`timescale 1ns/10ps


module instruction_memory(clk0, csb0, addr0, dout0, reset);
	
	input clk0, csb0, reset;
	input [5:0] addr0;
	output reg [15:0] dout0;
	
	reg [15:0] instruction_mem_bank [0:63];
	
	always @(posedge clk0)
	begin
		if(!csb0)
		begin
			if(!reset)
			begin
				instruction_mem_bank[0]<=16'h8418;
				instruction_mem_bank[1]<=16'h8819;
				instruction_mem_bank[2]<=16'h3400;
				instruction_mem_bank[3]<=16'hc092;
				instruction_mem_bank[4]<=16'hc111;
				instruction_mem_bank[5]<=16'h2c01;
				instruction_mem_bank[6]<=16'hc18f;
				instruction_mem_bank[7]<=16'h5103;
				instruction_mem_bank[8]<=16'h5204;
				instruction_mem_bank[9]<=16'hd182;
				instruction_mem_bank[10]<=16'h0d83;
				instruction_mem_bank[11]<=16'hc07a;
				instruction_mem_bank[12]<=16'h3801;
				instruction_mem_bank[13]<=16'h1c80;
				instruction_mem_bank[14]<=16'hc003;
				instruction_mem_bank[15]<=16'h0d83;
				instruction_mem_bank[16]<=16'h1687;
				instruction_mem_bank[17]<=16'hc074;
				instruction_mem_bank[18]<=16'hd9fc;
				instruction_mem_bank[19]<=16'h1f87;
				instruction_mem_bank[20]<=16'h1b06;
				instruction_mem_bank[21]<=16'hc07c;
				instruction_mem_bank[22]<=16'hb400;
				instruction_mem_bank[23]<=16'hc07f;
				dout0 <= 16'h0000;
			end
			else
				dout0 <= instruction_mem_bank[addr0];
		end
	end
endmodule 
