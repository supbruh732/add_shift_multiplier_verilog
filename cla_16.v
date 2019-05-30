`timescale 1ps / 1ps


module cla_16( A, B, CIN, S, GG, PG );
  parameter N = 16;
  input [N-1 : 0] A, B;
  input CIN;
  output [N-1 : 0] S;
  output GG, PG;
  
  wire [4 : 0] COUT;
  wire [3 : 0] GGIO, PGIO;

  assign COUT[0] = CIN;
  
  
  // Generate loop to generate 4 4-bit CLA adders
  // This will go down generate 4-bit CLA adders provided
  genvar i;
  generate for( i = 0; i < 4; i=i+1 )
    begin : CLA_16
      my_cla add1( .A(A[i*4+3:i*4]), .B(B[i*4+3:i*4]), .CIN(COUT[i]), .S(S[i*4+3:i*4]), .Gg(GGIO[i]), .Pg(PGIO[i]) );
    end
  endgenerate
  
  
  // Concurruntly call the Carry Look Ahead Circuit
  //   to generate carries for the the CLA
  LookAheadLogic lacl( .C0(CIN), .GI(GGIO), .PI(PGIO), .C(COUT[4:1]), .G(GG), .P(PG) );
  
endmodule