/*******************************************************************
*
* Module: tb
* Project: RISC-V Implementation
* Author: Amr Morsy amrhassan18@aucegypt.edu
          Mohi Eldin El Ulabi mhulabi@aucegypt.edu
* Description: This is the testbench module. It is used to simulate the program
*
* IMPORTANT Change history: 28/10/21 – I wrote the code
                            * This module has been updated regularly for the past 7 days to accomodate new test cases
*
**********************************************************************/

`timescale 1ns / 1ps
`include "DataPath.v"



module tb();

parameter N = 32 ;


reg clk ;
reg rst ;
wire [N-1:0] WriteData ;
wire [N-1:0] Address ;
wire RegWrite ;
wire [4:0] Rd ;
wire SlowClk ;
wire [N-1:0] Inst ;
wire [N-1:0] MemoryOutput ;

initial $dumpvars;

DataPath DP(
    .clk(clk),
    .rst(rst),
    .WriteData(WriteData),
    .Address(Address),
    .EX_MEM_RegWrite(RegWrite),
    .MEM_WB_Rd(Rd),
    .SlowClk(SlowClk),
    .Updated_Inst(Inst),
    .MemOut(MemoryOutput)
) ;

initial 
    begin
        clk = 0 ;   rst = 1 ;   #10 ;
        
        clk = 1 ;   rst = 0 ;   #10 ;
        clk = 0 ;   rst = 0 ;   #10 ;
        
        clk = 1 ;   rst = 0 ;   #10 ;
        clk = 0 ;   rst = 0 ;   #10 ;
        
        clk = 1 ;   rst = 0 ;   #10 ;
        clk = 0 ;   rst = 0 ;   #10 ;
        
        clk = 1 ;   rst = 0 ;   #10 ;
        clk = 0 ;   rst = 0 ;   #10 ;
        
        clk = 1 ;   rst = 0 ;   #10 ;
        clk = 0 ;   rst = 0 ;   #10 ;
        
        clk = 1 ;   rst = 0 ;   #10 ;
        clk = 0 ;   rst = 0 ;   #10 ;
        
        clk = 1 ;   rst = 0 ;   #10 ;
        clk = 0 ;   rst = 0 ;   #10 ;

        clk = 1 ;   rst = 0 ;   #10 ;
        clk = 0 ;   rst = 0 ;   #10 ;

        clk = 1 ;   rst = 0 ;   #10 ;
        clk = 0 ;   rst = 0 ;   #10 ;

        clk = 1 ;   rst = 0 ;   #10 ;
        clk = 0 ;   rst = 0 ;   #10 ;


        clk = 1 ;   rst = 0 ;   #10 ;
        clk = 0 ;   rst = 0 ;   #10 ;


        clk = 1 ;   rst = 0 ;   #10 ;
        clk = 0 ;   rst = 0 ;   #10 ;


        clk = 1 ;   rst = 0 ;   #10 ;
        clk = 0 ;   rst = 0 ;   #10 ;


        clk = 1 ;   rst = 0 ;   #10 ;
        clk = 0 ;   rst = 0 ;   #10 ;


        clk = 1 ;   rst = 0 ;   #10 ;
        clk = 0 ;   rst = 0 ;   #10 ;
        
        clk = 1 ;   rst = 0 ;   #10 ;
        clk = 0 ;   rst = 0 ;   #10 ;


        clk = 1 ;   rst = 0 ;   #10 ;
        clk = 0 ;   rst = 0 ;   #10 ;


        clk = 1 ;   rst = 0 ;   #10 ;
        clk = 0 ;   rst = 0 ;   #10 ;


        clk = 1 ;   rst = 0 ;   #10 ;
        clk = 0 ;   rst = 0 ;   #10 ;


        clk = 1 ;   rst = 0 ;   #10 ;
        clk = 0 ;   rst = 0 ;   #10 ;


        clk = 1 ;   rst = 0 ;   #10 ;
        clk = 0 ;   rst = 0 ;   #10 ;

        clk = 1 ;   rst = 0 ;   #10 ;
        clk = 0 ;   rst = 0 ;   #10 ;

        clk = 1 ;   rst = 0 ;   #10 ;
        clk = 0 ;   rst = 0 ;   #10 ;


        clk = 1 ;   rst = 0 ;   #10 ;
        clk = 0 ;   rst = 0 ;   #10 ;


        clk = 1 ;   rst = 0 ;   #10 ;
        clk = 0 ;   rst = 0 ;   #10 ;


        clk = 1 ;   rst = 0 ;   #10 ;
        clk = 0 ;   rst = 0 ;   #10 ;

        clk = 1 ;   rst = 0 ;   #10 ;
        clk = 0 ;   rst = 0 ;   #10 ;

        clk = 1 ;   rst = 0 ;   #10 ;
        clk = 0 ;   rst = 0 ;   #10 ;


        clk = 1 ;   rst = 0 ;   #10 ;
        clk = 0 ;   rst = 0 ;   #10 ;


        clk = 1 ;   rst = 0 ;   #10 ;
        clk = 0 ;   rst = 0 ;   #10 ;


        clk = 1 ;   rst = 0 ;   #10 ;
        clk = 0 ;   rst = 0 ;   #10 ;


        clk = 1 ;   rst = 0 ;   #10 ;
        clk = 0 ;   rst = 0 ;   #10 ;


        clk = 1 ;   rst = 0 ;   #10 ;
        clk = 0 ;   rst = 0 ;   #10 ;
        
        
        clk = 1 ;   rst = 0 ;   #10 ;
        clk = 0 ;   rst = 0 ;   #10 ;


        clk = 1 ;   rst = 0 ;   #10 ;
        clk = 0 ;   rst = 0 ;   #10 ;
        
        clk = 1 ;   rst = 0 ;   #10 ;
        clk = 0 ;   rst = 0 ;   #10 ;
        
        clk = 1 ;   rst = 0 ;   #10 ;
        clk = 0 ;   rst = 0 ;   #10 ;
        
        clk = 1 ;   rst = 0 ;   #10 ;
        clk = 0 ;   rst = 0 ;   #10 ;

        clk = 1 ;   rst = 0 ;   #10 ;
        clk = 0 ;   rst = 0 ;   #10 ;


        clk = 1 ;   rst = 0 ;   #10 ;
        clk = 0 ;   rst = 0 ;   #10 ;


        clk = 1 ;   rst = 0 ;   #10 ;
        clk = 0 ;   rst = 0 ;   #10 ;


        clk = 1 ;   rst = 0 ;   #10 ;
        clk = 0 ;   rst = 0 ;   #10 ;
        
        clk = 1 ;   rst = 0 ;   #10 ;
        clk = 0 ;   rst = 0 ;   #10 ;


        clk = 1 ;   rst = 0 ;   #10 ;
        clk = 0 ;   rst = 0 ;   #10 ;


        clk = 1 ;   rst = 0 ;   #10 ;
        clk = 0 ;   rst = 0 ;   #10 ;


        clk = 1 ;   rst = 0 ;   #10 ;
        clk = 0 ;   rst = 0 ;   #10 ;


        clk = 1 ;   rst = 0 ;   #10 ;
        clk = 0 ;   rst = 0 ;   #10 ;


        clk = 1 ;   rst = 0 ;   #10 ;
        clk = 0 ;   rst = 0 ;   #10 ;

        clk = 1 ;   rst = 0 ;   #10 ;
        clk = 0 ;   rst = 0 ;   #10 ;

        clk = 1 ;   rst = 0 ;   #10 ;
        clk = 0 ;   rst = 0 ;   #10 ;


        clk = 1 ;   rst = 0 ;   #10 ;
        clk = 0 ;   rst = 0 ;   #10 ;


        clk = 1 ;   rst = 0 ;   #10 ;
        clk = 0 ;   rst = 0 ;   #10 ;


        clk = 1 ;   rst = 0 ;   #10 ;
        clk = 0 ;   rst = 0 ;   #10 ;

        clk = 1 ;   rst = 0 ;   #10 ;
        clk = 0 ;   rst = 0 ;   #10 ;

        clk = 1 ;   rst = 0 ;   #10 ;
        clk = 0 ;   rst = 0 ;   #10 ;


        clk = 1 ;   rst = 0 ;   #10 ;
        clk = 0 ;   rst = 0 ;   #10 ;


        clk = 1 ;   rst = 0 ;   #10 ;
        clk = 0 ;   rst = 0 ;   #10 ;


        clk = 1 ;   rst = 0 ;   #10 ;
        clk = 0 ;   rst = 0 ;   #10 ;


        clk = 1 ;   rst = 0 ;   #10 ;
        clk = 0 ;   rst = 0 ;   #10 ;


        clk = 1 ;   rst = 0 ;   #10 ;
        clk = 0 ;   rst = 0 ;   #10 ;
        
        
        clk = 1 ;   rst = 0 ;   #10 ;
        clk = 0 ;   rst = 0 ;   #10 ;


        clk = 1 ;   rst = 0 ;   #10 ;
        clk = 0 ;   rst = 0 ;   #10 ;
        
        clk = 1 ;   rst = 0 ;   #10 ;
        clk = 0 ;   rst = 0 ;   #10 ;
        
        clk = 1 ;   rst = 0 ;   #10 ;
        clk = 0 ;   rst = 0 ;   #10 ;
        
        clk = 1 ;   rst = 0 ;   #10 ;
        clk = 0 ;   rst = 0 ;   #10 ;
        

        
    end
       
endmodule
