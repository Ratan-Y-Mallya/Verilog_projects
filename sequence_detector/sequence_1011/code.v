`timescale 1ns / 1ps



module seq_1011(input clk,reset,in,output reg out);

parameter A = 2'b00,B=2'b01,C=2'b10,D=2'b11;
 reg [1:0] next_state,cur_state;
always @(posedge clk or posedge reset) begin

if (reset)
    cur_state<=A;
else
    cur_state<=next_state;

end

always @(cur_state , in) begin

    case (cur_state)
        A : begin
                out = in ? 0 : 0;
                next_state = in ? B: A;
        end
        B : begin
                out = in ? 0 : 0;
                next_state = in ? B: C;
        end  
        C : begin
                out = in ? 0 : 0;
                next_state = in ? D: A;
        end  
        D : begin
                out = in ? 1 : 0;
                next_state = in ? B: C;
        end  
        
        default: begin
                out = in ? 0 : 0;
                next_state = A;
        end 
    endcase
end

endmodule
