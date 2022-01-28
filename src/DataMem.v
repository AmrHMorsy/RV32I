/*******************************************************************
*
* Module: DataMem
* Project: RISC-V Implementation
* Author: Amr Morsy amrhassan18@aucegypt.edu
          Mohi Eldin El Ulabi mhulabi@aucegypt.edu
* Description: This module produces all the control signals needed. It takes as input the opcode of the instruction
*
* IMPORTANT Change history: 28/10/21 – I wrote the code
                            02/11/21 - I added the case statement to choose between LB, LW, LH, LBU, LHU as well as SB, SW and SH
*
**********************************************************************/





`timescale 1ns / 1ps
`include "defines.v"


module DataMem(
	input clk, 
	input MemRead, 
	input MemWrite, 
	input [5:0] Address, 
	input [31:0] DataIn,
    input [2:0] F3,
	output reg [31:0] DataOut
);
 
reg [31:0] Mem [0:63];

always @(*)
  begin
    case(F3)
        3'b000: // LB
            begin
                if( MemRead == 1 )
                  begin
                    DataOut[7:0] <= Mem[Address][7:0] ;
                    DataOut[31:8] <= {24{Mem[Address][31]}} ;
                  end
                else
                  begin
                    DataOut <= 0 ;
                  end
            end

        3'b001: // LH
            begin
                if( MemRead == 1 )
                  begin
                    DataOut[15:0] <= Mem[Address][15:0] ;
                    DataOut[31:16] <= {16{Mem[Address][31]}} ;
                  end
                else
                  begin
                    DataOut <= 0 ;
                  end
            end

        3'b010: // LW
            begin
                if( MemRead == 1 )
                    DataOut <= Mem[Address] ;
                else
                    DataOut <= 0 ;
            end
            
        3'b100: // LBU
            begin
                if( MemRead == 1 )
                  begin
                    DataOut[7:0] <= Mem[Address][7:0] ;
                    DataOut[31:8] <= 24'b0 ;
                  end
                else
                  begin
                    DataOut <= 0 ;
                  end
            end
            
        3'b101: // LHU
            begin
                if( MemRead == 1 )
                  begin
                    DataOut[15:0] <= Mem[Address][15:0] ;
                    DataOut[31:16] <= 16'b0 ;
                  end
                else
                  begin
                    DataOut <= 0 ;
                  end
            end
    endcase
  end

always @(posedge clk)
  begin
    case(F3)
        3'b000: // SB
            begin
                if( MemWrite == 1 )
                  begin
                    Mem[Address][7:0] <= DataIn[7:0] ;
                    Mem[Address][31:8] <= 24'b0 ;
                  end
            end

        3'b001: // SH
            begin
                if( MemWrite == 1 )
                  begin
                    Mem[Address][15:0] <= DataIn[15:0] ;
                    Mem[Address][31:16] <= 16'b0 ;
                  end
            end

        3'b010: // SW
            begin
                if( MemWrite == 1 )
                    Mem[Address] <= DataIn ;
            end
    endcase
  end
 
endmodule
