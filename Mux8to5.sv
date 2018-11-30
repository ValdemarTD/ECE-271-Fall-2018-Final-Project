module Mux8to5(
  input logic [7:0] DataIn,
  output logic [4:0] DataOut
);

reg [0:0] num0, num1, num2, num3, num4, endbit;
reg [4:0] ToOut;

initial begin
  ToOut = 5'b00000;
  num0 = 0;
  num1 = 0;
  num2 = 0;
  num3 = 0;
  num4 = 0;
  endbit = 0;
  end

always_ff @(*)
  begin
    num0 = DataIn[7] ^ DataIn[6];
    num1 = DataIn[6] ^ DataIn[5];
    num2 = DataIn[5] ^ DataIn[4];
    num3 = DataIn[4] ^ DataIn[3];
    num4 = DataIn[3] ^ endbit;

    ToOut <= {num0, num1, num2, num3, num4};

    DataOut <= ToOut;
  end
endmodule    
