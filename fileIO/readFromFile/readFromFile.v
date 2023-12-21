`timescale 1ns / 1ps
  
module tb();
 
integer file = 0;
integer i = 0;
 
reg [6:0] mem [51:0];
reg [6:0] arr1 [25:0];
reg [6:0] arr2 [25:0];
 
initial begin
//////open a file
file = $fopen("dataRead.txt", "w"); ///location, type of operation
 
//////write operation
for(i = 0; i<= 25 ; i = i+1)
begin
$fdisplay(file, "%x\t %x", i, 5*i);
///$fdisplay(file, "%x\t %x\t %x", i, 5*i, i*i); /// file id, format spec, source of data %x, %b
end
 
$fclose(file);
 
file = $fopen("dataRead.txt", "r"); ///location, type of operation
 
////////////read operation
 
$readmemh("dataRead.txt", mem); ///// location, array
 
////////////close file
$fclose(file);
 
 
for(i=0; i<=25; i =i + 1)
begin          //// 0 , 1, 2,3
arr1[i] = mem[2*i];     ////0 , 2, 4 ,6 , 8 ....
arr2[i] = mem[2*i + 1];   /////1, 3, 5, 7......
end
 
for(i=0; i<=25; i =i + 1)
begin          
$display("%0d\t %0d", arr1[i], arr2[i]);
end
 
end
 
endmodule