/*******************************************************************
*
* Module: Decoder
* Project: RISC-V Implementation
* Author: Amr Morsy amrhassan18@aucegypt.edu
          Mohi Eldin El Ulabi mhulabi@aucegypt.edu
* Description: This is the decoder module 
*
* IMPORTANT Change history: 28/10/21 – I wrote the code
*
**********************************************************************/

`timescale 1ns / 1ps



module Decoder(
  input [4:0] A, 
  input en, 
  output reg [31:0] Load
);
    
always @(*)
  begin 
    if( en == 1 )
      Load <= 32'b0000000000000000000000000000001 << A ; 
    else 
      Load <= 32'b0000000000000000000000000000000 ;
  end
    
endmodule
