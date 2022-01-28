/*******************************************************************
*
* Module: MUX2_32
* Project: RISC-V Implementation
* Author: Amr Morsy amrhassan18@aucegypt.edu
          Mohi Eldin El Ulabi mhulabi@aucegypt.edu
* Description: This is the 2x1 MUX
*
* IMPORTANT Change history: 28/10/21 – I wrote the code
*
**********************************************************************/

`timescale 1ns / 1ps
`include "defines.v"


module MUX2_32(
	input [31:0] A, 
	input [31:0] B,
	input S, 
	output wire [31:0] Result 
);
    
assign Result = S ? B : A ;
    
endmodule
