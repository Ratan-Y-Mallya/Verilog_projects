module _1011110_generator( input  [3:0] in, input clk ,reset,output reg out   );

 reg [3:0] shift_reg;

always @(posedge clk or reset)
begin
if(reset) begin
 shift_reg <=in;
 out=0;
 end
 
else  begin
shift_reg <= {~(shift_reg[0]&shift_reg[1]&shift_reg[3]),shift_reg[3:1]};
out <= shift_reg[3];
end
end
endmodule
