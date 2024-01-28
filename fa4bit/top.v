module top;

wire a,b,cin;
wire sum,co;

fa u1(.a(a),.b(b),.cin(cin),.sum(sum),.co(co));
test u2(.a1(a),.b1(b),.cin1(cin),.sum1(sum),.co1(co));

endmodule