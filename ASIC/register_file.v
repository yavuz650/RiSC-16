//Register File for ASIC
//by Yavuz Selim Tozlu

`timescale 1 ns/10 ps

module register_file(src1_addr, src2_addr, tgt_addr, src1_data, src2_data, tgt_data, werf, clk0, csb0);
input werf, clk0, csb0;
input [2:0] src1_addr, src2_addr, tgt_addr;
output reg [15:0] src1_data, src2_data;
input [15:0] tgt_data;

reg [15:0] register_bank [7:0];


always @(posedge clk0)
begin
	if(!csb0) 
	begin
		if(!werf) //write to target address
			register_bank[tgt_addr] <= tgt_data;
		if(src1_addr == 3'b000)
			src1_data <= 16'h0000;
		else
			src1_data <= register_bank[src1_addr];
		if(src2_addr == 3'b000)
			src2_data <= 16'h0000;
		else
		src2_data <= register_bank[src2_addr];
	end
end
endmodule
