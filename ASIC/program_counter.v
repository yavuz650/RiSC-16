//Program Counter for ASIC
//by Yavuz Selim Tozlu

`timescale 1ns/10ps

module program_counter(clk0, wait_cycle, address_in, address_out, reset);

input clk0, reset;
input [1:0] wait_cycle;
input [5:0] address_in;
output [5:0] address_out;

reg [5:0] address_register;
reg [1:0] counter;

always @(posedge clk0)
begin
	if(!reset)
	begin
		address_register <= 6'b000000;
		counter <= 2'b00;
	end
	else if(counter != (wait_cycle))
	begin
		counter <= counter+1;
	end
	else
	begin
		address_register <= address_in;
		counter <= 2'b00;
	end
end
assign address_out = address_register;

endmodule


