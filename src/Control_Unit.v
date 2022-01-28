/*******************************************************************
*
* Module: Control Unit
* Project: RISC-V Implementation
* Author: Amr Morsy amrhassan18@aucegypt.edu
          Mohi Eldin El Ulabi mhulabi@aucegypt.edu
* Description: This module produces all the control signals needed. It takes as input the opcode of the instruction
*
* IMPORTANT Change history: 28/10/21 – I wrote the code
                            02/11/21 - I added the 2 control signals AUIPC, JAL and JALR 
*
**********************************************************************/






`timescale 1ns / 1ps
`include "defines.v"


module Control_Unit (
	input [4:0] Inst,
	output reg [1:0] AluOp,
	output reg Branch,
    output reg MemRead,
    output reg MemToReg,
    output reg MemWrite,
    output reg AluSrc,
    output reg RegWrite,
    output reg AUIPC,
    output reg JAL,
    output reg JALR,
    output reg Halt
);  
        
always @(*) 
begin  
  case(Inst)  
	`OPCODE_Arith_R:
        begin
            Branch = 0;
            MemRead = 0;
            MemToReg = 0;
            AluOp = 2'b10;
            MemWrite = 0;
            AluSrc = 0;
            RegWrite = 1;
            AUIPC = 0 ;
            JAL = 0 ;
            JALR = 0 ;
            Halt = 0 ;
        end
              
 	`OPCODE_Load:
        begin
            Branch = 0;
            MemRead = 1;
            MemToReg = 1;
            AluOp = 2'b00;
            MemWrite = 0;
            AluSrc = 1;
            RegWrite = 1;
            AUIPC = 0 ;
            JAL = 0 ;
            JALR = 0 ;
            Halt = 0 ;
        end
                      
	`OPCODE_Store:
        begin
            Branch = 0;
            MemRead = 0;
            MemToReg = 0;
            AluOp = 2'b00;
            MemWrite = 1;
            AluSrc = 1;
            RegWrite = 0;
            AUIPC = 0 ;
            JAL = 0 ;
            JALR = 0 ;
            Halt = 0 ;
        end
                                
	`OPCODE_Branch:
        begin
            Branch = 1;
            MemRead = 0;
            MemToReg = 0;
            AluOp = 2'b01;
            MemWrite = 0;
            AluSrc = 0;
            RegWrite = 0;
            AUIPC = 0 ;
            JAL = 0 ;
            JALR = 0 ;
            Halt = 0 ;
        end
           
	`OPCODE_Arith_I:
        begin
            Branch = 0;
            MemRead = 0;
            MemToReg = 0;
            AluOp = 2'b10;
            MemWrite = 0;
            AluSrc = 1;
            RegWrite = 1;
            AUIPC = 0 ;
            JAL = 0 ;
            JALR = 0 ;
            Halt = 0 ;
        end
        
    `OPCODE_LUI:
        begin
            Branch = 0 ;
            MemRead = 0 ;
            MemToReg = 0 ;
            AluOp = 2'b11 ;
            MemWrite = 0 ;
            AluSrc = 1 ;
            RegWrite = 1;
            AUIPC = 0 ;
            JAL = 0 ;
            JALR = 0 ;
            Halt = 0 ;
        end
        
    `OPCODE_AUIPC:
        begin
            Branch = 0 ;
            MemRead = 0 ;
            MemToReg = 0 ;
            AluOp = 2'b00 ;
            MemWrite = 0 ;
            AluSrc = 1 ;
            RegWrite = 1 ;
            AUIPC = 1 ;
            JAL = 0 ;
            JALR = 0 ;
            Halt = 0 ;
        end
    
    `OPCODE_JALR:
        begin
            Branch = 0 ;
            MemRead = 0 ;
            MemToReg = 0 ;
            AluOp = 2'b00 ;
            MemWrite = 0;
            AluSrc = 1 ;
            RegWrite = 1 ;
            AUIPC = 0 ;
            JAL = 1;
            JALR = 1 ;
            Halt = 0 ;
        end
        
     `OPCODE_JAL:
        begin
            Branch = 0 ;
            MemRead = 0 ;
            MemToReg = 0 ;
            AluOp = 2'b11 ;
            MemWrite = 0;
            AluSrc = 1 ;
            RegWrite = 1 ;
            AUIPC = 0 ;
            JAL = 1;
            JALR = 0 ;
            Halt = 0 ;
        end
        
    `OPCODE_SYSTEM:
        begin
            Branch = 0 ;
            MemRead = 0 ;
            MemToReg = 0 ;
            AluOp = 2'b00 ;
            MemWrite = 0;
            AluSrc = 0 ;
            RegWrite = 0 ;
            AUIPC = 0 ;
            JAL = 0;
            JALR = 0 ;
            Halt = 1 ;
        end
    `OPCODE_FENCE:
        begin
            Branch = 0 ;
            MemRead = 0 ;
            MemToReg = 0 ;
            AluOp = 2'b00 ;
            MemWrite = 0;
            AluSrc = 0 ;
            RegWrite = 0 ;
            AUIPC = 0 ;
            JAL = 0;
            JALR = 0 ;
            Halt = 1 ;
        end
    default: 
        begin
            Branch = 0;
            MemRead = 0;
            MemToReg = 0;
            AluOp = 2'b00;
            MemWrite = 0;
            AluSrc = 0;
            RegWrite = 0;
            JAL = 0 ;
            JALR = 0 ;
            Halt = 0 ; 
        end
  endcase
end

endmodule
