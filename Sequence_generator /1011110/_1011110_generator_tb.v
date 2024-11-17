`timescale 1ns / 1ps

module _1011110_tb(  );

reg [3:0] in;
reg clk,reset;
wire out ;

_1011110_generator dut (in,clk,reset,out);

initial begin 
clk =1'b0;
reset =1;

forever #5 clk =~clk;
end

initial begin 
reset =1;in = 4'b1011;
#10 reset =1'b0;

#100;
$finish;
end

endmodule

