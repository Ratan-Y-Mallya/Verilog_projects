`timescale 1ns / 1ps

module vending_m( input clk,
                  input rst,
                  input [1:0] in, // 00 = 0rs   01 = 5rs  10=10rs
                  output reg out,
                  output reg [1:0] change

    );
    
 parameter s0=2'b00,s1=2'b01,s2=2'b10 ;
 
 reg [1:0] c_state,n_state;//current_state and next_state
 
 always @ (posedge clk)
 begin
      if(rst==1)
            begin
              c_state<=0;
              n_state<=0;
              change <=0;
            end
     else
       c_state<=n_state;
       
       
    case(c_state)
     
      s0:  //State 0 :  0rs   
          if(in == 0)
           begin
             n_state=s0;
             out=0;
             change=0;  
           end
          else
          if(in == 2'b01)
           begin
             n_state=s1;
             out=0;
             change=0;  
           end
          else
          if(in == 2'b10)
           begin
             n_state=s2;
             out=0;
             change=0;  
           end
          
      s1:  //State 1 :  5rs    
            if(in == 0)
           begin
             n_state=s0;
             out=0;
             change=2'b01;  
           end
          else
          if(in == 2'b01)
           begin
             n_state=s2;
             out=0;
             change=0;  
           end
          else
          if(in == 2'b10)
           begin
             n_state=s2;
             out=1;
             change=0;  
           end
         
      s2:     //State 2 :  10rs    
            if(in == 0)
           begin
             n_state=s0;
             out=0;
             change=2'b10;  
           end
          else
          if(in == 2'b01)
           begin
             n_state=s0;
             out=1;
             change=0;  
           end
          else
          if(in == 2'b10)
           begin
             n_state=s0;
             out=1;
             change=2'b01;  
           end
        
    endcase
 end   
endmodule

