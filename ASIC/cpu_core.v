`timescale 1ns/10ps

module cpu_core(reset, clk0);
input reset, clk0;

wire [1:0] n_muxpc;
wire n_muxalu1, n_muxalu2, n_muxrf;
wire [1:0] n_muxtgt, n_funcalu;
wire n_werf, n_wedmem;
wire n_eq;
wire [15:0] n_aluout, n_muxalu1out, n_muxalu2out, n_signextendout, n_leftshiftout, n_src1data, n_src2data;
wire [2:0] n_muxrfout;
wire [15:0] n_datamemoryout, n_muxtgtout;

wire [2:0] n_op, n_ra, n_rb, n_rc;
wire [9:0] n_simmimm;
wire [6:0] n_simm7;
wire [5:0] n_pcout;
wire [5:0] n_muxpcout, n_plus1out, n_addout;
wire [1:0] n_waitcycle;

wire [15:0] instruction_register;


ALU 		    ALU1(.src1(n_muxalu1out), .src2(n_muxalu2out), .func(n_funcalu), .ALU_out(n_aluout), .eq(n_eq));

register_file 	    REGISTER_FILE(.src1_addr(n_rb), .src2_addr(n_muxrfout), .tgt_addr(n_ra), .src1_data(n_src1data), .src2_data(n_src2data), .tgt_data(n_muxtgtout), .werf(n_werf), .clk0(clk0), .csb0(1'b0));

data_memory 	    DATA_MEMORY(.clk0(clk0), .csb0(1'b0), .web0(n_wedmem), .addr0(n_aluout[5:0]), .din0(n_src2data), .dout0(n_datamemoryout), .reset(reset));

instruction_memory  INSTRUCTION_MEMORY(.clk0(clk0), .csb0(1'b0), .addr0(n_pcout), .dout0(instruction_register), .reset(reset));

control_unit 	    CNTRL_UNIT(.muxpc(n_muxpc), .muxrf(n_muxrf), .muxalu1(n_muxalu1), .muxalu2(n_muxalu2), .muxtgt(n_muxtgt), .funcalu(n_funcalu), .werf(n_werf), .wedmem(n_wedmem), .eq(n_eq), .op(n_op), .wait_cycle(n_waitcycle));

program_counter     PC(.clk0(clk0), .wait_cycle(n_waitcycle), .address_in(n_muxpcout[5:0]), .address_out(n_pcout), .reset(reset));


assign n_muxalu1out = (n_muxalu1==0) ? n_leftshiftout : n_src1data;  //muxalu1
assign n_muxalu2out = (n_muxalu2==0) ? n_signextendout : n_src2data; //muxalu2

assign n_muxtgtout = (n_muxtgt==0) ? n_plus1out : ( (n_muxtgt==1) ? n_aluout : n_datamemoryout ); //muxtgt
assign n_muxpcout = (n_muxpc==0) ? n_aluout[5:0] : ( (n_muxpc==1) ? n_addout : n_plus1out ); //muxpc

assign n_muxrfout = (n_muxrf==0) ? n_ra : n_rc; //muxrf

assign n_signextendout = { {10{n_simmimm[6]}} ,n_simmimm[5:0]}; //sign extend
assign n_leftshiftout = { n_simmimm[9:0], {6{1'b0}} }; //left shift

assign n_addout = n_plus1out + n_signextendout[5:0]; //add
assign n_plus1out = n_pcout + 1; //plus 1


assign n_op = instruction_register[15:13];
assign n_ra = instruction_register[12:10];
assign n_rb = instruction_register[9:7];
assign n_rc = instruction_register[2:0];
assign n_simmimm = instruction_register[9:0];
assign n_simm7 = instruction_register[6:0];

endmodule
