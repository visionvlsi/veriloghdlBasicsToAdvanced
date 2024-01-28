module test(
            output reg a1,b1,cin1,
            input sum1,co1
    );
    
    integer i;
   
    initial 
        begin
        for(i=0; i<8; i=i+1)
            begin
            {a1,b1,cin1}=i;
            #5;
            end
        end
        
     always@(sum1,co1)
        begin
        if((sum1==a1^b1^cin1) && (co1==(a1&b1)|(a1&cin1)|(b1&cin1)))
        $display($time, "ns The correct output is\n",
        "a1 %b , b1 %b , cin1 %b :: sum1 %b, co1 %b",a1,b1,cin1,sum1,co1);
        else
        $display($time,"output is incorrect");
        end
    
    endmodule