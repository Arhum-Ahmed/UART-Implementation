module dreg (input logic clk, reset,input logic [7:0] in, input logic en ,output logic [7:0] out);

	always_ff @(posedge clk)
	begin
		if (reset)
		begin
			out <= 0;
		end
		else
		begin
			if (en)
			begin
				out <= in;
			end
		end
	end

endmodule 