`timescale	1ns/1ps

module	shizhong_tb;
	
	reg	clk,rst_n;
	
	wire	[2:0]sel;
	wire	[7:0]seg;
	shizhong	shizhong(.clk(clk),
							.rst_n(rst_n),
							.seg(seg),
							.sel(sel));
	
	initial
		begin
			clk=1'b1;
			rst_n=1'b0;
			#123
			rst_n=1'b1;
			#50_000_00
			$stop;
		end
	
	always	#10	clk=~clk;

endmodule
