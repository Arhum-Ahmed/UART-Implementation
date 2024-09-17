module baud_counter(input logic clk, reset, output logic [13:0] y );

    always_ff @(posedge clk)
    begin
        if (reset)
        begin
            y <= 0;
        end
        else
        begin
            y <= y + 1;
        end
    end

endmodule