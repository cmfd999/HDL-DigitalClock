module	shizhong(clk,key,rst_n,seg,sel,beep_out);
	
	input	clk,rst_n;
	input	[3:0]key;
	
	output	[7:0]seg;
	output	[2:0]sel;
	output	beep_out;
	wire	[3:0]key_l;
	wire	[23:0]data;
	counter	counter(
		.clk(clk),
		.rst_n(rst_n),
		.key(key_l),
		.data(data)
	);
							
	display	display(
		.data(data),
		.clk(clk),
		.rst_n(rst_n),
		.sel(sel),
		.seg(seg)
	);
							
	key_module	key_module(
		.clk(clk),
		.rst_n(rst_n),
		.key(key),
		.key_out(key_l)
	);
	beep	beep(
		.clk(clk),
		.rst_n(rst_n),
		.key(key),
		.beep_out(beep_out)
	);
endmodule
