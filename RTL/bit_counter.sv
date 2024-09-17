module bit_counter(input logic clk, reset, en,output logic [3:0] y );

    always_ff @(posedge clk)
    begin
        if (reset)
        begin
            y <= 0;
        end
        else
        begin
            if (en)
            begin
                y <= y + 1;
            end
        end
    end

endmodule