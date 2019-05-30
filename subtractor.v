`timescale 1ps / 1ps

module subtractor( A, B, BIN, D, BOUT );
  input A, B, BIN;
  output D, BOUT;
  
  assign #2 D = A ^ B ^ BIN;				// D = A xor B xor BIN
  assign #2 BOUT = ( (~A) & (B ^ BIN) ) | ( B & BIN );
													// BOUT = ( A' and (B xor BIN) )
													//				or ( B and BIN )
													
													
endmodule



module sub_16( A, B, BIN, D, BOUT );
  input [15 : 0] A, B;
  input BIN;
  output [15 : 0] D;
  output BOUT;
  
  wire [16 : 0] wBIN;
  
  // First Subtractor with BIN as the first Borrow In
  subtractor sub1( .A(A[0]), .B(B[0]), .BIN(BIN), .D(D[0]), .BOUT(wBIN[0]) );
  
  //Generate Loop to generate the 16 Subtractors
  genvar i;
  generate for( i = 1; i < 16; i = i+1 )
    begin : SUBTRACT
	   subtractor sub1( .A(A[i]), .B(B[i]), .BIN(wBIN[i-1]), .D(D[i]), .BOUT(wBIN[i]) );
	 end
  endgenerate
  
  
  assign BOUT = wBIN[15];		// Move MSB of wBIN to BOUT as Borrow out
										//   of 16-bit subtractor
  
endmodule

