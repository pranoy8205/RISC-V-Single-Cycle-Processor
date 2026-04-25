module Register_File(A1,A2,A3,WE3,WD3,RD1,RD2,clk,rst);

input [4:0] A1,A2,A3;
input [31:0] WD3;
input clk, WE3,rst;

output [31:0] RD1,RD2;

//creation of memory

reg [31:0] Register [31:0];

integer  i;
// Read functionality

assign RD1 = ((A1==5'b00000))? 32'b0 : Register[A1];
assign RD2 = ((A2==5'b00000))? 32'b0 : Register[A2];

// write and reset 

always@(posedge clk)
begin
  if(rst==1'b0)
  begin

    for(i=0; i<32; i++)
    Register[i]<=32'b0;

  end

  else if(WE3 && A3 !=5'b00000)
  begin
    Register[A3]<= WD3;
  end

end

endmodule