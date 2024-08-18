module Spartan6_DSP48A1(A, B, D, C, CLK, CARRYIN, OPMODE, BCIN, RSTA, RSTB, RSTM, RSTP, RSTC, RSTD, RSTCARRYIN, RSTOPMODE,
                        CEA, CEB, CEM, CEP, CEC, CED, CECARRYIN, CEOPMODE, PCIN, BCOUT, PCOUT, P, M, CARRYOUT, CARRYOUTF);

parameter A0REG = 0; parameter A1REG = 1; parameter B0REG = 0; parameter B1REG = 1;
parameter CREG  = 1; parameter DREG  = 1; parameter MREG  = 1; parameter PREG  = 1;
parameter CARRYINREG = 1; parameter CARRYOUTREG = 1; parameter OPMODEREG = 1;
parameter CARRYINSEL = "OPMODE5"; parameter B_INPUT = "DIRECT"; parameter RSTTYPE = "SYNC";

input  CLK, CARRYIN, RSTA, RSTB, RSTM, RSTP, RSTC, RSTD, RSTCARRYIN, RSTOPMODE, CEA, CEB, CEM, CEP, CEC, CED, CECARRYIN, CEOPMODE;
input  [7:0]OPMODE;
input  [17:0]A, B, D, BCIN;
input  [47:0]C, PCIN;

output CARRYOUT, CARRYOUTF;
output [17:0]BCOUT;
output [35:0]M;
output [47:0]P, PCOUT;

wire [17:0]D_MuxOut, B0_MuxOut, A0_MuxOut, B1_MuxOut, A1_MuxOut;
wire [17:0]B_first_mux_out;
wire [17:0]Pre_Adder_Subtractor_Out, Pre_Adder_Subtractor_MuxOut;
wire [47:0]C_MuxOut;
wire [7:0]OPMODE_MuxOut;
wire CARRYIN_CASCADE_MuxOut, CARRYIN_MuxOut;
wire [35:0]Multiplier_Out;
wire [35:0]M_MuxOut;
wire [47:0]X_MuxOut, Z_MuxOut;
wire [47:0]Post_Adder_Subtractor_Out;
wire Post_Adder_Subtractor_Cout;
wire [47:0]D_A_B_CONCATENATED;

RegOrNot_MuxInputs #(.WIDTH(18), .RSTTYPE(RSTTYPE)) I_D(D, CED, CLK, RSTD, DREG, D_MuxOut);
RegOrNot_MuxInputs #(.WIDTH(18), .RSTTYPE(RSTTYPE)) I_B0(B_first_mux_out, CEB, CLK, RSTB, B0REG, B0_MuxOut);
RegOrNot_MuxInputs #(.WIDTH(18), .RSTTYPE(RSTTYPE)) I_A0(A, CEA, CLK, RSTA, A0REG, A0_MuxOut);
RegOrNot_MuxInputs #(.WIDTH(48), .RSTTYPE(RSTTYPE)) I_C(C, CEC, CLK, RSTC, CREG, C_MuxOut);
RegOrNot_MuxInputs #(.WIDTH(8) , .RSTTYPE(RSTTYPE)) I_OPMODE(OPMODE, CEOPMODE, CLK, RSTOPMODE, OPMODEREG, OPMODE_MuxOut);

Adder_Subtractor #(.WIDTH(18)) Pre_Adder_Subtractor(D_MuxOut, B0_MuxOut, 0, OPMODE_MuxOut[6], Pre_Adder_Subtractor_Out);
Mux_2to1 #(.WIDTH(18)) Pre_Adder_Subtractor_MUX(B0_MuxOut, Pre_Adder_Subtractor_Out, OPMODE_MuxOut[4], Pre_Adder_Subtractor_MuxOut);

RegOrNot_MuxInputs #(.WIDTH(18), .RSTTYPE(RSTTYPE)) I_B1(Pre_Adder_Subtractor_MuxOut, CEB, CLK, RSTB, B1REG, B1_MuxOut);
RegOrNot_MuxInputs #(.WIDTH(18), .RSTTYPE(RSTTYPE)) I_A1(A0_MuxOut, CEA, CLK, RSTA, A1REG, A1_MuxOut);

Multiplier I_MUL(A1_MuxOut, B1_MuxOut, Multiplier_Out);
RegOrNot_MuxInputs #(.WIDTH(36), .RSTTYPE(RSTTYPE)) I_M(Multiplier_Out, CEM, CLK, RSTM, MREG, M_MuxOut);
RegOrNot_MuxInputs #(.WIDTH(1) , .RSTTYPE(RSTTYPE)) I_CARRYIN(CARRYIN_CASCADE_MuxOut, CECARRYIN, CLK, RSTCARRYIN, CARRYINREG, CARRYIN_MuxOut);

Mux_4to1 #(.WIDTH(48)) I_Mux_X({12'b0, M_MuxOut}, P, D_A_B_CONCATENATED, OPMODE_MuxOut[1:0], X_MuxOut);
Mux_4to1 #(.WIDTH(48)) I_Mux_Z(PCIN, P, C_MuxOut, OPMODE_MuxOut[3:2], Z_MuxOut);

Adder_Subtractor #(.WIDTH(48)) Post_Adder_Subtractor(Z_MuxOut, X_MuxOut, CARRYIN_MuxOut, OPMODE_MuxOut[7], Post_Adder_Subtractor_Out, Post_Adder_Subtractor_Cout);
RegOrNot_MuxInputs #(.WIDTH(1) , .RSTTYPE(RSTTYPE)) I_CARRYOUT(Post_Adder_Subtractor_Cout, CECARRYIN, CLK, RSTCARRYIN, CARRYOUTREG, CARRYOUT);
RegOrNot_MuxInputs #(.WIDTH(48), .RSTTYPE(RSTTYPE)) I_P(Post_Adder_Subtractor_Out, CEP, CLK, RSTP, PREG, P);

assign B_first_mux_out = (B_INPUT == "DIRECT") ? B : (B_INPUT == "CASCADE") ? BCIN : 0;

assign CARRYIN_CASCADE_MuxOut = (CARRYINSEL == "OPMODE5") ? OPMODE_MuxOut[5] : (CARRYINSEL == "CARRYIN") ? CARRYIN : 0;
   
assign BCOUT = B1_MuxOut;
assign D_A_B_CONCATENATED = {D[11:0], A, B};
assign M = M_MuxOut;
assign CARRYOUTF = CARRYOUT;
assign PCOUT = P;

endmodule