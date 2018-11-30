module ColorDecoder(
  input logic [3:0] Color,
  input logic [0:0] ModeSwitch,
  output logic [3:0] Pins
);

reg [0:0] Mode;

initial begin
  Mode = 0;
end


always_ff @(posedge ModeSwitch)
  begin
    case(Mode)
      0 : Mode = 1;
      1 : Mode = 0;
      default : Mode = 0;
    endcase
  end

always_ff @(*)
  begin
  case(Mode)
    0 : begin
      case(Color)
        0: pins = 4'b0001;
        1: pins = 4'b0010;
        2: pins = 4'b0100;
        3: pins = 4'b1000;
        default: pins = 4'b0000;
      endcase
    end

    1 : begin
        pins = Color;

    default : begin
      case(Color)
        0: pins = 4'b0001;
        1: pins = 4'b0010;
        2: pins = 4'b0100;
        3: pins = 4'b1000;
        default: pins = 4'b0000;
      endcase
    end
  endcase


  end
endmodule
