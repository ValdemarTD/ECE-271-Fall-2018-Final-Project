module SignalMux(
  input logic [4:0] Sig1, Sig2, Sig3,
  output logic [3:0] DirectionOut,
  output logic [0:0] ModeSwitch
);

  always_ff @(*)
    begin
    if(Sig1 > 0)
      DirectionOut <= Sig1[3:0];
      ModeSwitch <= Sig1[4];
    else if(Sig2 > 0)
      DirectionOut <= Sig2[3:0];
      ModeSwitch <= Sig2[4];
    else if(Sig3 > 0)
      DirectionOut <= Sig3[3:0];
      ModeSwitch <= Sig3[4];
    else
      DirectionOut <= 4'b0000;
      ModeSwitch <= 0;
    end
endmodule
