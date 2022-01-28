/*******************************************************************
*
* Module: Register
* Project: RISC-V Implementation
* Author: Amr Morsy amrhassan18@aucegypt.edu
          Mohi Eldin El Ulabi mhulabi@aucegypt.edu
* Description: This is Register file. It is used by PC as well as register file
*
* IMPORTANT Change history: 28/10/21 – I wrote the code
*
**********************************************************************/

`timescale 1ns / 1ps
`include "MUX2_1.v"
`include "DFlipFlop.v"


module Register #(parameter N = 32)(
	input clk,  
	input rst ,
  	input Load, 
  	input [N-1:0] D,
  	output [N-1:0] Q
);

wire [N-1:0] MUXOut ;
genvar i;

generate
  for ( i = 0; i < N; i = i+1 ) 
    begin
        MUX2_1 MM(.A(Q[i]), .B(D[i]), .S(Load) , .C(MUXOut[i]) );
        DFlipFlop DF( .clk(clk), .rst(rst), .D(MUXOut[i]), .Q(Q[i]) );
    end
endgenerate
        
endmodule
