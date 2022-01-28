`timescale 1ns / 1ps
`include "defines.v"


module Memory #(parameter N = 32) (
    input clk,
    input MemRead,
    input MemWrite,
    input SlowClk,
    input [N-1:0] Address,
    input [N-1:0] DataIn,
    input [2:0] F3,
    output [N-1:0] Out
);
 

reg [7:0] InstMem [4095:0] ;
reg [N-1:0] DataMem [0:63] ;
reg [N-1:0] DataOut ;
wire [N-1:0] Inst ;


initial
    begin
        $readmemh("A.hex",InstMem) ;
    end

assign Inst = {InstMem[Address+3], InstMem[Address+2], InstMem[Address+1], InstMem[Address]} ;

assign Out = (SlowClk)?Inst:DataOut ;


always @(*)
  begin
    case(F3)
        3'b000: // LB
            begin
                if( MemRead == 1 )
                  begin
                    DataOut[7:0] <= DataMem[Address][7:0] ;
                    DataOut[31:8] <= {24{DataMem[Address][31]}} ;
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
                    DataOut[15:0] <= DataMem[Address][15:0] ;
                    DataOut[31:16] <= {16{DataMem[Address][31]}} ;
                  end
                else
                  begin
                    DataOut <= 0 ;
                  end
            end

        3'b010: // LW
            begin
                if( MemRead == 1 )
                    DataOut <= DataMem[Address] ;
                else
                    DataOut <= 0 ;
            end
            
        3'b100: // LBU
            begin
                if( MemRead == 1 )
                  begin
                    DataOut[7:0] <= DataMem[Address][7:0] ;
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
                    DataOut[15:0] <= DataMem[Address][15:0] ;
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
                    DataMem[Address][7:0] <= DataIn[7:0] ;
                    //DataMem[Address][31:8] <= 24'b0 ;
                  end
            end

        3'b001: // SH
            begin
                if( MemWrite == 1 )
                  begin
                    DataMem[Address][15:0] <= DataIn[15:0] ;
                    //DataMem[Address][31:16] <= 16'b0 ;
                  end
            end

        3'b010: // SW
            begin
                if( MemWrite == 1 )
                    DataMem[Address] <= DataIn ;
            end
    endcase
  end
    
endmodule
