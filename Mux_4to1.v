module Mux_4to1(I1, I2, I3, SEL, MuxOut);

parameter WIDTH = 48;
input  [1:0] SEL;
input  [WIDTH-1:0]I1, I2, I3;
output [WIDTH-1:0]MuxOut;

 assign MuxOut = (SEL == 2'b00) ? 48'b0 : (SEL == 2'b01) ? I1 : (SEL == 2'b10) ? I2 : I3;

endmodule