module VGA_Top(
  input logic PS2_Data, PS2_Clock, NES_Data, NES_Clock, NES_Latch, IR_Data, IR_Clock,
  output logic [3:0] Red, Green, Blue,
  output logic h_sync, v_sync
);

  timeunit 39ns;
  timeprecision 100ps;
  bit Clock_Sig=0;

  always
  begin
    #delay Clock_Sig=~Clock_Sig;
  end

  initial
  begin
   #2ms;
   $finish;
  end

  reg [4:0] PS2_Sig, NES_Sig, IR_Sig;
  reg [3:0] Direction_Sig;
  reg [0:0] ModeSwitch;
  reg [9:0] Cursor_X, Cursor_Y;
  reg [11:0] Color;

  PS2_Decoder ps2dec(
    .Sig(PS2_Data),
    .clk(PS2_Clock),
    .Out(PS2_Sig)
  );

  NES_Decoder NESdec(
    .Sig(NES_Data),
    .clk(NES_Clock),
    .Latch(NES_Latch),
    .Out(NES_Sig)
  );

  IR_Decoder IRdec(
    .Sig(IR_Data),
    .clk(IR_Clock),
    .Out(IR_Sig)
  );

  SignalMux sig(
    .Sig1(PS2_Sig),
    .Sig2(NES_Sig),
    .Sig3(IR_Sig),
    .DirectionOut(Direction_Sig),
    .ModeSwitch(ModeSwitch)
  );

  ObjectShifter obj(
    .Clock(Clock_Sig),
    .Direction(Direction_Sig),
    .x_pos(Cursor_X),
    .y_pos(Cursor_Y)
  );

  ImageGen(
    .cur_x(Cursor_X),
    .cur_y(Cursor_Y),
    .clk(Clock_Sig),
    .ModeSwitch(ModeSwitch),
    .color(Color),
    .v_sync(v_sync),
    .h_sync(h_sync)
  );

  VGA_Interface vga(
    .ModeSwitch(ModeSwitch),
    .Color(Color),
    .Red(Red),
    .Green(Green),
    .Blue(Blue)
  );

endmodule
