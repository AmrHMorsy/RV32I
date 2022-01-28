/*******************************************************************
*
* Module: Main
* Project: RISC-V Implementation
* Author: Amr Morsy amrhassan18@aucegypt.edu
          Mohi Eldin El Ulabi mhulabi@aucegypt.edu
* Description: This is the main module. It is going to be used eventually to run the modules SSD as well as datapath to display on FPGA
*
* IMPORTANT Change history: 28/10/21 – I wrote the code
*
**********************************************************************/

`timescale 1ns / 1ps
`include "defines.v"


module Main(
 input clk,
 input rst,
 input [1:0] ledSel,
 input [3:0] ssdSel,
 input ssd_clk,
 output  [3:0] Anode,
 output  [3:0] AN,
 output  [6:0] SSD_Output ,
 output  [15:0] LED 
);


wire [12:0] ssd ; 

DataPath D( .clk(clk) , .rst(rst) , .ledSel(ledSel) , .SSDSel(ssdSel) , .LED_out(LED) , .SSD_Output(ssd) ) ;
Four_Digit_Seven_Segment_Driver S( .clk(ssd_clk) , .num(ssd) , .Anode(Anode) , .AN(AN) , .LED_out(SSD_Output) ) ;  

    
endmodule
