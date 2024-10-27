`timescale 1ns / 1ps


module seq_1101(
    input clk,
    input  x,
    input reset,
    output reg z
    );

parameter A =2'b00,B=2'b01,C=2'b10,D=2'b11 ;

reg [1:0] next_state,present_state ;

always @(posedge clk or posedge reset) begin

    if (reset) 
        present_state<=A;
    else    present_state<=next_state;
       
    
end

always @(present_state or x) begin
z=0;

    case (present_state)
       A : begin
            z=x? 0:0;
           next_state = x ? B : A;
       end
       B : begin
            z=x? 0:0;
           next_state = x ? C : A;
       end
       C : begin
            z=x? 0:0;
           next_state = x ? C : D;
       end
       D : begin
            z=x? 1:0;
           next_state = x ? B : A;
       end
       

        default: begin
            
           next_state = A;
       end
       
    endcase
    
end


endmodule

