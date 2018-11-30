module ObjectShifter(
  input logic [0:0] Clock,
  input logic [3:0] Direction,
  output logic [9:0] x_pos, y_pos
);

  reg [9:0] x, y;
  reg [0:0] Up, Down, Left, Right;
  reg [0:0] Top, Bottom, LSide, RSide;


  initial begin
    x = 370;
    y = 240;

  always_ff @(posedge Clock)
    if(x > 637)
      RSide = 1;
    else
      RSide = 0;

    if(x < 2)
      LSide = 1;
    else
      LSide = 0;

    if(y > 477)
      Bottom = 1;
    else
      Bottom = 0;

    if(y < 2)
      Top = 1;
    else
      Top = 0;

    case(Up)
      1 : begin
          if(!Top)
            y <= y - 1;
          end
      default : y <= y;
    endcase

    case(Down)
      1 : begin
          if(!Bottom)
            y <= y + 1;
          end
      default : y <= y;
    endcase

    case(Left)
      1 : begin
          if(!LSide)
            x <= x - 1;
          end
      default : x <= x;
    endcase

    case(Right)
      1 : begin
          if(!RSide)
            x <= x + 1;
          end
      default : x <= x;
    endcase

    x_pos <= x;
    y_pos <= y;

  end
endmodule
