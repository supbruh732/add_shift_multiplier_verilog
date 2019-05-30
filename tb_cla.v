`timescale 1ps / 1ps

////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer:
//
// Create Date:   23:47:39 04/27/2019
// Design Name:   my_cla
// Module Name:   C:/Users/Home PC/OneDrive/Documents/Spring 2019/ECE 465/Xlinix Project/AdderTesting/tb_cla.v
// Project Name:  AdderTesting
// Target Device:  
// Tool versions:  
// Description: 
//
// Verilog Test Fixture created by ISE for module: my_cla
//
// Dependencies:
// 
// Revision:
// Revision 0.01 - File Created
// Additional Comments:
// 
////////////////////////////////////////////////////////////////////////////////

module tb_cla;

	// Inputs
	reg [3:0] A;
	reg [3:0] B;
	reg CIN;

	// Outputs
	wire [3:0] S;
	wire Gg;
	wire Pg;

	// Instantiate the Unit Under Test (UUT)
	my_cla uut (
		.A(A), 
		.B(B), 
		.CIN(CIN), 
		.S(S), 
		.Gg(Gg), 
		.Pg(Pg)
	);

	initial begin
      A = 4'b1000;
      B = 4'b0111;
      CIN = 1'b0;
      #5;
      A = 4'b110;
      B = 4'b011;
      CIN = 1'b0;
      #5;
		A = 4'b1010;
      B = 4'b0101;
      CIN = 1'b0;
      #5;
      A = 4'b1000;
      B = 4'b0111;
      CIN = 1'b0;
      #5;
      A = 4'b1001;
      B = 4'b0100;
      CIN = 1'b1;
      #5;


	end
      
endmodule

