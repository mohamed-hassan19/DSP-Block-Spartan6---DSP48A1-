module Multiplier(A, B, OUT);

input  [17:0]A, B;
output [35:0] OUT;

assign OUT = A*B;

endmodule