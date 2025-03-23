/////////////////////////////////////////////////////////////
// Created by: Synopsys DC Ultra(TM) in wire load mode
// Version   : K-2015.06-SP2
// Date      : Thu Mar 20 18:17:10 2025
/////////////////////////////////////////////////////////////


module fullchip ( clk, mem_in1, mem_in2, inst1, inst2, reset, out1, out2 );
  input [127:0] mem_in1;
  input [127:0] mem_in2;
  input [18:0] inst1;
  input [18:0] inst2;
  output [159:0] out1;
  output [159:0] out2;
  input clk, reset;

  tri   clk;
  tri   [127:0] mem_in1;
  tri   [127:0] mem_in2;
  tri   [18:0] inst1;
  tri   [18:0] inst2;
  tri   reset;
  tri   [159:0] out1;
  tri   [159:0] out2;
  tri   [23:0] sum_out2;
  tri   [23:0] sum_out1;

  core core_instance1 ( .reset(reset), .clk(clk), .mem_in(mem_in1), .inst(
        inst1), .sum_in(sum_out2), .sum_out(sum_out1), .fifo_ext_rd(inst2[18]), 
        .out(out1) );
  core core_instance2 ( .reset(reset), .clk(clk), .mem_in(mem_in2), .inst(
        inst2), .sum_in(sum_out1), .sum_out(sum_out2), .fifo_ext_rd(inst1[18]), 
        .out(out2) );
endmodule

