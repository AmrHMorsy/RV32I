/*******************************************************************
*
* Module: BCD
* Project: RISC-V Implementation
* Author: Amr Morsy amrhassan18@aucegypt.edu
          Mohi Eldin El Ulabi mhulabi@aucegypt.edu
* Description: This is the BCD module. It is used by the SSD module for displaying on FPGA. At this stage, it is not very important
*
* IMPORTANT Change history: 28/10/21 – I wrote the code
*
**********************************************************************/

module BCD (
  input [12:0] num,
  output reg [3:0] Th ,
  output reg [3:0] Hundreds,
  output reg [3:0] Tens,
  output reg [3:0] Ones
);

integer i;

always @(num)
  begin
	Th = 4'd0 ; 
	Hundreds = 4'd0;
 	Tens = 4'd0;
 	Ones = 4'd0;
	for (i = 12; i >= 0 ; i = i-1 )
  	  begin
		if( Th >= 5 )
			Th = Th + 3 ;
		if(Hundreds >= 5 )
 			Hundreds = Hundreds + 3;
		if (Tens >= 5 )
 			Tens = Tens + 3;
 		if (Ones >= 5)
 			Ones = Ones +3;
 		Th = Th << 1 ; 
 		Th[0] = Hundreds[3] ;
 		Hundreds = Hundreds << 1;
 		Hundreds [0] = Tens [3];
 		Tens = Tens << 1;
 		Tens [0] = Ones[3];
 		Ones = Ones << 1;
 		Ones[0] = num[i];
	  end
  end

endmodule
