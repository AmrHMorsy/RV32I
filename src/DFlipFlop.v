/*******************************************************************
*
* Module: DFlipFlopp
* Project: RISC-V Implementation
* Author: Amr Morsy amrhassan18@aucegypt.edu
          Mohi Eldin El Ulabi mhulabi@aucegypt.edu
* Description: This is the FlipFlop module. It is used in the register module
*
* IMPORTANT Change history: 28/10/21 – I wrote the code
*
**********************************************************************/

`timescale 1ns / 1ps


module DFlipFlop(
  input clk,
  input rst,
  input D, 
  output reg Q
);

always @ (posedge clk or posedge rst)
 if (rst) 
   begin
        Q <= 1'b0;
   end 
 else 
   begin
        Q <= D;
   end


endmodule 
