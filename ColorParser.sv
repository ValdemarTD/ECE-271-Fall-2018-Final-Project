module ColorParser(
  input logic [5:0] color_code,
  output logic [1:0] Red,
  output logic [1:0] Blue,
  output logic [1:0] Green
  );

  reg [5:0] num;
  reg [5:0] num2;
  reg [5:0] num3;
  reg [5:0] num4;

  always_ff @(*)
  begin
    num <= color_code;

    num2 <= num  % 64;
    num3 <= num2 % 16;
    num4 <= num3 % 4;
    Red <= num4;
    Blue <= (num3 - num4)/4;
    Green <= (num2 - num3)/16;

  end
endmodule
