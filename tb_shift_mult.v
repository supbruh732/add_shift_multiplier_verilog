`timescale 1ps / 1ps

module tb_shift_mult;

	// Inputs
	reg CLK;
	reg ST;
	reg RST;
	reg [31:0] M_PLIER;
	reg [31:0] M_CAND;

	// Outputs
	wire DONE;
	wire [63:0] PRODUCT;

	// Instantiate the Unit Under Test (UUT)
	shift_add_mult uut (
		.CLK(CLK), 
		.ST(ST), 
		.RST(RST), 
		.M_PLIER(M_PLIER), 
		.M_CAND(M_CAND), 
		.DONE(DONE), 
		.PRODUCT(PRODUCT)
	);
	
	
	initial begin
	  CLK = 1;
	  forever begin
	    #2 CLK = ~CLK;
     end
	end

	initial begin
		// Initialize Inputs
		//CLK = 0;
		ST = 1;
		RST = 0;
		M_PLIER = 32'b11101001010011101010001111111111;
		M_CAND = 32'b010;
      #2;
		ST = 0;
		// Wait 100 ns for global reset to finish
		#400;
        
		// Add stimulus here

	end
      
endmodule

