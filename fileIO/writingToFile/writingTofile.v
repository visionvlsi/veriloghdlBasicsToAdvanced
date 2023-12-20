`timescale 1ns / 1ps
 
module tb();
 
integer file = 0;
integer i = 0;
 
initial begin
file = $fopen("data.txt", "w"); ///location, type of operation
 
for(i = 0; i<= 25 ; i = i+1)
begin
$fdisplay(file, "%x\t %x\t %x", i, 5*i, i*i); /// file id, format spec, source of data %x, %b
end
 
$fclose(file);
end
 
 
endmodule
