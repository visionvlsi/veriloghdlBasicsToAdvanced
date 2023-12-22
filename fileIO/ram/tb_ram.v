`timescale 1ns/1ns

module tb;

    reg clk, we, rst;
    reg [5:0] addr;
    reg [7:0] din;
    wire [7:0] dout;
integer i,j;
ram dut(clk,we,rst,addr,din,dout);

initial begin
clk=0;
forever begin
    #5 clk=~clk;
end
end

initial begin
rst=1;
@(posedge clk);
#20;

for(i=0;i<64;i=i+1) begin
we=1; rst=0;
din=$urandom_range(10,250);
addr=i;
#5;
@(posedge clk);
#5;
end

for(j=0;j<64;j=j+1) begin
we=0; rst=0;
addr=j;
#5;
@(posedge clk);
#5;
end
end
initial 
$monitor($time, "ns clk=%b rst=%b we=%b addr=%0d din=%0d dout=%0d", clk,rst,we,addr,din,dout);

initial
#3000 $stop;

endmodule