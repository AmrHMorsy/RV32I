/*******************************************************************
*
* Module: ALU_Control
* Project: RISC-V Implementation
* Author:
          Amr Morsy - amrhassan18@aucegypt.edu
          Mohi Eldin El Ulabi - mhulabi@aucegypt.edu
* Description: This is the immediate generator module. It takes as input
                the instruction and produces, according to the opcode,
                the corresponding immediate bits concatenated together.
*
**********************************************************************/




`timescale 1ns / 1ps
`include "defines.v"


module ALU_Control(
    input [1:0] AluOp,
    input [2:0] Fn3,
    input Fn7,
    input LastBit,
    output reg [3:0] AluSel
);
 
wire Updated_Fn7 ;
wire [5:0] concat ;

assign Updated_Fn7 = (LastBit)?0:Fn7 ;
assign concat = {AluOp, Fn3, Updated_Fn7};
  
  
always @(*) 
  begin
	casex(concat)
        6'b00xxxx :
            AluSel = `ALU_ADD ;
        6'b01xxxx :
            AluSel = `ALU_SUB ;
        6'b100000:
            AluSel = `ALU_ADD ;
        6'b100001:
            AluSel = `ALU_SUB ;
        6'b101110:
            AluSel = `ALU_AND ;
        6'b101100:
            AluSel = `ALU_OR ;
        6'b100010:
            AluSel = `ALU_SLL ;
        6'b100100:
            AluSel = `ALU_SLT ;
        6'b100110:
            AluSel = `ALU_SLTU ;
        6'b101000:
            AluSel = `ALU_XOR ;
        6'b101010:
            AluSel = `ALU_SRL ;
        6'b101011:
            AluSel = `ALU_SRA ;
        default :
            AluSel = `ALU_PASS ;
    endcase
  end
   
endmodule
