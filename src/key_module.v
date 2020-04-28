module	key_module(clk,rst_n,key,key_out);
	
	input	clk,rst_n;
	input	[3:0]key;
	
	output	reg[3:0]	key_out;
	
	reg	[23:0]cnt;
	
	parameter	T20ms=10_000_000;
	localparam	key_in=4'b1111;
	
	reg	key_press;

	always@(posedge	clk,negedge	rst_n)
		begin
			if(!rst_n)
				key_press<=1'b0;
			else
				if(key_in^key)
					key_press<=1'b1;
				else
					key_press<=1'b0;
		end
	always@(posedge	clk,negedge	rst_n)
		begin
			if(!rst_n)
				begin
					cnt<=24'd0;
					key_out<=4'b1111;
				end
			else
				begin
					if(cnt==T20ms)
					begin
						cnt<=24'd0;
						if(key_press)
							key_out<=key;
						else
							key_out<=4'b1111;
					end
					else
						begin
							cnt<=cnt+1'b1;
							key_out<=4'b1111;
						end
				end
		end
endmodule
