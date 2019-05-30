`timescale 1ps / 1ps


module cla_64( A, B, CIN, S, GG, PG );
  input [63 : 0] A, B;
  input CIN;
  output [63 : 0] S;
  output GG, PG;
  
  wire [4 : 0] COUT;
  wire [3 : 0] GGIO, PGIO;
  

	assign COUT[0] = CIN;
  
  
  // Generate loop to generate 4 16-bit CLA adders
  // This will go down to 16-bit CLA to generate 4-bit CLA adders provided
  genvar i;
  generate for( i = 0; i < 4; i=i+1 )
    begin : CLA
      cla_16 add_16b( .A(A[i*16+15:i*16]), .B(B[i*16+15:i*16]), .CIN(COUT[i]), .S(S[i*16+15:i*16]), .GG(GGIO[i]), .PG(PGIO[i]) );
    end
  endgenerate
  
  // Concurruntly call the Carry Look Ahead Circuit
  //   to generate carries for the the CLA
  LookAheadLogic lacl( .C0(CIN), .GI(GGIO), .PI(PGIO), .C(COUT[4:1]), .G(GG), .P(PG) );
  
endmodule