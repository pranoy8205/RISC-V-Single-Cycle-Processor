module mux2(p,q,r,s,y);

input [31:0]p,q,r;
input [1:0]s;

output[31:0]y;

assign y = (s==2'b00)? p : 
            (s==2'b01)?q :
            (s== 2'b10)? r: 32'b0;

endmodule