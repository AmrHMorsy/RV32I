/*******************************************************************
*
* Module: MUX9
* Project: RISC-V Implementation
* Author: Amr Morsy amrhassan18@aucegypt.edu
          Mohi Eldin El Ulabi mhulabi@aucegypt.edu
* Description: This module is responsible for producing the signal which is going to be anded with the branch control signal, which is going to pick the new address that is going to be stored in the PC
*
* IMPORTANT Change history: 28/10/21 – I wrote the code
*
**********************************************************************/

`timescale 1ns / 1ps
`include "defines.v"


module MUX9(
	input I1,
	input I2, 
	input I3,
	input I4,
	input I5,
	input I6,
	input [2:0] S,
	output reg Result 
);
    
always @(*)
  begin
	case(S)
		3'b000:
			Result <= I1 ;
		3'b001:
			Result <= I2 ;
		3'b100:
			Result <= I3 ;
		3'b101:
			Result <= I4 ; 
		3'b110:
			Result <= I5 ;
		3'b111:
			Result <= I6 ;
		default:
			Result <= 0 ; 
	endcase 
  end  
    
endmodule
