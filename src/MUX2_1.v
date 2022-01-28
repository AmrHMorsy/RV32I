/*******************************************************************
*
* Module: MUX2
* Project: RISC-V Implementation
* Author: Amr Morsy amrhassan18@aucegypt.edu
          Mohi Eldin El Ulabi mhulabi@aucegypt.edu
* Description: This is a 2x1 MUX, but the input is 1-bit wires. It is used in the register.v
*
* IMPORTANT Change history: 28/10/21 – I wrote the code
*
**********************************************************************/

`timescale 1ns / 1ps
`include "defines.v"


module MUX2_1(
    input A,
    input B,
    input S,
    output wire C
);

assign C = (B&&S) || (A&&~S) ;

endmodule
