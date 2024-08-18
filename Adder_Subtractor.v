module Adder_Subtractor(A, B, CIN, OP, RESULT, COUT);

parameter WIDTH = 18;
input  CIN, OP;
input  [WIDTH-1:0]A, B;
output [WIDTH-1:0]RESULT;
output COUT;

assign {COUT, RESULT} = (OP) ? A-(B+CIN) : A+B+CIN;

endmodule