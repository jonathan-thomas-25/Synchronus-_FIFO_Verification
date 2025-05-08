module tb #(FIFO_DEPTH=8, DATA_WIDTH=4);

	logic clk;
	logic rst;
	logic wr_en;
	logic rd_en;
	logic [DATA_WIDTH-1:0] data_in;
	logic almost_empty;
	logic almost_full;
	logic full;
	logic empty;
	logic [DATA_WIDTH-1:0] data_out;

	fifo dut1(.*);

	always #5 clk=~clk;


	`ifdef LEVEL1
	
	initial begin
		clk=1'b0;
		//Reset
		@(negedge clk) rst=1'b1;
		repeat(2) @(negedge clk);
		@(negedge clk) rst=1'b0;
		//Driving logic
		repeat(2) @(negedge clk);
		@(negedge clk) wr_en=1;
		repeat(5) begin
		@(negedge clk);
		$display("[%t][DISPLAY] data_out=%d, almost_full=%d, almost_empty=%d, full=%d, empty=%d",$time, data_out, almost_full, almost_empty, full, empty);
		end	
	end

	`endif


	`ifdef LEVEL2

	initial begin
		clk=1'b0;
		#10 rst=1'b1;
		#20 rst=1'b0;
		//$monitor("[%t][MONITOR] data_out=%d, almost_full=%d, almost_empty=%d, full=%d, empty=%d, wr_en=%d, rd_en=%d", $time, data_out, almost_full, almost_empty, full, empty, wr_en, rd_en);	
		for(int i=0; i<40; i++)begin
			@(negedge clk);
			if(i<20)begin
				if(i%2==0)begin
					wr_en=1'b1;
					data_in=i;
				end
				else begin
					wr_en=1'b0;
				end
			end
			if(i>20)begin
				if(i%2==0)begin
					rd_en=1'b1;
				end
				else begin
					rd_en=1'b0;
				end	
			end
		$display("[%t][DISPLAY] data_in=%d, data_out=%d, almost_full=%d, almost_empty=%d, full=%d, empty=%d, wr_en=%b, rd_en=%b",$time,data_in, data_out, almost_full, almost_empty, full, empty,wr_en, rd_en);
		end
		$finish;
	end

	`endif
	
endmodule
