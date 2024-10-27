`timescale 1ns / 1ps



module seq_1101_tb( );
reg clk,x,reset;
wire z;

seq_1101 dut (clk,x,reset,z);

initial begin
    clk = 1'b0;
    reset = 1'b1;#15;
    reset = 1'b0;
end

always begin
     clk= #5 ~clk;
end

initial begin
    #12 x=1; #10 x=1 ; #10 x=0 ;#10 x=1 ;#10 x=1 ;#10 x=0 ;#10 x=1 ;
    #10;
    $finish;
    
end

endmodule
