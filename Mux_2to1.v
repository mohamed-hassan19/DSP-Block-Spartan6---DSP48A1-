module Mux_2to1(I0, I1, SEL, MuxOut);

parameter WIDTH = 18;
input  SEL;
input  [WIDTH-1:0]I0, I1;
output [WIDTH-1:0]MuxOut;

assign MuxOut = (SEL) ? I1 : I0;

endmodule