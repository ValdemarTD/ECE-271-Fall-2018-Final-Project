module VGA_Interface(
  input logic [0:0] ModeSwitch,
  input logic [11:0] Color,
  output logic [3:0] Red, Green, Blue
);


  reg [3:0] R, G, B;

    ColorParser parse(
      .color_code(Color),
      .ModeSwitch(ModeSwitch),
      .Red(R),
      .Green(G),
      .Blue(B)
    );

    ColorDecoder RDec(
      .Color(R),
      .ModeSwitch(ModeSwitch),
      .Pins(Red)
    );

    ColorDecoder GDec(
      .Color(G),
      .ModeSwitch(ModeSwitch),
      .Pins(Green)
    );

    ColorDecoder BDec(
      .Color(B),
      .ModeSwitch(ModeSwitch),
      .Pins(Blue)
    );

endmodule
