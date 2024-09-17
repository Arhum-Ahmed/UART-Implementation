module tb;
	
	logic clk_i, load_byte_i, t_byte_i, reset_i;
    logic [7:0] data_i;
	logic serial_out_o ;
	
	main DUT (.clk_i(clk_i), .load_byte_i(load_byte_i), .t_byte_i(t_byte_i), 
	.data_i(data_i), .reset_i(reset_i), .serial_out_o(serial_out_o));
	
	initial 
	begin
	
	clk_i = 0;
	forever #10 clk_i = ~clk_i;
	
	end
	
	initial 
	begin
	
	DUT.serial_out_o = 0; DUT.load_xmt_shftreg_o = 0; DUT.shift_o = 0; 
	DUT.sr_o = 0; DUT.start_o = 0; DUT.clear_baud_o = 0; DUT.clear_o = 0; 
	DUT.en_counter = 0; DUT.load_xmt_dreg_o = 0; DUT.c1_o = 0; 
	DUT.c2_o = 0; DUT.dreg_o = 0; DUT.sr.y = 0; DUT.sr.register = 0;
	DUT.c1.y = 0; DUT.c2.y = 0; DUT.ctrl.cs = 0;
	
	
	load_byte_i = 0; 
	t_byte_i = 0;
	reset_i = 1;
	data_i =  8'b01010101;
	
	@(posedge clk_i);
	
	reset_i = 0;
	load_byte_i = 1;
	
	@(posedge clk_i);
	
	load_byte_i = 0;
	
	repeat(3)@(posedge clk_i);
	
	t_byte_i = 1;
	
	@ (posedge clk_i);
	
	t_byte_i = 0;
	
	repeat(55) @(posedge clk_i);
	
	reset_i = 1;
	
	@(posedge clk_i);
	
	reset_i = 0;
	
	repeat(5) @(posedge clk_i);
		
	$stop;
	end

endmodule