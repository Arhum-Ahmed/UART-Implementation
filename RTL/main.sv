module main (input logic clk_i, load_byte_i, t_byte_i, 
        input logic [7:0] data_i, 
        input logic reset_i, 
        output logic serial_out_o);
     
    logic load_xmt_shftreg_o, shift_o, sr_o, start_o, 
          comp1_o, comp2_o, clear_baud_o, clear_o, 
          en_counter, load_xmt_dreg_o;
    logic [13:0] c1_o;
    logic [3:0] c2_o;
	logic [7:0] dreg_o;
	
	shift_reg sr ( .clk(clk_i), .load(load_xmt_shftreg_o), 
    .shift(shift_o), .reset(reset_i), .data(data_i), .y(sr_o) );
    baud_counter c1 ( .clk(clk_i), .reset(clear_baud_o), .y(c1_o) );
    bit_counter c2 ( .clk(clk_i), .reset(clear_o), .en(en_counter), .y(c2_o) );
    mux21 m1 ( .a(1'b1), .b(sr_o), .sel(start_o) , .y(serial_out_o) );
    comparator_baud comp1 ( .a(c1_o), .b(14'd5), .y(comp1_o) );
    comparator_bit comp2 ( .a(c2_o), .b(4'd8), .y(comp2_o) );
    controller ctrl ( .clk_i(clk_i), .reset_i(reset_i), .byte_ready_i(load_byte_i), 
    .counter_baud_of_i(comp1_o), .counter_of_i(comp2_o), .t_byte_i(t_byte_i), 
    .load_xmt_dreg_o(load_xmt_dreg_o), .load_xmt_shftreg_o(load_xmt_shftreg_o), 
    .start_o(start_o), .clear_o(clear_o), .clear_baud_o(clear_baud_o), 
    .shift_o(shift_o), .en_counter(en_counter));

endmodule