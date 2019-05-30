`timescale 1ps / 1ps


module my_cla( A, B, CIN, S, Gg, Pg );
  parameter N = 4;
  input [N-1:0] A, B;
  input CIN;
  output reg [N-1:0] S;
  output reg Gg, Pg;
  reg GGa, GPa;			// ACC vars for Gg & Pg outputs
  reg [N-1:0] G, P, C;		// generate, propogate and carry of each adder
  integer i;


  always @ (*) begin		//always when anything changes
    for( i = 0; i < N; i = i + 1 ) begin
      G[i] = A[i] & B[i];
      P[i] = A[i] | B[i];
    end

    GGa = G[0]; 		// ACC for GGa
    GPa = P[0];			// ACC for GPa

    C[0] = CIN;			// first carry in

    for( i = 1; i < N; i = i + 1 ) begin
      C[i] = GGa | (CIN & GPa);		//Carry in from previous bit
      GGa = G[i] | (GGa & P[i]);
      GPa = P[i] & GPa;
    end

    // Set outputs to final accumlated values
    Gg = GGa;
    Pg = GPa;
	 
	 //#2;
    S = A ^ B ^ C;		//Compute Sum (A XOR B XOR CIN)
	 //#2;
  end
endmodule




module LookAheadLogic(C0, GI, PI, C, G, P);
  input C0;
  input [3:0] GI, PI;
  output reg[3:1] C;
  reg [3:0] Ci;
  output reg G,P;
  integer i,j;

  always @ (C0 or GI or PI) begin
    Ci[0] = C0;
    for (i=0; i<=2; i=i+1) Ci[i+1] = GI[i] | (PI[i] & Ci[i]);
    C = Ci[3:1];
    G = (GI[3]|PI[3]) & (GI[3]) & (GI[3]| GI[2] | PI[2]) &
        (GI[3] | GI[2] | GI[1] | PI[1]) & (GI[3] | GI[2] | GI[1] | GI[0]);
    P = PI[3] & PI[2] & PI[1] & PI[0];
end 
endmodule

