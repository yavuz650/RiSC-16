//Control Unit for ASIC
//by Yavuz Selim Tozlu

`timescale 1ns/10ps

module control_unit(muxpc, muxrf, muxalu1, muxalu2, muxtgt, funcalu, werf, wedmem,
			eq, op, wait_cycle);
input eq;
input [2:0] op;
output reg muxalu1, muxalu2, muxrf, werf, wedmem;
output reg [1:0] muxpc, muxtgt, funcalu, wait_cycle;

always @*
begin
	case(op)
		3'b000 : begin muxpc=2'b10; muxrf=1'b1; muxalu1=1'b1; muxalu2=1'b1; muxtgt=2'b01; funcalu=2'b00; werf=1'b0; wedmem=1'b1; wait_cycle=2'b01; end //add - 3 cycles
	
		3'b001 : begin muxpc=2'b10; muxrf=1'b1; muxalu1=1'b1; muxalu2=1'b0; muxtgt=2'b01; funcalu=2'b00; werf=1'b0; wedmem=1'b1; wait_cycle=2'b01; end //addi - 3 cycles

		3'b010 : begin muxpc=2'b10; muxrf=1'b1; muxalu1=1'b1; muxalu2=1'b1; muxtgt=2'b01; funcalu=2'b01; werf=1'b0; wedmem=1'b1; wait_cycle=2'b01; end //nand - 3 cycles

		3'b011 : begin muxpc=2'b10; muxrf=1'b1; muxalu1=1'b0; muxalu2=1'b1; muxtgt=2'b01; funcalu=2'b10; werf=1'b0; wedmem=1'b1; wait_cycle=2'b00; end //load upper-immediate - 2 cycles

		3'b100 : begin muxpc=2'b10; muxrf=1'b0; muxalu1=1'b1; muxalu2=1'b0; muxtgt=2'b10; funcalu=2'b00; werf=1'b0; wedmem=1'b1; wait_cycle=2'b10; end //load word - 4 cycles

		3'b101 : begin muxpc=2'b10; muxrf=1'b0; muxalu1=1'b1; muxalu2=1'b0; muxtgt=2'b10; funcalu=2'b00; werf=1'b1; wedmem=1'b0; wait_cycle=2'b01; end //store word - 3 cycles

		3'b110 : begin muxpc=(eq==1'b1) ? 2'b01 : 2'b10; muxrf=1'b0; muxalu1=1'b1; muxalu2=1'b1; muxtgt=2'b01; funcalu=2'b11; werf=1'b1; wedmem=1'b1; wait_cycle=2'b10; end //branch if equal - 2 cycles

		3'b111 : begin muxpc=2'b00; muxrf=1'b1; muxalu1=1'b1; muxalu2=1'b1; muxtgt=2'b00; funcalu=2'b11; werf=1'b0; wedmem=1'b1; wait_cycle=2'b00; end //jump and link through register - 2 cycles
	endcase
end

endmodule
