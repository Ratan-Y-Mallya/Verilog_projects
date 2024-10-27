`timescale 1ns / 1ps


module seq_1011_tb();

reg clk,in,reset;
wire out;

seq_1011 dut (clk,reset,in,out);

initial begin
    clk = 1'b0;
    reset = 1'b1;#15;
    reset = 1'b0;
end

always begin
     clk= #5 ~clk;
end

initial begin
    #12 in=1; #10 in=0 ; #10 in=1 ;#10 in=1 ;#10 in=0 ;#10 in=1 ;#10 in=1 ;
    #10;
    $finish;
    
end


endmodule
