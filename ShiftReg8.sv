module ShiftRegister8(
  input logic [0:0] SerialIn, clk,
  output logic [7:0] Parallel
);

reg [7:0] Stored;

initial begin
  Stored = 8'b00000000;
  end

always_ff @(posedge clk)
  begin
    Stored <= {Stored[6:0], SerialIn};
    Parallel <= Stored;
  end

endmodule
