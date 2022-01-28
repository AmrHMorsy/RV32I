`timescale 1ns / 1ps
`include "defines.v"




module MUX3 #(parameter N = 32) (
    input [N-1:0] A,
    input [N-1:0] B,
    input [N-1:0] C,
    input [1:0] S,
    output [N-1:0] Result
) ;

wire [N-1:0] Intermediate ;

assign Intermediate = (S[1])?B:A ;
assign Result = (S[0])?C:Intermediate ;
  
  
endmodule
