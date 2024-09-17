module comparator_bit(input logic [3:0] a,b, output logic y );

always_comb
begin
    if (a == b)
    begin 
        y = 1;
    end
    else
    begin
        y = 0;
    end
end

endmodule
