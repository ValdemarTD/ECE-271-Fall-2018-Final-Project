module PS2_Decoder(
  input logic [0:0] Sig, clk,
  output logic [4:0] Out
);

reg [0:0] count;
reg [10:0] Stored;
reg [4:0] ToOut;

ShiftRegister11 shift(
  .clk(clk),
  .SerialIn(Sig),
  .Parallel(Stored)
  );

initial begin
  count <= 0;
  Stored <= 11'b00000000000;
  end

always_ff @(negedge clk)
  begin
    count <= count + 1;
    case(count)
      8 : begin
          case(Stored)
            11'b00111010111 : begin
                          if(ToOut[0] == 1)
                            ToOut[0] = 0;
                          else
                            ToOut[0] = 1;
                          end

            11'b00110101111 : begin
                          if(ToOut[1] == 1)
                            ToOut[1] = 0;
                          else
                            ToOut[1] = 1;
                          end

            11'b00111001001 : begin
                          if(ToOut[2] == 1)
                            ToOut[2] = 0;
                          else
                            ToOut[2] = 1;
                          end

            11'b00111010001 : begin
                          if(ToOut[3] == 1)
                            ToOut[3] = 0;
                          else
                            ToOut[3] = 1;
                          end

            11'b00101101001 : begin
                          if(ToOut[4] == 1)
                            ToOut[4] = 0;
                          else
                            ToOut[4] = 1;
                          end

            default: ToOut <= ToOut;
            endcase

          count <= 0;
          end
      default: count <= count;
    Out <= ToOut;
  end
endmodule
