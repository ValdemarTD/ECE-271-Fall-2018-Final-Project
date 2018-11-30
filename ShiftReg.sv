module ShiftRegister(
  input logic [0:0] SerialIn, clk,
  output logic [7:0] Parallel
);

reg [3:0] count;
reg [7:0] Stored;

initial begin
  Stored = 8'b00000000;
  count <= 0;
  end

always_ff @(posedge clk)
  begin
    Stored <= {Stored[6:0], SerialIn};
    count <= count + 1;
    case(count)
      8 : begin
          Parallel <= Stored;
          count <= 0;
          end
      default : Stored <= Stored;
      endcase
  end

endmodule
