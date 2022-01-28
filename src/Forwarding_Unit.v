/*
*****************************************************************************************
* Module: Forwarding Unit
* Project: RISC-V Implementation
* Author:
*         Amr Morsy - amrhassan18@aucegypt.edu
          Mohi Eldin El Ulabi - mhulabi@aucegypt.edu
          
* Description: This is the forwarding unit module. This module is responsible for handling data hazards
*
****************************************************************************************
*/

`timescale 1ns / 1ps
`include "defines.v"


module Forwarding_Unit(
    input [4:0] ID_EX_Rs1,
    input [4:0] ID_EX_Rs2,
    input [4:0] EX_MEM_Rd,
    input [4:0] MEM_WB_Rd,
    input EX_MEM_RegWrite,
    input MEM_WB_RegWrite,
    output reg [1:0] ForwardA,
    output reg [1:0] ForwardB
);
   
always @(*)
    begin
        if ( EX_MEM_RegWrite && (EX_MEM_Rd != 0) && (EX_MEM_Rd == ID_EX_Rs1) )
            ForwardA = 2'b10;
        else if ( MEM_WB_RegWrite && (MEM_WB_Rd != 0) && (MEM_WB_Rd == ID_EX_Rs1))
            ForwardA = 2'b01;
        else
            ForwardA = 2'b00;
    end
         
always @(*)
    begin
        if ( EX_MEM_RegWrite && (EX_MEM_Rd != 0) && (EX_MEM_Rd == ID_EX_Rs2) )
            ForwardB = 2'b10;
        else if ( MEM_WB_RegWrite && (MEM_WB_Rd != 0) && (MEM_WB_Rd == ID_EX_Rs2) )
            ForwardB = 2'b01;
        else
            ForwardB = 2'b00;
         
    end
           
endmodule
