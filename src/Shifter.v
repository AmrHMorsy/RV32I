/*******************************************************************
*
* Module: Shifter
* Project: RISC-V Implementation
* Author: Amr Morsy amrhassan18@aucegypt.edu
          Mohi Eldin El Ulabi mhulabi@aucegypt.edu
* Description: This module is responsible for shifting the input to the left or right by shmout 
*
*
**********************************************************************/



`timescale 1ns / 1ps
`include "defines.v"


module Shifter #(parameter N = 32)(
  input signed [N-1:0] A,
  input [4:0] Shmout,
  input [1:0] Type,  
  output reg [N-1:0] Result
); 


always @ * 
  begin
	case(Type)
		2'b00: // SRL
		  begin
			Result = A >> Shmout ;
		  end

		2'b01: // SLL
		  begin
			Result = A << Shmout ;
		  end

		2'b10: // SRA
		  begin
            Result = A >>> Shmout ;
		  end

	endcase
  end

endmodule
