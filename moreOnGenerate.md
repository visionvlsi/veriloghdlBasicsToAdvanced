<b>More on Generate Blocks in Verilog</b>


<p align="justify">The generate statement in Verilog is a very useful construct that generates synthesizable code during elaboration time dynamically. The simulator provides an elaborated code of the ‘generate’ block. It provides the below facilities:</p>

<ol>

<li> To generate multiple module instances or code repetition.</li>
<li>Conditionally instantiate a block of code based on the Verilog parameter, however, the parameter is not permitted in the generate statement.</li>

</ol>
<p align="justify"> It basically provides control on variables, functions, tasks, and instantiation declarations. A generate block has been written within generate and endgenerate keywords.</p>

<b> Types of generate instantiation</b>
<ol>
<li>Modules</li>
<li>Verilog gate primitives</li>
<li>Continuous assignments</li>
<li>Initial and always blocks</li>
<li>User-defined primitives</li>
<ol/>

<b>Let’s see what is allowed within the scope of a generate block.</b>

<b> A. Data types </b>

<ol>
<li>integer, real</li>
<li>net, reg</li>
<li>time, realtime</li>
<li>event</li>
<ol/>
  
<b> B. Function and task </b>

<b> <p align="justify"> Note: Function and task are not allowed within a generate loop, but they are allowed in generate block.</p> </b>

<b> Below module items/declarations are not allowed within the scope of a generate block</b>

<ol>
<li> Port declarations like input, output, and inout </li>
<li> specify blocks </li>
<li> parameters and local parameters </li>
<ol/>

<b>Methods to write generate statements</b>

<ol>
<li> Generate loop </li>
<li> Generate conditional (includes generate if-else and generate case) </li>
<ol/>

<b>Generate loop</b>

<p align="justify">The generate loop is similar to the for loop statement, but it uses genvar keyword as a loop variable.</p>
<ol>
<li> The genvar keyword is only used during the evaluation of generate block and does not exist during the simulation of the design. It needs to be used by a generate loop. </li>

<li> Generate loop provides flexibility to reduce code lines by replacing repetitive statements to a single statement like for loop.</li>

<li> Similar to a for loop, generate loops also can be nested with different genvar as an index variable.</li>
</ol>

```

// Example: Ripple Carry Adder

module full_adder(
input a, b, cin,
output sum, cout
);

assign {sum, cout} = {a^b^cin, ((a & b) | (b & cin) | (a & cin))};
//or
//assign sum = a^b^cin;
//assign cout = (a & b) | (b & cin) | (a & cin);
endmodule

module ripple_carry_adder #(parameter SIZE = 4) (
input [SIZE-1:0] A, B, 
input Cin,
output [SIZE-1:0] S, Cout);

genvar g;

full_adder fa0(A[0], B[0], Cin, S[0], Cout[0]);
generate  // This will instantial full_adder SIZE-1 times
for(g = 1; g<SIZE; g++) begin
full_adder fa(A[g], B[g], Cout[g-1], S[g], Cout[g]);
end
endgenerate
endmodule

```

<b>Generate conditional</b>

<p align="justify">A generate block allows conditionally instantiated using if-else-if construct and case keyword.</p>

```

//<b>Example: generate If-else</b>
//In the below example, based on parameter sel full adder or half-adder design is instantiated. 
//By default, parameter sel = 0 means half adder will be instantiated. 
//But from the testbench code, parameter sel = 1 is passed to instantiate full adder. 
//$display cannot be used within generate block without initial block, otherwise, 
//it throws an error '$display' is an invalid generate scope construct.

module half_adder(
input a, b,
output sum, cout
);

assign {sum, cout} = {a^b, (a & b)};
//or
//assign sum = a^b;
//assign cout = a & b;
endmodule

module full_adder(
input a, b, cin,
output sum, cout
);

assign {sum, cout} = {a^b^cin, ((a & b) | (b & cin) | (a & cin))};
//or
//assign sum = a^b^cin;
//assign cout = (a & b) | (b & cin) | (a & cin);
endmodule

module gen_if_ex #(parameter sel = 0)(
input A, B, Cin,
output S, Cout);

generate
if(sel) begin
initial $display("Full Adder is selected");
full_adder fa(A, B, Cin, S, Cout);
end
else begin
initial $display("Half Adder is selected");
half_adder ha(A, B, S, Cout);
end
endgenerate
endmodule

```

```

// <b>Example: generate case</b>
// Similarly, the above example if-else generate block can alternatively use case statement as specified in the below example.

module half_adder(
input a, b,
output sum, cout
);

assign {sum, cout} = {a^b, (a & b)};
//or
//assign sum = a^b;
//assign cout = a & b;
endmodule

module full_adder(
input a, b, cin,
output sum, cout
);

assign {sum, cout} = {a^b^cin, ((a & b) | (b & cin) | (a & cin))};
//or
//assign sum = a^b^cin;
//assign cout = (a & b) | (b & cin) | (a & cin);
endmodule

module gen_if_ex #(parameter sel = 0)(
input A, B, Cin,
output S, Cout);

generate
case(sel)
0: begin 
initial $display("Full Adder is selected");
half_adder ha(A, B, S, Cout);
end
1: begin 
initial $display("Full Adder is selected");
full_adder fa(A, B, Cin, S, Cout);
end
endcase
endgenerate
endmodule

```
