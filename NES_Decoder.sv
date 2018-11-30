module NES_Decoder(
  input logic Sig, clk, Latch,
  output logic [4:0] Out
);

reg [7:0] Stored;
reg [3:0] count;

always_ff @(posedge Latch)
  begin
    Stored <= 8'b00000000;
    count <= 1;
    Stored <= {Stored[6:0], Sig};
  end

always_ff @(negedge clk)
  begin
    count <= count + 1;
    case(count)
      8 : begin
        case(Stored)
          8'b10000000 : Out <= 5'b00001;
          8'b00001000 : Out <= 5'b10000;
          8'b00000100 : Out <= 5'b01000;
          8'b00000010 : Out <= 5'b00100;
          8'b00000001 : Out <= 5'b00010;
          default : Out <= 5'b00000;
        endcase
        end
      default : begin
                if(Stored > 0)
                  Stored <= {Stored[6:0], 0};
                else
                  Stored <= {Stored[6:0], Sig};
                end
      endcase
    end
endmodule
