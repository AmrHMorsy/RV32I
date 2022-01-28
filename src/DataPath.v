/*
*****************************************************************************************
* Module: DataPath
* Project: RISC-V Implementation
* Author:
*         Amr Morsy - amrhassan18@aucegypt.edu
          Mohi Eldin El Ulabi - mhulabi@aucegypt.edu
          
* Description: This is the datapath module. This is the main module in our
*               RISC-V pipelined design.
*
****************************************************************************************
*/



`timescale 1ns / 1ps
`include "defines.v"
`include "Register.v"
`include "RegFile.v"
`include "Control_Unit.v"
`include "ALU_Control.v"
`include "ImmGen.v"
`include "MUX2_32.v"
`include "ALU.v"
`include "MUX9.v"
`include "Memory.v"
`include "MUX3.v"
`include "Forwarding_Unit.v"
`include "Hazard_Detection_Unit.v"
`include "MUX4.v"



module DataPath #(parameter N = 32)(
	input clk, 
	input rst,
    output wire [N-1:0] WriteData ,
    output wire [N-1:0] Address ,
    output wire EX_MEM_RegWrite,
    output wire [4:0] MEM_WB_Rd ,
    output reg SlowClk,
    output wire [N-1:0] Updated_Inst,
    output wire [N-1:0] MemOut,
    output wire Stall
);


wire Branch ;
wire MemRead ;
wire MemToReg ;
wire MemWrite ;
wire AluSrc ;
wire RegWrite ;
wire AUIPC ;
wire JAL ;
wire JALR ;
wire ZeroFlag ;
wire CarryFlag ;
wire OverflowFlag ;
wire SignFlag ;
wire BranchFlag ;
wire BLTFlag ;
wire BGEFlag ;
wire [N-1:0] Shmount ;
wire [1:0] AluOp ;
wire [3:0] AluSel ;
wire [N-1:0] NewAddress ;
wire [N-1:0] Inst ;
wire [N-1:0] AluOut ;
wire [N-1:0] AluIn1 ;
wire [N-1:0] AluIn2 ;
wire [N-1:0] Imm  ;
wire [N-1:0] ShiftOut ;
wire [N-1:0] AddressPlus4 ;
wire [N-1:0] AddressPlusOffset ;
wire [N-1:0] ReadDataMem ;
wire [N-1:0] ReadData1 ;
wire [N-1:0] ReadData2 ;
wire Halt ;
wire [N-1:0] IF_ID_Address ;
wire [N-1:0] IF_ID_Inst ;
wire [N-1:0] IF_ID_AddressPlus4 ;
wire [4:0] IF_ID_Rs1 ;
wire [4:0] IF_ID_Rs2 ;
wire ID_EX_InstBit5 ;
wire [2:0] ID_EX_Func3 ;
wire ID_EX_Func7 ;
wire ID_EX_RegWrite ;
wire ID_EX_MemToReg ;
wire ID_EX_Branch ;
wire ID_EX_MemRead ;
wire ID_EX_MemWrite ;
wire [1:0] ID_EX_AluOp ;
wire ID_EX_AluSrc ;
wire ID_EX_AUIPC ;
wire ID_EX_JAL ;
wire ID_EX_JALR ;
wire [4:0] ID_EX_Rd ;
wire [4:0] ID_EX_Rs2 ;
wire [4:0] ID_EX_Rs1 ;
wire ID_EX_LastBit ;
wire [N-1:0] ID_EX_Address ;
wire [N-1:0] ID_EX_AddressPlus4 ;
wire [N-1:0] ID_EX_ReadData1 ;
wire [N-1:0] ID_EX_ReadData2 ;
wire [N-1:0] ID_EX_Imm ;
wire EX_MEM_MemToReg ;
wire EX_MEM_Branch ;
wire EX_MEM_MemRead ;
wire EX_MEM_MemWrite ;
wire EX_MEM_JAL ;
wire EX_MEM_JALR ;
wire [2:0] EX_MEM_Func3 ;
wire [N-1:0] EX_MEM_AddressPlus4 ;
wire [N-1:0] EX_MEM_AddressPlusOffset ;
wire EX_MEM_BranchFlag ;
wire [N-1:0] EX_MEM_AluOut ;
wire [N-1:0] EX_MEM_ReadData2 ;
wire [4:0] EX_MEM_Rd ;
wire MEM_WB_RegWrite ;
wire MEM_WB_MemToReg ;
wire MEM_WB_JAL ;
wire [N-1:0] MEM_WB_AddressPlus4 ;
wire [N-1:0] MEM_WB_ReadDataMem ;
wire [N-1:0] MEM_WB_AluOut ;
wire [1:0] ForwardA, ForwardB ;
wire [N-1:0] Forwarded_ReadData2, Forwarded_ReadData1 ;
wire [10:0] Control_Signals ;
wire [6:0] Updated_Control_Signals ;
wire PcSrc ;
wire [N-1:0] MemAddressIn ;
wire Updated_rst ;
wire PC_Load ;



initial
    begin
        SlowClk = 1 ;
    end
    
always @(*)
    begin
        if( clk )
          begin
            if( SlowClk )
                SlowClk = 0 ;
            else
                SlowClk = 1 ;
          end
    end

assign AddressPlus4 = Address + 4 ;
assign IF_ID_Rs1 = IF_ID_Inst[19:15] ;
assign IF_ID_Rs2 = IF_ID_Inst[24:20] ;
assign PcSrc = ((EX_MEM_Branch && EX_MEM_BranchFlag)||EX_MEM_JAL) ;
assign MemAddressIn = (SlowClk)?(Address):(EX_MEM_AluOut>>2) ;
assign Updated_rst = (Halt||rst)?1:0 ;
assign PC_Load = (Halt)?~Halt:((~Halt)&&(~Stall)) ;
assign Control_Signals = (Stall||PcSrc)?(10'b0):({RegWrite, MemToReg, Branch, MemRead, MemWrite, AluOp, AluSrc, AUIPC, JAL, JALR}) ;
assign Updated_Control_Signals = (PcSrc)?0:({ID_EX_RegWrite, ID_EX_MemToReg, ID_EX_Branch, ID_EX_MemRead, ID_EX_MemWrite, ID_EX_JAL, ID_EX_JALR}) ;
assign BLTFlag = (SignFlag!= OverflowFlag) ;
assign BGEFlag = (SignFlag== OverflowFlag) ;
assign AddressPlusOffset = ID_EX_Address + ShiftOut ;


Register PC( .clk(SlowClk) , .rst(Updated_rst), .Load(PC_Load), .D(NewAddress) , .Q(Address) ) ;

Register #(96) IF_ID ( .clk(clk), .Load(~Stall), .rst(rst), .D({Address,Updated_Inst,AddressPlus4}), .Q({IF_ID_Address,IF_ID_Inst,IF_ID_AddressPlus4}) ) ;

Register #(192) ID_EX (
    .clk(clk),
    .Load(1'b1),
    .rst(rst),
    .D( {Control_Signals, IF_ID_Address, IF_ID_AddressPlus4, IF_ID_Inst[5], ReadData1 , ReadData2, Imm, IF_ID_Inst[14:12], IF_ID_Inst[30], IF_ID_Inst[31], IF_ID_Inst[19:15], IF_ID_Inst[24:20], IF_ID_Inst[11:7] } ),
    .Q( {ID_EX_RegWrite, ID_EX_MemToReg, ID_EX_Branch, ID_EX_MemRead, ID_EX_MemWrite, ID_EX_AluOp, ID_EX_AluSrc, ID_EX_AUIPC, ID_EX_JAL, ID_EX_JALR, ID_EX_Address, ID_EX_AddressPlus4, ID_EX_InstBit5, ID_EX_ReadData1,ID_EX_ReadData2, ID_EX_Imm, ID_EX_Func3, ID_EX_Func7, ID_EX_LastBit, ID_EX_Rs1, ID_EX_Rs2, ID_EX_Rd} )
);

Register #(144) EX_MEM (
    .clk(clk),
    .Load(1'b1),
    .rst(rst),
    .D( {Updated_Control_Signals, ID_EX_Func3, ID_EX_AddressPlus4, AddressPlusOffset, BranchFlag, AluOut, Forwarded_ReadData2, ID_EX_Rd} ),
    .Q( {EX_MEM_RegWrite, EX_MEM_MemToReg, EX_MEM_Branch, EX_MEM_MemRead, EX_MEM_MemWrite, EX_MEM_JAL, EX_MEM_JALR, EX_MEM_Func3, EX_MEM_AddressPlus4, EX_MEM_AddressPlusOffset, EX_MEM_BranchFlag, EX_MEM_AluOut, EX_MEM_ReadData2, EX_MEM_Rd} )
);

Register #(104) MEM_WB (
    .clk(clk),
    .Load(1'b1),
    .rst(rst),
    .D( {EX_MEM_RegWrite, EX_MEM_MemToReg, EX_MEM_JAL, EX_MEM_AddressPlus4, MemOut, EX_MEM_AluOut, EX_MEM_Rd} ),
    .Q( {MEM_WB_RegWrite, MEM_WB_MemToReg, MEM_WB_JAL, MEM_WB_AddressPlus4, MEM_WB_ReadDataMem, MEM_WB_AluOut,MEM_WB_Rd})
);



ImmGen IG ( .Inst(IF_ID_Inst), .Imm(Imm) ) ;

Control_Unit CU ( .Inst(IF_ID_Inst[6:2]), .AluOp(AluOp), .Branch(Branch), .MemRead(MemRead), .MemToReg(MemToReg), .MemWrite(MemWrite), .AluSrc(AluSrc), .RegWrite(RegWrite) , .AUIPC(AUIPC) , .JAL(JAL), .JALR(JALR), .Halt(Halt) ) ;

Hazard_Detection_Unit HDU( .IF_ID_Rs1(IF_ID_Inst[19:15]), .IF_ID_Rs2(IF_ID_Inst[24:20]), .ID_EX_Rd(ID_EX_Rd), .ID_EX_MemRead(ID_EX_MemRead), .Stall(Stall) ) ;

Memory MJ( .clk(clk), .MemRead(EX_MEM_MemRead), .MemWrite(EX_MEM_MemWrite), .SlowClk(SlowClk), .Address(MemAddressIn), .DataIn(EX_MEM_ReadData2), .F3(EX_MEM_Func3), .Out(MemOut) );

ALU_Control AC ( .AluOp(ID_EX_AluOp) , .Fn3(ID_EX_Func3) , .Fn7(ID_EX_Func7) , .LastBit(ID_EX_LastBit), .AluSel(AluSel) ) ;

Shifter SF ( .A(ID_EX_Imm) , .Shmout(5'b00001), .Type(2'b01), .Result(ShiftOut) ) ;

ALU AA( .A(AluIn1), .B(AluIn2), .Shmount(Shmount[4:0]), .AluSel(AluSel), .Result(AluOut),.CarryFlag(CarryFlag), .ZeroFlag(ZeroFlag), .OverflowFlag(OverflowFlag), .SignFlag(SignFlag) ) ;

RegFile RF( .clk(clk) , .rst(rst), .ReadReg1(IF_ID_Inst[19:15]), .ReadReg2(IF_ID_Inst[24:20]), .WriteReg(MEM_WB_Rd), .WriteData(WriteData), .RegWrite(MEM_WB_RegWrite), .ReadData1(ReadData1), .ReadData2(ReadData2) ) ;

Forwarding_Unit FU( .ID_EX_Rs1(ID_EX_Rs1), .ID_EX_Rs2(ID_EX_Rs2), .EX_MEM_Rd(EX_MEM_Rd), .MEM_WB_Rd(MEM_WB_Rd), .EX_MEM_RegWrite(EX_MEM_RegWrite), .MEM_WB_RegWrite(MEM_WB_RegWrite), .ForwardA(ForwardA), .ForwardB(ForwardB) ) ;



MUX2_32 M12( .A(MemOut) , .B(32'b0000000_00000_00000_000_00000_0110011) , .S(PcSrc||Halt) , .Result(Updated_Inst) ) ;
MUX2_32 M5( .A(ID_EX_Imm) , .B(AluIn2) , .S(ID_EX_InstBit5) , .Result(Shmount) ) ;
MUX3 M7( .A(MEM_WB_AluOut) , .B(MEM_WB_ReadDataMem) , .C(MEM_WB_AddressPlus4) , .S({MEM_WB_MemToReg,MEM_WB_JAL}), .Result(WriteData) ) ;
MUX4 M9( .A(ID_EX_ReadData1), .B(WriteData), .C(EX_MEM_AluOut), .S(ForwardA), .Result(Forwarded_ReadData1));
MUX4 M10(.A(ID_EX_ReadData2), .B(WriteData), .C(EX_MEM_AluOut), .S(ForwardB), .Result(Forwarded_ReadData2));
MUX2_32 M6( .A(Forwarded_ReadData1) , .B(ID_EX_Address) , .S(ID_EX_AUIPC) , .Result(AluIn1) ) ;
MUX2_32 M1( .A(Forwarded_ReadData2) , .B(ID_EX_Imm) , .S(ID_EX_AluSrc) , .Result(AluIn2) ) ;
MUX9 M4( .I1(ZeroFlag) , .I2(~ZeroFlag) , .I3(BLTFlag), .I4(BGEFlag), .I5(~CarryFlag), .I6(CarryFlag), .S(ID_EX_Func3), .Result(BranchFlag) ) ;
MUX3 M2( .A(AddressPlus4), .B(EX_MEM_AddressPlusOffset), .C(EX_MEM_AluOut) ,.S({((EX_MEM_Branch && EX_MEM_BranchFlag)||EX_MEM_JAL),EX_MEM_JALR}), .Result(NewAddress) ) ;


endmodule
