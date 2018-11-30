module ShiftRegister11(
  input logic [0:0] SerialIn, clk,
  output logic [10:0] Parallel
);

reg [10:0] Stored;

initial begin
  Stored = 11'b00000000000;
  end

always_ff @(posedge clk)
  begin
    Stored <= {Stored[9:0], SerialIn};
    Parallel <= Stored;
  end

endmodule
