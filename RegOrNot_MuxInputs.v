module RegOrNot_MuxInputs(D, EN, CLK, RST, SEL, MuxOut);

parameter WIDTH = 18;
parameter RSTTYPE = "SYNC";

input  [WIDTH-1:0] D;
input  CLK, EN, RST, SEL;
output [WIDTH-1:0] MuxOut;
reg    [WIDTH-1:0] Q;

generate

if(RSTTYPE == "SYNC") begin
	always @(posedge CLK) begin
		if(RST) begin
			Q <= 0;
		end
		else if(EN) begin
			Q <= D;
		end
	end
end 
else begin
	always @(posedge CLK or posedge RST) begin
		if(RST) begin
			Q <= 0;
		end
		else if(EN) begin
			Q <= D;
		end
	end
end

assign MuxOut = (SEL) ? Q : D;

endgenerate

endmodule