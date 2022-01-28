`timescale 1ns / 1ps


module MUX4(
    input [31:0] A,
    input [31:0] B,
    input [31:0] C,
    input [1:0] S,
    output [31:0] Result
);
   
assign Result = S[1] ? (S[0] ? 0 : C) : (S[0] ? B : A);

endmodule
