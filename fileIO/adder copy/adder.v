`timescale 1ns / 1ps
 
module adder(
input [7:0] a,b,
output [8:0] y
);
 
assign y = a + b;
 
endmodule