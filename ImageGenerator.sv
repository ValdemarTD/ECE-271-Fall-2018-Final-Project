module ImageGen(
  input logic [9:0] cur_x, cur_y,
  input logic [0:0] clk,
  input logic [0:0] ModeSwitch,
  output logic [11:0] color,
  output logic [0:0] v_sync, h_sync
);

  reg [9:0] cx, cy;
  reg [11:0] cur_color;
  reg [11:0] bg_color;
  reg [9:0]  x, y;
  reg [0:0] Mode;

  initial begin
    x = 0;
    y = 0;
    bg_color = 0;
    cur_color = 0;
    v_sync <= 0;
    h_sync <= 0;
    Mode = 0;
  end

always_ff @(posedge ModeSwitch)
  begin
    case(Mode)
      1 : Mode = 0;
      0 : Mode = 1;
      default : Mode = 0;
    endcase
  end

always_ff @(negedge clk)
  begin
    v_sync <= 0;
    h_sync <= 0;
  end

always_ff @(posedge clk)
  begin
    cx <= cur_x;
    cy <= cur_y;
    x <= x + 1;

    case(x)
      799 : begin
              x <= 0;
              y <= y + 1;
              h_sync <= 1;
              end
      default : x <= x;
    endcase

    case(y)
      524 : begin
            y <= 0;
            v_sync <= 1;
      default : y <= y;
    endcase

    bg_color <= (x * y) % 4096;

    if(cur_x > 781 || cur_x < 146 || cur_y > 513 || cur_y < 37)
      cur_color <= $urandom_range(4095, 0);
    else
      cur_color <= cur_color;

    case(Mode)
      0 : begin
          bg_color <= bg_color % 64;
          cur_color <= cur_color % 64;
          end
      default : begin
          bg_color <= bg_color;
          cur_color <= cur_color;
          end
    endcase

    if(cur_x - x < 2 & y - cur_y > 2)
      color <= cur_color;
    else
      color <= bg_color;

  end
endmodule
