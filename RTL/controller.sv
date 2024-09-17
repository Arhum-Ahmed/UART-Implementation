module controller (input logic clk_i, reset_i, byte_ready_i, counter_baud_of_i, counter_of_i, t_byte_i, 
output logic load_xmt_dreg_o, load_xmt_shftreg_o, start_o, clear_o, clear_baud_o,shift_o, en_counter);

    localparam s0 = 2'b00;
    localparam s1 = 2'b01;
    localparam s2 = 2'b10;
    
    logic [1:0] cs, ns;
    
    always_ff @(posedge clk_i)
    begin
        if (reset_i)
        begin
            cs <= s0;
        end
        else
        begin
            cs <= ns;
        end
    end
    
    // Cs
	always_comb
    begin
        case(cs)
        s0 : if (~ byte_ready_i)
             begin
                clear_baud_o = 1;
                clear_o = 1;
                load_xmt_dreg_o = 1;
                load_xmt_shftreg_o = 0; 
                start_o = 0;
                shift_o = 0;
                en_counter = 0;
             end
             else
             begin
                clear_baud_o = 1;
                clear_o = 1;
                load_xmt_dreg_o = 1;
                load_xmt_shftreg_o = 0; 
                start_o = 0;
                shift_o = 0;
                en_counter = 0;
             end
        
        s1 : if (~ t_byte_i)
             begin
                 clear_baud_o = 1;
                 clear_o = 1;
                 load_xmt_dreg_o = 0;
                 load_xmt_shftreg_o = 1; 
                 start_o = 0;
                 shift_o = 0;
                 en_counter = 0;
            end
            else
            begin
                clear_baud_o = 1;
                clear_o = 1;
                load_xmt_dreg_o = 0;
                load_xmt_shftreg_o = 0; 
                start_o = 0;
                shift_o = 0;
                en_counter = 0;
           end
      
        s2 : if (counter_of_i & (~counter_baud_of_i))
             begin
                 clear_baud_o = 0;
                 clear_o = 0;
                 load_xmt_dreg_o = 0;
                 load_xmt_shftreg_o = 0; 
                 start_o = 1;
                 shift_o = 0;
                 en_counter = 0; 
             end   
             else if ((~counter_of_i) & (~counter_baud_of_i))
             begin
                clear_baud_o = 0;
                clear_o = 0;
                load_xmt_dreg_o = 0;
                load_xmt_shftreg_o = 0; 
                start_o = 1;
                shift_o = 0;
                en_counter = 0;
             end
             else if ((~counter_of_i) & counter_baud_of_i)
             begin
                clear_baud_o = 1;
                clear_o = 0;
                load_xmt_dreg_o = 0;
                load_xmt_shftreg_o = 0; 
                start_o = 1;
                shift_o = 1;
                en_counter = 1;
             end         
             else if (counter_of_i & counter_baud_of_i)
             begin
                clear_baud_o = 0;
                clear_o = 0;
                load_xmt_dreg_o = 0;
                load_xmt_shftreg_o = 0; 
                start_o = 0;
                shift_o = 0;
                en_counter = 0;                
             end
             
             
        endcase
    end

	// Ns
	always_comb
    begin
        case(cs)
        s0 : if (~ byte_ready_i)
             begin
                ns = s0;
             end
             else
             begin
                ns = s1;
             end
        
        s1 : if (~ t_byte_i)
             begin
                 ns = s1;
             end
             else
             begin
                ns = s2;
             end
      
        s2 : if (counter_of_i & (~counter_baud_of_i))
             begin
                 ns = s2;  
             end   
             else if ((~counter_of_i) & (~counter_baud_of_i))
             begin
                ns = s2;
             end
             else if ((~counter_of_i) & counter_baud_of_i)
             begin
                ns = s2;
             end         
             else if (counter_of_i & counter_baud_of_i)
             begin
                ns = s0;
             end
             
             
        endcase
    end
	
endmodule