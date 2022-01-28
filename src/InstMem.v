/*******************************************************************
*
* Module: InstMem
* Project: RISC-V Implementation
* Author: Amr Morsy amrhassan18@aucegypt.edu
          Mohi Eldin El Ulabi mhulabi@aucegypt.edu
* Description: This is the instruction memory module. It contains all the instructions to be executed.
*
* IMPORTANT Change history: 28/10/21 – I wrote the code
*
**********************************************************************/

`timescale 1ns / 1ps
`include "defines.v"


module InstMem (
    input [7:0] Address,
    output wire [31:0] Inst
);
 
reg [7:0] Mem [4095:0];

initial
  begin
    $readmemh("Test2.hex",Mem) ;
  end

assign Inst = {Mem[Address+3], Mem[Address+2], Mem[Address+1], Mem[Address]} ;
     
endmodule
