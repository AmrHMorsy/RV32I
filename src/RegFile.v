/*******************************************************************
*
* Module: RegFile
* Project: RISC-V Implementation
* Author: Amr Morsy amrhassan18@aucegypt.edu
          Mohi Eldin El Ulabi mhulabi@aucegypt.edu
* Description: This is the register file program
*
* IMPORTANT Change history: 28/10/21 – I wrote the code

*
**********************************************************************/

`timescale 1ns / 1ps
`include "Decoder.v"


module RegFile #(parameter N = 32)(
	input clk, 
	input rst,
	input [4:0] ReadReg1, 
  	input [4:0] ReadReg2,
  	input [4:0] WriteReg, 
  	input [31:0] WriteData, 
  	input RegWrite, 
  	output [N-1:0] ReadData1,
  	output [N-1:0] ReadData2
);

wire [31:0] Load ;
wire [31:0] Q [31:0]  ;

assign Q[0] = 0 ; 
Decoder Dr( .A(WriteReg), .en(RegWrite), .Load(Load) ) ; 
 
genvar i ;
generate 
  for( i = 1 ; i < 32 ; i=i+1 )
    begin 
      Register R(.clk(clk), .rst(rst), .Load(Load[i]), .D(WriteData) , .Q(Q[i]) ) ; 
    end
endgenerate
  

assign ReadData1 = ((ReadReg1==WriteReg) && (WriteReg!=0) && (RegWrite==1))?(WriteData):Q[ReadReg1] ;
assign ReadData2 = ((ReadReg2==WriteReg) && (WriteReg!=0) && (RegWrite==1))?(WriteData):Q[ReadReg2] ;


endmodule
