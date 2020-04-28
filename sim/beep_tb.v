`timescale	1ns/1ps

module	beep_tb;
	
	reg	clk,rst_n;
	reg	[3:0]key;
	
	wire	beep_out;
	beep	beep(.clk(clk),
					.rst_n(rst_n),
					.key(key),
					.beep_out(beep_out));
	
	initial
		begin
			clk=1'b1;
			rst_n=1'b0;
			key=4'd0;
			#123
			rst_n=1'b1;
			key=4'b1110;
			#1000
			key=4'd0;
			#500
			key=4'b1101;
			#1000
			key=4'd0;
			#500
			key=4'b1011;
			#1000
			key=4'd0;
			#500
			key=4'b0111;
			#1000
			key=4'd0;
			#500
			$stop;
		end
	
	always	#10	clk=~clk;
endmodule
