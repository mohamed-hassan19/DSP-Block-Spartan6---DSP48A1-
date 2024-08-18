module Spartan6_DSP48A1_tb();

parameter A0REG = 0; parameter A1REG = 1; parameter B0REG = 0; parameter B1REG = 1;
parameter CREG  = 1; parameter DREG  = 1; parameter MREG  = 1; parameter PREG  = 1;
parameter CARRYINREG = 1; parameter CARRYOUTREG = 1; parameter OPMODEREG = 1;
parameter CARRYINSEL = "OPMODE5"; parameter B_INPUT = "DIRECT"; parameter RSTTYPE = "SYNC";

reg  CLK, CARRYIN, RSTA, RSTB, RSTM, RSTP, RSTC, RSTD, RSTCARRYIN, RSTOPMODE, CEA, CEB, CEM, CEP, CEC, CED, CECARRYIN, CEOPMODE;
reg  [7:0]OPMODE;
reg  [17:0]A, B, D, BCIN;
reg  [47:0]C, PCIN;

wire CARRYOUT, CARRYOUTF;
wire [17:0]BCOUT;
wire [35:0]M;
wire [47:0]P, PCOUT;

Spartan6_DSP48A1 #(.A0REG(A0REG), .A1REG(A1REG), .B0REG(B0REG), .B1REG(B1REG), .CREG(CREG), .DREG(DREG), .MREG(MREG), .PREG(PREG),
                   .CARRYINREG(CARRYINREG), .CARRYOUTREG(CARRYOUTREG), .OPMODEREG(OPMODEREG), .CARRYINSEL(CARRYINSEL), .B_INPUT(B_INPUT),
                   .RSTTYPE(RSTTYPE)) 
                 P1(A, B, D, C, CLK, CARRYIN, OPMODE, BCIN, RSTA, RSTB, RSTM, RSTP, RSTC, RSTD, RSTCARRYIN, RSTOPMODE,
                    CEA, CEB, CEM, CEP, CEC, CED, CECARRYIN, CEOPMODE, PCIN, BCOUT, PCOUT, P, M, CARRYOUT, CARRYOUTF); 

initial begin
	CLK = 0;
	forever
	#1 CLK = ~CLK;
end

integer i;
initial begin
	RSTA = 1; RSTB = 1; RSTM = 1; RSTP = 1; RSTC = 1; RSTD = 1; RSTCARRYIN = 1; RSTOPMODE = 1;
	for(i = 0; i<5; i = i+1) begin
		CEA = $random; CEB = $random; CEM = $random; CEP = $random; CEC = $random; CED = $random; CECARRYIN = $random; CEOPMODE = $random;
		OPMODE = $random; A = $random; B = $random; C = $random; D = $random; BCIN = $random; PCIN = $random;
		@(negedge CLK);
	end
	
	RSTA = 0; RSTB = 0; RSTM = 0; RSTP = 0; RSTC = 0; RSTD = 0; RSTCARRYIN = 0; RSTOPMODE = 0;
	CEA = 1; CEB = 1; CEM = 1; CEP = 1; CEC = 1; CED = 1; CECARRYIN = 1; CEOPMODE = 1;
	@(negedge CLK);

	OPMODE = 8'b11111101; A = 46854; B = 54600; C = 10002000; D = 150220; BCIN = $random; PCIN = 4050000; CARRYIN = $random;
	@(negedge CLK);

	OPMODE = 8'b11111111; A = 76500; B = 34600; C = 50002000; D = 200220; BCIN = $random; PCIN = 802000; CARRYIN = $random;
	@(negedge CLK);

	OPMODE = 8'b11110101; A = 6730; B = 8420; C = 1804400; D = 240500; BCIN = $random; PCIN = 4597800; CARRYIN = $random;
	@(negedge CLK);

	OPMODE = 8'b11110111; A = 78940; B = 35100; C = 500800; D = 79120; BCIN = $random; PCIN = 879797; CARRYIN = $random;
	@(negedge CLK);

	OPMODE = 8'b11111001; A = 13320; B = 70800; C = 460000; D = 120600; BCIN = $random; PCIN = 320000; CARRYIN = $random;
	@(negedge CLK);

	OPMODE = 8'b11111011; A = 54000; B = 3700; C = 142500; D = 15020; BCIN = $random; PCIN = 7641000; CARRYIN = $random;
	@(negedge CLK);

	OPMODE = 8'b11111110; A = 2013; B = 43610; C = 1346200; D = 127820; BCIN = $random; PCIN = 4561320; CARRYIN = $random;
	@(negedge CLK);

	OPMODE = 8'b00111101; A = 46854; B = 54600; C = 10002000; D = 150220; BCIN = $random; PCIN = 4050000; CARRYIN = $random;
	@(negedge CLK);

	OPMODE = 8'b00111111; A = 76500; B = 34600; C = 50002000; D = 200220; BCIN = $random; PCIN = 802000; CARRYIN = $random;
	@(negedge CLK);

	OPMODE = 8'b00110101; A = 6730; B = 8420; C = 1804400; D = 240500; BCIN = $random; PCIN = 4597800; CARRYIN = $random;
	@(negedge CLK);

	OPMODE = 8'b00110111; A = 78940; B = 35100; C = 500800; D = 79120; BCIN = $random; PCIN = 879797; CARRYIN = $random;
	@(negedge CLK);

	OPMODE = 8'b00111001; A = 13320; B = 70800; C = 460000; D = 120600; BCIN = $random; PCIN = 320000; CARRYIN = $random;
	@(negedge CLK); 

	OPMODE = 8'b00111011; A = 54000; B = 3700; C = 142500; D = 15020; BCIN = $random; PCIN = 7641000; CARRYIN = $random;
	@(negedge CLK);

	OPMODE = 8'b00111110; A = 2013; B = 43610; C = 1346200; D = 127820; BCIN = $random; PCIN = 4561320; CARRYIN = $random;
	@(negedge CLK);

	OPMODE = 8'b11001101; A = 46854; B = 54600; C = 10002000; D = 150220; BCIN = $random; PCIN = 4050000; CARRYIN = $random;
	@(negedge CLK);

	OPMODE = 8'b11001111; A = 76500; B = 34600; C = 50002000; D = 200220; BCIN = $random; PCIN = 802000; CARRYIN = $random;
	@(negedge CLK);

	OPMODE = 8'b11000101; A = 6730; B = 8420; C = 1804400; D = 240500; BCIN = $random; PCIN = 4597800; CARRYIN = $random;
	@(negedge CLK);

	OPMODE = 8'b11000111; A = 78940; B = 35100; C = 500800; D = 79120; BCIN = $random; PCIN = 879797; CARRYIN = $random;
	@(negedge CLK);

	OPMODE = 8'b11001001; A = 13320; B = 70800; C = 460000; D = 120600; BCIN = $random; PCIN = 320000; CARRYIN = $random;
	@(negedge CLK);

	OPMODE = 8'b11001011; A = 54000; B = 3700; C = 142500; D = 15020; BCIN = $random; PCIN = 7641000; CARRYIN = $random;
	@(negedge CLK);

	OPMODE = 8'b11001110; A = 2013; B = 43610; C = 1346200; D = 127820; BCIN = $random; PCIN = 4561320; CARRYIN = $random;
	@(negedge CLK);

	OPMODE = 8'b00001101; A = 46854; B = 54600; C = 10002000; D = 150220; BCIN = $random; PCIN = 4050000; CARRYIN = $random;
	@(negedge CLK);

	OPMODE = 8'b00001111; A = 76500; B = 34600; C = 50002000; D = 200220; BCIN = $random; PCIN = 802000; CARRYIN = $random;
	@(negedge CLK);

	OPMODE = 8'b00000101; A = 6730; B = 8420; C = 1804400; D = 240500; BCIN = $random; PCIN = 4597800; CARRYIN = $random;
	@(negedge CLK);

	OPMODE = 8'b00000111; A = 78940; B = 35100; C = 500800; D = 79120; BCIN = $random; PCIN = 879797; CARRYIN = $random;
	@(negedge CLK);

	OPMODE = 8'b00001001; A = 13320; B = 70800; C = 460000; D = 120600; BCIN = $random; PCIN = 320000; CARRYIN = $random;
	@(negedge CLK);

	OPMODE = 8'b00001011; A = 54000; B = 3700; C = 142500; D = 15020; BCIN = $random; PCIN = 7641000; CARRYIN = $random;
	@(negedge CLK);

	OPMODE = 8'b00001110; A = 2013; B = 43610; C = 1346200; D = 127820; BCIN = $random; PCIN = 4561320; CARRYIN = $random;
	@(negedge CLK);

	$stop;

end

endmodule