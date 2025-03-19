// Created by prof. Mingu Kang @VVIP Lab in UCSD ECE department
// Please do not spread this code without permission 

`timescale 1ns/1ps

module fullchip_tb;

parameter total_cycle = 8;   // how many streamed Q vectors will be processed
parameter bw = 8;            // Q & K vector bit precision
parameter bw_psum = 2*bw+4;  // partial sum bit precision
parameter pr = 16;           // how many products added in each dot product 
parameter col = 8;           // how many dot product units are equipped

integer qk_file ; // file handler
integer qk_scan_file ; // file handler


integer qk1_file ; // file handler
integer qk1_scan_file ; // file handler



integer  captured_data;
integer  captured_data1;

integer  weight [col*pr-1:0];

`define NULL 0




integer  K1[col-1:0][pr-1:0];
integer  K2[col-1:0][pr-1:0];

integer  Q1[total_cycle-1:0][pr-1:0];
integer  Q2[total_cycle-1:0][pr-1:0];

integer  result1[total_cycle-1:0][col-1:0];
integer  result2[total_cycle-1:0][col-1:0];

integer  sum1[total_cycle-1:0];
integer  sum2[total_cycle-1:0];

integer i,j,k,t,p,q,s,u, m;





reg reset = 1;
reg clk = 0;
reg [pr*bw-1:0] mem_in1; 
reg [pr*bw-1:0] mem_in2; 
reg ofifo_rd = 0;
wire [bw_psum+3:0] out1;
wire [bw_psum+3:0] out2;	
wire [18:0] inst1; 
wire [18:0] inst2; 
reg qmem_rd = 0;
reg qmem_wr = 0; 
reg kmem_rd = 0; 
reg kmem_wr = 0;
reg pmem_rd = 0; 
reg pmem_wr = 0; 
reg execute = 0;
reg load = 0;
reg acc = 0;
reg div = 0;
reg [3:0] qkmem_add = 0;
reg [3:0] pmem_add = 0;

assign inst1[18] = div;
assign inst1[17] = acc;
assign inst1[16] = ofifo_rd;
assign inst1[15:12] = qkmem_add;
assign inst1[11:8]  = pmem_add;
assign inst1[7] = execute;
assign inst1[6] = load;
assign inst1[5] = qmem_rd;
assign inst1[4] = qmem_wr;
assign inst1[3] = kmem_rd;
assign inst1[2] = kmem_wr;
assign inst1[1] = pmem_rd;
assign inst1[0] = pmem_wr;

assign inst2[18] = div;
assign inst2[17] = acc;
assign inst2[16] = ofifo_rd;
assign inst2[15:12] = qkmem_add;
assign inst2[11:8]  = pmem_add;
assign inst2[7] = execute;
assign inst2[6] = load;
assign inst2[5] = qmem_rd;
assign inst2[4] = qmem_wr;
assign inst2[3] = kmem_rd;
assign inst2[2] = kmem_wr;
assign inst2[1] = pmem_rd;
assign inst2[0] = pmem_wr;




reg [bw_psum-1:0] temp5b1;
reg [bw_psum+3:0] temp_sum1;
reg [bw_psum*col-1:0] temp16b1;


reg [bw_psum-1:0] temp5b2;
reg [bw_psum+3:0] temp_sum2;
reg [bw_psum*col-1:0] temp16b2;




fullchip #(.bw(bw), .bw_psum(bw_psum), .col(col), .pr(pr)) fullchip_instance (
      .reset(reset),
      .clk(clk), 
      .mem_in1(mem_in1), 
      .mem_in2(mem_in2),
      .inst1(inst1),
      .inst2(inst2),
      .out1(out1),
      .out2(out2)
);


initial begin 

  $dumpfile("fullchip_tb.vcd");
  $dumpvars(0,fullchip_tb);



///// Q data txt reading /////

$display("##### Q data txt reading #####");


  qk_file = $fopen("qdata.txt", "r");

  //// To get rid of first 3 lines in data file ////
  qk_scan_file = $fscanf(qk_file, "%s\n", captured_data);
  qk_scan_file = $fscanf(qk_file, "%s\n", captured_data);
  qk_scan_file = $fscanf(qk_file, "%s\n", captured_data);
  qk_scan_file = $fscanf(qk_file, "%s\n", captured_data);


  for (q=0; q<total_cycle; q=q+1) begin
    for (j=0; j<pr; j=j+1) begin
          qk_scan_file = $fscanf(qk_file, "%d\n", captured_data);
          Q1[q][j] = captured_data;
          Q2[q][j] = captured_data;
          //$display("%d\n", K[q][j]);
    end
  end
/////////////////////////////////




  for (q=0; q<8; q=q+1) begin
    #0.5 clk = 1'b0;   
    #0.5 clk = 1'b1;   
  end




///// K data txt reading /////

$display("##### K data txt reading #####");

  for (q=0; q<10; q=q+1) begin
    #0.5 clk = 1'b0;   
    #0.5 clk = 1'b1;   
  end
  reset = 0;

  qk_file = $fopen("kdata_core0.txt", "r");
  qk1_file = $fopen("kdata_core1.txt", "r");
  


  //// To get rid of first 4 lines in data file ////
  qk_scan_file = $fscanf(qk_file, "%s\n", captured_data);
  qk_scan_file = $fscanf(qk_file, "%s\n", captured_data);
  qk_scan_file = $fscanf(qk_file, "%s\n", captured_data);
  qk_scan_file = $fscanf(qk_file, "%s\n", captured_data);

  
  //// To get rid of first 4 lines in data file ////
  qk1_scan_file = $fscanf(qk1_file, "%s\n", captured_data1);
  qk1_scan_file = $fscanf(qk1_file, "%s\n", captured_data1);
  qk1_scan_file = $fscanf(qk1_file, "%s\n", captured_data1);
  qk1_scan_file = $fscanf(qk1_file, "%s\n", captured_data1);





  for (q=0; q<col; q=q+1) begin
    for (j=0; j<pr; j=j+1) begin
          qk_scan_file = $fscanf(qk_file, "%d\n", captured_data);
          qk1_scan_file = $fscanf(qk1_file, "%d\n", captured_data1);
          K1[q][j] = captured_data;
          K2[q][j] = captured_data1;
          //$display("##### %d\n", K[q][j]);
    end
  end
/////////////////////////////////








/////////////// Estimated result printing /////////////////


$display("##### Estimated multiplication result #####");

  for (t=0; t<total_cycle; t=t+1) begin
     for (q=0; q<col; q=q+1) begin
       result1[t][q] = 0;
       result2[t][q] = 0;       
     end
  end

  for (t=0; t<total_cycle; t=t+1) begin
     for (q=0; q<col; q=q+1) begin
         for (k=0; k<pr; k=k+1) begin
            result1[t][q] = result1[t][q] + Q1[t][k] * K1[q][k];
            result2[t][q] = result2[t][q] + Q2[t][k] * K2[q][k];
         end

         temp5b1 = result1[t][q];
         temp16b1 = {temp16b1[139:0], temp5b1};

	 
         temp5b2 = result2[t][q];
         temp16b2 = {temp16b2[139:0], temp5b2};

     end

     //$display("%d %d %d %d %d %d %d %d", result[t][0], result[t][1], result[t][2], result[t][3], result[t][4], result[t][5], result[t][6], result[t][7]);
     $display("Core 1 prd @cycle%2d: %40h", t, temp16b1);
     $display("Core 2 prd @cycle%2d: %40h", t, temp16b2);
     
  end

//////////////////////////////////////////////






///// Qmem writing  /////

$display("##### Qmem writing  #####");

  for (q=0; q<total_cycle; q=q+1) begin

    #0.5 clk = 1'b0;  
    qmem_wr = 1;  if (q>0) qkmem_add = qkmem_add + 1; 
    
    mem_in1[1*bw-1:0*bw] = Q1[q][0];
    mem_in1[2*bw-1:1*bw] = Q1[q][1];
    mem_in1[3*bw-1:2*bw] = Q1[q][2];
    mem_in1[4*bw-1:3*bw] = Q1[q][3];
    mem_in1[5*bw-1:4*bw] = Q1[q][4];
    mem_in1[6*bw-1:5*bw] = Q1[q][5];
    mem_in1[7*bw-1:6*bw] = Q1[q][6];
    mem_in1[8*bw-1:7*bw] = Q1[q][7];
    mem_in1[9*bw-1:8*bw] = Q1[q][8];
    mem_in1[10*bw-1:9*bw] = Q1[q][9];
    mem_in1[11*bw-1:10*bw] = Q1[q][10];
    mem_in1[12*bw-1:11*bw] = Q1[q][11];
    mem_in1[13*bw-1:12*bw] = Q1[q][12];
    mem_in1[14*bw-1:13*bw] = Q1[q][13];
    mem_in1[15*bw-1:14*bw] = Q1[q][14];
    mem_in1[16*bw-1:15*bw] = Q1[q][15];

    mem_in2[1*bw-1:0*bw] = Q2[q][0];
    mem_in2[2*bw-1:1*bw] = Q2[q][1];
    mem_in2[3*bw-1:2*bw] = Q2[q][2];
    mem_in2[4*bw-1:3*bw] = Q2[q][3];
    mem_in2[5*bw-1:4*bw] = Q2[q][4];
    mem_in2[6*bw-1:5*bw] = Q2[q][5];
    mem_in2[7*bw-1:6*bw] = Q2[q][6];
    mem_in2[8*bw-1:7*bw] = Q2[q][7];
    mem_in2[9*bw-1:8*bw] = Q2[q][8];
    mem_in2[10*bw-1:9*bw] = Q2[q][9];
    mem_in2[11*bw-1:10*bw] = Q2[q][10];
    mem_in2[12*bw-1:11*bw] = Q2[q][11];
    mem_in2[13*bw-1:12*bw] = Q2[q][12];
    mem_in2[14*bw-1:13*bw] = Q2[q][13];
    mem_in2[15*bw-1:14*bw] = Q2[q][14];
    mem_in2[16*bw-1:15*bw] = Q2[q][15];


    #0.5 clk = 1'b1;  

  end


  #0.5 clk = 1'b0;  
  qmem_wr = 0; 
  qkmem_add = 0;
  #0.5 clk = 1'b1;  
///////////////////////////////////////////





///// Kmem writing  /////

$display("##### Kmem writing #####");

  for (q=0; q<col; q=q+1) begin

    #0.5 clk = 1'b0;  
    kmem_wr = 1; if (q>0) qkmem_add = qkmem_add + 1; 
    
    mem_in1[1*bw-1:0*bw] = K1[q][0];
    mem_in1[2*bw-1:1*bw] = K1[q][1];
    mem_in1[3*bw-1:2*bw] = K1[q][2];
    mem_in1[4*bw-1:3*bw] = K1[q][3];
    mem_in1[5*bw-1:4*bw] = K1[q][4];
    mem_in1[6*bw-1:5*bw] = K1[q][5];
    mem_in1[7*bw-1:6*bw] = K1[q][6];
    mem_in1[8*bw-1:7*bw] = K1[q][7];
    mem_in1[9*bw-1:8*bw] = K1[q][8];
    mem_in1[10*bw-1:9*bw] = K1[q][9];
    mem_in1[11*bw-1:10*bw] = K1[q][10];
    mem_in1[12*bw-1:11*bw] = K1[q][11];
    mem_in1[13*bw-1:12*bw] = K1[q][12];
    mem_in1[14*bw-1:13*bw] = K1[q][13];
    mem_in1[15*bw-1:14*bw] = K1[q][14];
    mem_in1[16*bw-1:15*bw] = K1[q][15];

    mem_in2[1*bw-1:0*bw] = K2[q][0];
    mem_in2[2*bw-1:1*bw] = K2[q][1];
    mem_in2[3*bw-1:2*bw] = K2[q][2];
    mem_in2[4*bw-1:3*bw] = K2[q][3];
    mem_in2[5*bw-1:4*bw] = K2[q][4];
    mem_in2[6*bw-1:5*bw] = K2[q][5];
    mem_in2[7*bw-1:6*bw] = K2[q][6];
    mem_in2[8*bw-1:7*bw] = K2[q][7];
    mem_in2[9*bw-1:8*bw] = K2[q][8];
    mem_in2[10*bw-1:9*bw] = K2[q][9];
    mem_in2[11*bw-1:10*bw] = K2[q][10];
    mem_in2[12*bw-1:11*bw] = K2[q][11];
    mem_in2[13*bw-1:12*bw] = K2[q][12];
    mem_in2[14*bw-1:13*bw] = K2[q][13];
    mem_in2[15*bw-1:14*bw] = K2[q][14];
    mem_in2[16*bw-1:15*bw] = K2[q][15];


    #0.5 clk = 1'b1;  

  end

  #0.5 clk = 1'b0;  
  kmem_wr = 0;  
  qkmem_add = 0;
  #0.5 clk = 1'b1;  
///////////////////////////////////////////



  for (q=0; q<10; q=q+1) begin
    #0.5 clk = 1'b0;  
    #0.5 clk = 1'b1;   
  end




/////  K data loading  /////
$display("##### K data loading to processor #####");

  for (q=0; q<col+1; q=q+1) begin
    #0.5 clk = 1'b0;  
    load = 1; 
    if (q==1) kmem_rd = 1;
    if (q>1) begin
       qkmem_add = qkmem_add + 1;
    end

    #0.5 clk = 1'b1;  
  end

  #0.5 clk = 1'b0;  
  kmem_rd = 0; qkmem_add = 0;
  #0.5 clk = 1'b1;  

  #0.5 clk = 1'b0;  
  load = 0; 
  #0.5 clk = 1'b1;  

///////////////////////////////////////////

 for (q=0; q<10; q=q+1) begin
    #0.5 clk = 1'b0;   
    #0.5 clk = 1'b1;   
 end





///// execution  /////
$display("##### execute #####");

  for (q=0; q<total_cycle; q=q+1) begin
    #0.5 clk = 1'b0;  
    execute = 1; 
    qmem_rd = 1;

    if (q>0) begin
       qkmem_add = qkmem_add + 1;
    end

    #0.5 clk = 1'b1;  
  end

  #0.5 clk = 1'b0;  
  qmem_rd = 0; qkmem_add = 0; execute = 0;
  #0.5 clk = 1'b1;  


///////////////////////////////////////////

 for (q=0; q<10; q=q+1) begin
    #0.5 clk = 1'b0;   
    #0.5 clk = 1'b1;   
 end




////////////// output fifo rd and write to SFP mem ///////////////////

$display("##### move ofifo to SFP #####");

  for (q=0; q<total_cycle; q=q+1) begin
    #0.5 clk = 1'b0;  
    ofifo_rd = 1; 
    acc = 1;
    #0.5 clk = 1'b1;  
  end

  #0.5 clk = 1'b0;  
  acc = 0; ofifo_rd = 0;
  #0.5 clk = 1'b1;  

  for (q=0; q<total_cycle; q=q+1) begin
	  #0.5 clk = 1'b0;  
	  #0.5 clk = 1'b1;  
  end

///////////////////////////////////////////

////////////// SFP NORM and write to PMEM ///////////////////

$display("##### SFP NORM CALC and write to PMEM #####");

  for (q=0; q<total_cycle+1; q=q+1) begin  
    #1 clk = 1'b0;
    
    div = 1;

   if(q>0) begin
	   pmem_wr = 1;
   end
   
   if(q>1) begin
	   pmem_add = pmem_add + 1;
   end

    if(q>8) begin
	    div = 0;
    end

    #0.5 clk = 1'b1;

  end

  #0.5 clk = 1'b0;  
  div = 0; pmem_wr = 0; pmem_add = 0;
  #0.5 clk = 1'b1;  


///////////////////////////////////////////





  #10 $finish;


end

endmodule




