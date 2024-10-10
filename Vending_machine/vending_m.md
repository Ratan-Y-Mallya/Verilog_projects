# Vending Machine Verilog Module

This Verilog module simulates a simple vending machine with the following functionality:

* ### Inputs:
    * `clk` : Clock signal.
    *  `rst`: Reset signal (active high).
    *  `in [1:0]`: Represents the currency inserted.
    * `00` = No money
    * `01` = 5 Rs
    * `10` = 10 Rs

* ### Outputs:
    * `out`:Vending machine output, which indicates if an item is dispensed(`out=1`).
    * `change [1:0]`: Represents the amount of change returned.
           * `00`= No change
           * `01` = 5 Rs change
           * `10` = 10 Rs change
* ### States:
   1. `s0`(2'b00): Initial state representing no money inserted.
   2. `s1`(2'b01): State representing 5 Rs inserted.
   3. `s3`(2'b10): State representing 10 Rs inserted.
 
  ### FSM Behavior:
  * The machine starts in `s0` (no money).
  * Based on the input value (`in`), the machine transitions between states and either dispenses an item or returns change.
 

## State Transitions:

1. ### State `s0`(No Money):
      * If 0 Rs (in = 00) is inserted, the machine stays in s0 and waits.
      * If 5 Rs (in = 01) is inserted, the machine transitions to s1 (5 Rs inserted).
      * If 10 Rs (in = 10) is inserted, the machine transitions to s2 (10 Rs inserted).
  
2.  ### State `s1`(5 Rs Inserted):
      * If 0 Rs (in = 00) is inserted, the machine resets to s0 and returns 5 Rs change.
      * If 5 Rs (in = 01) is inserted, the machine transitions to s2 (10 Rs inserted).
      * If 10 Rs (in = 10) is inserted, the machine dispenses an item (out = 1) and remains in s2.
  
3.  ### State `s2`(10 Rs Inserted):
      * If 0 Rs (in = 00) is inserted,the machine returns 10 Rs change and resets to s0.
      * If 5 Rs (in = 01) is inserted, the machine dispenses an item and resets to s0.
      * If 10 Rs (in = 10) is inserted, the machine dispenses an item and returns 5 Rs change, then resets to s0.




# State Diagram :
![photo_2024-10-10_19-14-16](https://github.com/user-attachments/assets/641ddf23-c00c-4174-8759-5086d3f39608)



# Verilog Code:
```
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

```

# Test Bench

```
`timescale 1ns / 1ps

module veng_m_test( );
reg clk,rst;
reg[1:0] in;
wire out;
wire [1:0] change;

vending_m  mach (  clk, rst, in, out,change);

always #5 clk = ~clk;

initial begin

$dumpfile("vending_machine.vcd");
$dumpvars(0,veng_m_test);
rst = 1;
clk = 0;

#6 rst = 0;
in = 1;
#11 in =1;
#16 in = 1;
#25 $finish;
end



endmodule


```


# Waveform: 
![Screenshot 2024-10-10 191826](https://github.com/user-attachments/assets/56964a1e-805f-4340-9a97-3b26e240c3d2)

## Key Features:
* State-based transitions ensure the correct operation based on the amount inserted.
* Outputs are generated based on the current state and input:
     * If sufficient money is inserted, an item is dispensed.
     * If extra money is inserted, the correct change is returned.
 
       
This design demonstrates a simple yet effective state machine implementation for a vending machine.
