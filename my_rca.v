
`timescale 1ps / 1ps

module fulladder( A, B, Cin, Sum, Cout ); //1-bit full adder
  input A,B,Cin;
  output Sum, Cout;
  
  //reg Sum, Cout;

  wire w1,w2,w3;
  
  xor X1(w1,A,B);   		//w1 = A xor B
  xor X2(Sum,Cin,w1);	//SUM = Cin xor w1
  and X3(w2,w1,Cin);		//w2 = w1 AND Cin
  and X4(w3,A,B);		   //w3 = A and B
  or  X5(Cout,w2,w3);	//Cout = w2 or w3

  
endmodule



module RCA( A, B, Cin, S, Cout);
  input [63 : 0] A, B;
  input Cin;
  output [63 : 0] S;
  output Cout;
  
  wire [63:0] wC;
  
  //First full adder with CIN as carry
  fulladder A1( A[0], B[0], Cin, S[0], wC[0] );


  //Generate Loop to generate the 64 Fulladders
  genvar i;
  generate for( i = 1; i < 64; i = i+1 )
    begin: RCA_GEN
      fulladder add( .A(A[i]), .B(B[i]), .Cin(wC[i-1]), .Sum(S[i]), .Cout(wC[i]) );
    end
  endgenerate

  assign Cout = wC[63];		//assign the MSB of wC to Cout as Carry out
									//   of 64-bit RCA

endmodule

