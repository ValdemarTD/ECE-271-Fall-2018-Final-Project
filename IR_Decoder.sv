module IR_Decoder(
  input logic [0:0] Sig, clk,
  output logic [4:0] Out
);

  reg [7:0] Stored;
  reg [0:0] count;

  initial begin
    count <= 0;
    Stored <= 8'b00000000;
    end

  ShiftRegister8(
    .SerialIn(Sig),
    .clk(clk),
    .Parallel(Stored)
  );

  always_ff @(posedge clk)
    begin
      count <= count + 1;
      case(count)
        8 : begin
            count <= 0;
            case(Stored)
              8'b10000000 : Out <= 5'b10000;
              8'b01000000 : Out <= 5'b01000;
              8'b00100000 : Out <= 5'b00100;
              8'b00010000 : Out <= 5'b00010;
              8'b00001000 : Out <= 5'b10001;
              default : Out <= 5'b00000;
            endcase
            end
        default : Stored <= Stored;
        endcase
    end
endmodule
