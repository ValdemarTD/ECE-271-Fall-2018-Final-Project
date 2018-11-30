module ColorParser(
  input logic [11:0] color_code,
  input logic [0:0] ModeSwitch,
  output logic [3:0] Red,
  output logic [3:0] Blue,
  output logic [3:0] Green

  );

  reg [11:0] num;
  reg [11:0] num2;
  reg [11:0] num3;
  reg [11:0] num4;
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
        num <= color_code;
        num2 <= num  % 64;
        num3 <= num2 % 16;
        num4 <= num3 % 4;
        Red <= num4;
        Blue <= (num3 - num4)/4;
        Green <= (num2 - num3)/16;
      end

    1 : begin
        num <= color_code;
        num2 <= num % 4096;
        num3 <= num2 % 256;
        num4 <= num3 % 16;
        Red <= num4;
        Blue <= (num3 - num4)/16;
        Green <= (num2 - num3)/256;
      end

    default : begin
        num <= color_code;
        num2 <= num  % 64;
        num3 <= num2 % 16;
        num4 <= num3 % 4;
        Red <= num4;
        Blue <= (num3 - num4)/4;
        Green <= (num2 - num3)/16;
      end
    endcase
  end
endmodule
