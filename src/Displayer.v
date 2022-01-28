/*******************************************************************
*
* Module: Displayer
* Project: RISC-V Implementation
* Author: Amr Morsy amrhassan18@aucegypt.edu
          Mohi Eldin El Ulabi mhulabi@aucegypt.edu
* Description: This module is responsible for setting up LEDSel and SSDSel, which will be used eventually to display on the FPGA
*
* IMPORTANT Change history: 28/10/21 – I wrote the code
*
**********************************************************************/


`timescale 1ns / 1ps
`include "defines.v"

module Displayer(
	input [1:0] LEDSel , 
	input [3:0] SSDSel , 
	input [15:0] ConcatSignals ,
	input [31:0] Inst ,
	input [31:0] Address ,
	input [31:0] AddressPlus4 ,
	input [31:0] AddressPlusOffset ,
	input [31:0] NewAddress ,
	input [31:0] ReadData1 ,
	input [31:0] ReadData2 ,
	input [31:0] WriteData ,
	input [31:0] Imm  ,
	input [31:0] ShiftOut ,
	input [31:0] AluOut ,
	input [31:0] ALUIn2 ,
	input [31:0] ReadDataMem ,
	output reg [15:0] LEDOut , 
	output reg [12:0] SSDOut 
);

always @(*)
  begin
	case (LEDSel)
		2'b00:
                	LEDOut <= Inst[15:0];
            	2'b01:
                	LEDOut <= Inst[31:16];
            	2'b10:
                  begin
                    	LEDOut[0] <= ConcatSignals[0] ; 
                    	LEDOut[1] <= ConcatSignals[1] ; 
                    	LEDOut[2] <= ConcatSignals[2] ; 
                    	LEDOut[3] <= ConcatSignals[3] ; 
                    	LEDOut[4] <= ConcatSignals[4] ; 
                    	LEDOut[5] <= ConcatSignals[5] ; 
                    	LEDOut[7:6] <= ConcatSignals[7:6] ; 
                    	LEDOut[11:8] <= ConcatSignals[11:8] ; 
                    	LEDOut[12] <= ConcatSignals[12] ;
                    	LEDOut[13] <= ConcatSignals[13] ;
		    	LEDOut[14] <= ConcatSignals[14] ;
		    	LEDOut[15] <= sConcatSignals[15] ;
                  end
            	default:
                	LED_out <= 0;
        endcase 

     	case (SSDSel)
            	4'b0000:
                	SSD_Output <= Address[12:0] ; 
            	4'b0001: 
                	SSD_Output <= AddressPlus4[12:0] ;
            	4'b0010:
                	SSD_Output <= AddressPlusOffset[12:0] ; 
             	4'b0011:
                	SSD_Output <= NewAddress[12:0] ; 
             	4'b0100:
                	SSD_Output <= ReadData1[12:0] ; 
             	4'b0101:
                	SSD_Output <= ReadData2[12:0] ; 
             	4'b0110:
                	SSD_Output <= WriteData[12:0] ; 
             	4'b0111:
                	SSD_Output <= ImmOut[12:0] ; 
             	4'b1000:
                	SSD_Output <= ShiftOut[12:0] ; 
             	4'b1001:
                	SSD_Output <= ALUIn2[12:0] ; 
             	4'b1010:
                	SSD_Output <= AluOut[12:0] ; 
             	4'b1011:
                	SSD_Output <= ReadDataMem[12:0] ; 
            	default:
                	SSD_Output <= 0 ; 
        endcase 
  end

endmodule
