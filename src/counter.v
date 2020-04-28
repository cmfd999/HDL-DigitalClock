module	counter(key,clk,rst_n,data);

	input	clk,rst_n;
	input	[3:0]key;
	
	output	reg[23:0]data;
	
	reg	[25:0]cnt;
	reg	[3:0]miao_l,miao_h,fen_l,fen_h,shi_l,shi_h;
	
	parameter	T1s=50_000_000;
	reg	stop;
	always@(posedge	clk,negedge	rst_n)
		begin
			if(!rst_n)
				stop<=1'b0;
			else
				begin
					if(key[0]==1'b0)
						stop<=~stop;
					else
						stop<=stop;
				end
		end
	always@(posedge clk,negedge rst_n)
		begin
			if(!rst_n)
				begin
					cnt<=26'd0;
				end
			else
				begin
					if(stop)
						cnt<=cnt;
					else
						begin
							if(cnt==T1s-1'b1)
								begin
									cnt<=26'd0;
								end
							else
								begin
									cnt<=cnt+1'b1;
								end
						end
				end
		end
	
	wire	flag;
	assign	flag=(cnt==T1s-1'b1)?1'b1:1'b0;
	//----------------------秒的低位
	always@(posedge	clk,negedge	rst_n)
		begin
			if(!rst_n)
			begin
				data[3:0]<=4'd0;
				miao_l<=4'd0;
			end
			else
				begin
					if(miao_l==4'd10)
						miao_l<=4'd0;
					else
						begin
							if(flag||(key[2]==1'b0))
								miao_l<=miao_l+1'b1;
							else
								data[3:0]<=miao_l;
						end
				end
		end
	//----------------------秒的高位
	always@(posedge	clk,negedge	rst_n)
		begin
			if(!rst_n)
				begin
					data[7:4]<=4'd0;
					miao_h<=4'd0;
				end
			else
				begin
					if(miao_h==4'd6)
						miao_h<=4'd0;
					else
						begin
							if(miao_l==4'd10)
								miao_h<=miao_h+1'b1;
							else
								data[7:4]<=miao_h;
						end
				end
		end
	//-------------------------分的低位
	always@(posedge	clk,negedge	rst_n)
		begin
			if(!rst_n)
				begin
					data[11:8]<=4'd0;
					fen_l<=4'd0;
				end
			else
				begin
					if(fen_l==4'd10)
						fen_l<=4'd0;
					else
						begin
							if(miao_h==4'd6||key[3]==1'b0)
								fen_l<=fen_l+1'b1;
							else
								data[11:8]<=fen_l;
						end
				end
		end
	//-----------------------------分的高位	
	always@(posedge	clk,negedge	rst_n)
		begin
			if(!rst_n)
				begin
					data[15:12]<=4'd0;
					fen_h<=4'd0;
				end
			else
				begin
					if(fen_h==4'd6)
						fen_h<=4'd0;
					else
						begin
							if(fen_l==4'd10)
								fen_h<=fen_h+1'b1;
							else
								data[15:12]<=fen_h;
						end
				end
		end
	//---------------------时的低位
	always@(posedge	clk,negedge	rst_n)
		begin
			if(!rst_n)
				begin
					data[19:16]<=4'd0;
					shi_l<=4'd0;
				end
			else
				begin
					if((shi_h==1'b0||shi_h==1'b1)&&shi_l==10||(shi_h==2'd2&&shi_l==3'd4))
						shi_l<=4'd0;
					else
						begin
							if(fen_h==4'd6||key[1]==1'b0)
								shi_l<=shi_l+1'b1;
							else
								data[19:16]<=shi_l;
						end
				end
		end
	//**********时的高位
	always@(posedge	clk,negedge	rst_n)
		begin
			if(!rst_n)
				begin
					data[23:20]<=4'd0;
					shi_h<=4'd0;
				end
			else
				begin
					if(shi_h==2'd2&&shi_l==3'd4)
						shi_h<=4'd0;
					else
						if((shi_h==1'b0||shi_h==1'b1)&&shi_l==10||(shi_h==2'd2&&shi_l==3'd4))
							shi_h<=shi_h+1'b1;
						else
							data[23:20]<=shi_h;
				end
		end
	
endmodule
