//Testbench of CPU core for ASIC
//by Yavuz Selim Tozlu

`timescale 1 ns/10 ps
`include  "/vlsi/kits/tsmc/lib/90lp/TSMCHOME/digital/Front_End/verilog/tcbn90lpbwp14t_211a/tcbn90lpbwp14t.v"

module cpu_core_test();

reg clk0,reset;

cpu_core uut (.clk0(clk0), .reset(reset));
initial $sdf_annotate("cpu_core.sdf", uut, , ,  "maximum");
always
begin
clk0=0; #50; clk0=1; #50;
end

initial begin
reset=0;
#100;
reset=1;
end

endmodule
