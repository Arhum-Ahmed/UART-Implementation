module shift_reg(input logic clk, load,shift,reset, input logic [7:0] data, output logic y );

    logic [7:0] register;
    
    always_ff @(posedge clk)
    begin
        if (reset)
        begin
            y <= 0;
        end
        
        if (load)
        begin
            register <= data;
            y <= 0; // Start Bit
        end
        
        if (shift)
        begin
            register <= {1'b0, register[7:1]};
            y <= register[0];         
        end
    end

endmodule