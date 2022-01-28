/*
*****************************************************************************************
* Module: Hazard_Detection_Unit
* Project: RISC-V Implementation
* Author:
*         Amr Morsy - amrhassan18@aucegypt.edu
          Mohi Eldin El Ulabi - mhulabi@aucegypt.edu
          
* Description: This is the Hazard_Detection_Unit module. This module is responsible for load-use data hazard
*
****************************************************************************************
*/

`timescale 1ns / 1ps


module Hazard_Detection_Unit(
    input [4:0] IF_ID_Rs1,
    input [4:0] IF_ID_Rs2,
    input [4:0] ID_EX_Rd,
    input ID_EX_MemRead,
    output Stall
);
    
assign Stall = (((IF_ID_Rs1==ID_EX_Rd)||(IF_ID_Rs2==ID_EX_Rd)) && (ID_EX_MemRead) && (ID_EX_Rd!=0))?1:0 ;
 
endmodule
