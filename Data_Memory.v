module Data_Memory(clk,A,WD,WE,RD);

input [31:0] A,WD;
input clk,WE;

output [31:0] RD;

reg [31:0] Data_Mem[1023:0];


//write
integer i;

initial begin
  for(i = 0; i < 1024; i = i + 1)
    Data_Mem[i] = 32'b0;
end

//read

assign RD = Data_Mem[A[31:2]];


   always @(posedge clk) begin
    if (WE) begin
        Data_Mem[A[31:2]] <= WD;
    end

end

endmodule