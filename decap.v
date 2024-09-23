// module initialisation
module decap(
	input clock, reset, newkey, 
    input[4:0]keycode,
	output wire num_pressed, op_pressed, 
    output reg[3:0]operator, hex
);

	// initialising signals
  reg[4:0] cur_fullcode;
  wire[4:0] code4dig;

  // multiplexer
  always @ (newkey)
    case(newkey)
      1'b0: cur_fullcode = 5'd0;
      1'b1: cur_fullcode = keycode;
    endcase


  // splitter
  assign num_pressed = cur_fullcode[4]&&(newkey);
  assign op_pressed = (~cur_fullcode[4])&&(newkey);
  assign code4dig = cur_fullcode[3:0];

  // operator multiplexer
  always @ (op_pressed, code4dig)
    case(op_pressed)
      1: operator = code4dig; 
      0: operator = 4'd0;
    endcase
  
  	// num multiplexer
  always @ (num_pressed, code4dig)
    case(num_pressed)
      1: hex = code4dig; 
      0: hex = 4'd0;
	endcase

endmodule