/*******************************************************************
*
* Module: ImmGen
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


module ImmGen (
    input  wire [31:0]  Inst,
    output reg  [31:0]  Imm
);


always @(*) begin
	case (`OPCODE)
		`OPCODE_Arith_I   :     Imm = { {21{Inst[31]}}, Inst[30:25], Inst[24:21], Inst[20] };
		`OPCODE_Store     :     Imm = { {21{Inst[31]}}, Inst[30:25], Inst[11:8], Inst[7] };
		`OPCODE_LUI       :     Imm = { Inst[31], Inst[30:20], Inst[19:12], 12'b0 };
		`OPCODE_AUIPC     :     Imm = { Inst[31], Inst[30:20], Inst[19:12], 12'b0 };
		`OPCODE_JAL       : 	Imm = { {12{Inst[31]}}, Inst[19:12], Inst[20], Inst[30:25], Inst[24:21]};
		`OPCODE_JALR      : 	Imm = { {21{Inst[31]}}, Inst[30:25], Inst[24:21], Inst[20] };
		`OPCODE_Branch    : 	Imm = { {20{Inst[31]}}, Inst[7], Inst[30:25], Inst[11:8]};
		default           : 	Imm = { {21{Inst[31]}}, Inst[30:25], Inst[24:21], Inst[20] };
	endcase 
end

endmodule
