`timescale	1ns/1ps

module	key_module_tb;
	
	reg	clk,rst_n;
	reg	[3:0]key;
	
	wire	[3:0]key_out;
	key_module	key_module(.clk(clk),
									.rst_n(rst_n),
									.key(key),
									.key_out(key_out));
	
	initial	
		begin
			clk=1'b1;
			rst_n=1'b0;
			key=4'b1111;
			#123
			rst_n=1'b1;
			key=4'b1111;
			#500;
			key=4'b1011;
			#1000
			key=4'b1111;
			#500
			key=4'b1101;
			#1000
			$stop;
		end
	
	always	#10	clk=~clk;

endmodule
