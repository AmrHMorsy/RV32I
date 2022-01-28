/*
*****************************************************************************************
* Module: ALU
* Project: RISC-V Implementation
* Author:
*         Amr Morsy - amrhassan18@aucegypt.edu
          Mohi Eldin El Ulabi - mhulabi@aucegypt.edu
* Description: This is ALU module. It is reponsible for all the arithmetic calculations. It produces as output the ALU result and the flags                     zero_flag, carry_flag, overflow_flag and sign_flag
*
****************************************************************************************
*/




`timescale 1ns / 1ps
`include "defines.v"
`include "Shifter.v"


module ALU #(parameter N = 32)(
	input wire [N-1:0] A,
	input wire [N-1:0] B,
	input wire [4:0]  Shmount,
	input wire [3:0]  AluSel,
	output reg  [N-1:0] Result,
	output wire CarryFlag,
	output wire ZeroFlag,
	output wire OverflowFlag,
	output wire SignFlag
);


wire [N-1:0] Add, Sub, Negative_B ;
wire [N-1:0] ShiftOut;
    

assign Negative_B = (~B);
assign {CarryFlag, Add} = AluSel[0] ? (A + Negative_B + 1'b1) : (A + B) ;
assign ZeroFlag = (Add == 0) ;
assign SignFlag = Add[31] ;
assign OverflowFlag = (A[31] ^ (Negative_B[31]) ^ Add[31] ^ CarryFlag) ;
    

Shifter S( .A(A), .Shmout(Shmount), .Type(AluSel[1:0]), .Result(ShiftOut) );


always @ * 
  begin
	Result = 0;
        (* parallel_case *)
        case (AluSel)
        	4'b00_00 : 
                Result = Add ;
        	4'b00_01 : 
                Result = Add ;
            4'b00_11 :
                Result = B ;
            4'b01_00:
                Result = A | B ;
            4'b01_01:
                Result = A & B ;
            4'b01_11:
                Result = A ^ B ;
            4'b10_00:
                Result = ShiftOut ;
            4'b10_01:
                Result = ShiftOut ;
            4'b10_10:
                Result = ShiftOut ;
            4'b11_01:
                Result = {31'b0,(SignFlag != OverflowFlag)} ;
            4'b11_11:
                Result = {31'b0,(~CarryFlag)} ;
        endcase
  end

endmodule
