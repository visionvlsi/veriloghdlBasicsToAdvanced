`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 28.01.2024 15:37:54
// Design Name: 
// Module Name: fa
// Project Name: 
// Target Devices: 
// Tool Versions: 
// Description: 
// 
// Dependencies: 
// 
// Revision:
// Revision 0.01 - File Created
// Additional Comments:
// 
//////////////////////////////////////////////////////////////////////////////////


module fa(
            input a,b,cin,
            output sum,co
    );
    
    wire s1,c1,c2;
    ha ins1(.a(a),.b(b),.sum(s1),.co(c1));
    ha ins2(.a(s1),.b(cin),.sum(sum),.co(c2));
    orgate ins3(.a(c1),.b(c2),.y(co));
endmodule
