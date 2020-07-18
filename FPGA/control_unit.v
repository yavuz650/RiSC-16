//Control Unit for FPGA
//by Yavuz Selim Tozlu

`timescale 1ns/10ps
(* DONT_TOUCH = "yes" *) 

module control_unit(muxpc, muxrf, muxalu1, muxalu2, muxtgt, funcalu, werf, wedmem,
			eq, op, wait_cycle);
input eq;
input [2:0] op;
output reg muxalu1, muxalu2, muxrf, werf, wedmem;
output reg [1:0] muxpc, muxtgt, funcalu, wait_cycle;

always @*
begin
	case(op)
		3'b000 : begin muxpc=2; muxrf=1; muxalu1=1; muxalu2=1; muxtgt=1; funcalu=0; werf=0; wedmem=1; wait_cycle=1; end //add - 3 cycles
	
		3'b001 : begin muxpc=2; muxrf=1; muxalu1=1; muxalu2=0; muxtgt=1; funcalu=0; werf=0; wedmem=1; wait_cycle=1; end //addi - 3 cycles

		3'b010 : begin muxpc=2; muxrf=1; muxalu1=1; muxalu2=1; muxtgt=1; funcalu=1; werf=0; wedmem=1; wait_cycle=1; end //nand - 3 cycles

		3'b011 : begin muxpc=2; muxrf=1; muxalu1=0; muxalu2=1; muxtgt=1; funcalu=2; werf=0; wedmem=1; wait_cycle=0; end //load upper-immediate - 2 cycles

		3'b100 : begin muxpc=2; muxrf=0; muxalu1=1; muxalu2=0; muxtgt=2; funcalu=0; werf=0; wedmem=1; wait_cycle=2; end //load word - 4 cycles

		3'b101 : begin muxpc=2; muxrf=0; muxalu1=1; muxalu2=0; muxtgt=2; funcalu=0; werf=1; wedmem=0; wait_cycle=1; end //store word - 3 cycles

		3'b110 : begin muxpc=(eq==1) ? 1 : 2; muxrf=0; muxalu1=1; muxalu2=1; muxtgt=1; funcalu=3; werf=1; wedmem=1; wait_cycle=2; end //branch if equal - 2 cycles

		3'b111 : begin muxpc=0; muxrf=1; muxalu1=1; muxalu2=1; muxtgt=0; funcalu=3; werf=0; wedmem=1; wait_cycle=0; end //jump and link through register - 2 cycles
	endcase
end

endmodule
