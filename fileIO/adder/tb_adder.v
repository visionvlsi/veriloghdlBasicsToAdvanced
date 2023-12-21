 
module tb();
 
reg [7:0] a;
reg [7:0] b;
wire [8:0] y;
integer file;
//reg [3:0] a = 4'b0010;
integer i = 0;
reg [7:0] mem [74:0];
reg [7:0] res;
integer  err = 0;
 
adder dut (a,b,y);
 

initial begin
 
file = $fopen("data.txt", "w");
for(i =0; i<25; i = i + 1) begin 
$fdisplay(file, "%x\t %x\t %x", i, i, 2*i);
end
$fclose(file);
 
file = $fopen("data.txt", "r");
$readmemh("data.txt", mem);
$fclose(file);
 
#10;
 
for(i = 0; i <= 24; i = i + 1) ///a = 0, 3, 6, 9 ..... 3*i       b = 1, 4, 7, 10 ....  c = 2, 5, 8, 11...
begin
a = mem[3*i];
b = mem[3*i + 1];
res = mem[3*i + 2];
#5
if(res != y) 
begin
err = err + 1;
end
 
#5;
end
 
if(err == 0)
$display("------------TEST PASSED---------------");
else
$display("------------TEST FAILED---------------");
 
end
 
endmodule