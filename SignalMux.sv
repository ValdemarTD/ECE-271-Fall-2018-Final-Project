module SignalMux(
  input logic [4:0] Sig1, Sig2, Sig3,
  output logic [4:0] SignalOut
);

  reg [0:0] s1, s2, s3;

  initial begin
    s1 = 0;
    s2 = 0;
    s3 = 0;
    end
