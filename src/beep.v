module	beep(clk,rst_n,key,beep_out);
	
	input	clk,rst_n;
	input	[3:0]key;
	
	output	reg	beep_out;
	
	reg	[15:0]cnt;
	reg	[15:0]frep;
	
	always@(posedge clk,negedge	rst_n)
		begin
			if(!rst_n)
				cnt<=16'd0;
			else
				if(cnt==frep)
					cnt<=16'd0;
				else
					cnt<=cnt+1'b1;
		end
	
	always@(posedge	clk,negedge	rst_n)
		begin
			if(!rst_n)
				beep_out<=1'b1;
			else
				begin
					if(cnt==frep)
						beep_out<=~beep_out;
					else
						beep_out<=beep_out;
				end
		end
	
	always@(*)
   begin
	 case(key)
	   4'b1110:frep=16'd47774;//dao声
		4'b1101:frep=16'd42568;//rui
		4'b1011:frep=16'd37919;//mi
		4'b0111:frep=16'd35791;//fa
	 default:frep=16'b0;
	 endcase
	end
endmodule
