module	display(data,clk,rst_n,sel,seg);

	input	[23:0]data;
	input	clk,rst_n;
	
	output	reg[2:0]sel;
	output	reg[7:0]seg;
	
	reg	[15:0]cnt;
	
	parameter	T1ms=50_000;
	
	always@(posedge	clk,negedge	rst_n)
		begin
			if(!rst_n)
				cnt<=16'd0;
			else
				begin
					if(cnt==T1ms-1'b1)
						cnt<=16'd0;
					else
						cnt<=cnt+1'b1;
				end
		end
	
	wire	flag;
	assign	flag=(cnt==T1ms-1'b1)?1'b1:1'b0;
	
	reg	[2:0]state;
	reg	[3:0]show_data;
	always@(posedge	clk,negedge	rst_n)
		begin
			if(!rst_n)
				begin
					sel<=3'd7;
					state<=3'd0;
				end
			else
				begin
					case(state)
						3'd0	:begin
									if(flag)
										state<=3'd1;
									else
										begin
											show_data<=data[23:20];
											sel<=3'd0;
											state<=3'd0;
										end
								end
						3'd1	:begin
									if(flag)
										state<=3'd2;
									else
										begin
											show_data<=data[19:16];
											sel<=3'd1;
											state<=3'd1;
										end
								end
						3'd2	:begin
									if(flag)
										state<=3'd3;
									else
										begin
											show_data<=data[15:12];
											sel<=3'd2;
											state<=3'd2;
										end
								end
						3'd3	:begin
									if(flag)
										state<=3'd4;
									else
										begin
											show_data<=data[11:8];
											sel<=3'd3;
											state<=3'd3;
										end
								end
						3'd4	:begin
									if(flag)
										state<=3'd5;
									else
										begin
											show_data<=data[7:4];
											sel<=3'd4;
											state<=3'd4;
										end
								end
						3'd5	:begin
									if(flag)
										state<=3'd0;
									else
										begin
											show_data<=data[3:0];
											sel<=3'd5;
											state<=3'd5;
										end
								end
						default	:state<=3'd0;
					endcase
				end
		end
	
	always@(*)
	  begin
	      if(!rst_n)
			  begin
			    seg=8'b1111_1111;
			  end
			else
			  begin
			    case(show_data)
				     0: seg=8'b1100_0000;
                 1: seg=8'b1111_1001;
					  2: seg=8'b1010_0100;
					  3: seg=8'b1011_0000;
					  4: seg=8'b1001_1001;
					  5: seg=8'b1001_0010;
					  6: seg=8'b1000_0010;
					  7: seg=8'b1111_1000;
					  8: seg=8'b1000_0000;
					  9: seg=8'b1001_0000;
					  default :seg=8'b0000_0000;
				 endcase
			  end
	  end
endmodule
