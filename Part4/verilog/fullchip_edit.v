// Created by prof. Mingu Kang @VVIP Lab in UCSD ECE department
// Please do not spread this code without permission 
module fullchip (clk, mem_in1, mem_in2, inst1, inst2, reset, out1, out2);

parameter col = 8;
parameter bw = 8;
parameter bw_psum = 2*bw+4;
parameter pr = 16;

input  clk; 
input  [pr*bw-1:0] mem_in1; 
input  [pr*bw-1:0] mem_in2; 
input  [18:0] inst1;
input  [18:0] inst2; 
input  reset;

output [bw_psum*col-1:0] out1;
output [bw_psum*col-1:0] out2;


wire [bw_psum+3:0] sum_out1;
wire [bw_psum+3:0] sum_out2;

wire fifo_ext_rd1;
wire fifo_ext_rd2;

wire o_full1;
wire o_empty1;

wire o_full2;
wire o_empty2;

assign fifo_ext_rd1 = inst2[18];
assign fifo_ext_rd2 = inst1[18];

fifo_depth16 #(.bw(bw_psum*col), .simd(1)) fifo1 (
		.rd_clk(clk),
		.wr_clk(clk),
		.in(sum_out2),
		.out(out1),
		.rd(fifo_ext_rd1),
		.wr(1'b1),
		.o_full(o_full1),
		.o_empty(o_empty1),
		.reset(reset)
	);

fifo_depth16 #(.bw(bw_psum*col), .simd(1)) fifo2 (
		.rd_clk(clk),
		.wr_clk(clk),
		.in(sum_out1),
		.out(out2),
		.rd(fifo_ext_rd2),
		.wr(1'b1),
		.o_full(o_full2),
		.o_empty(o_empty2),
		.reset(reset)
	);

core #(.bw(bw), .bw_psum(bw_psum), .col(col), .pr(pr)) core_instance1 (
      .reset(reset), 
      .clk(clk), 
      .mem_in(mem_in1), 
      .inst(inst1),
      .sum_in(sum_out2),
      .sum_out(sum_out1),
      .fifo_ext_rd(fifo_ext_rd1),
      .out(out1)
);


core #(.bw(bw), .bw_psum(bw_psum), .col(col), .pr(pr)) core_instance2(
      .reset(reset), 
      .clk(clk), 
      .mem_in(mem_in2), 
      .inst(inst2),
      .sum_in(sum_out1),
      .sum_out(sum_out2),
      .fifo_ext_rd(fifo_ext_rd2),
      .out(out2)
);


endmodule
