module fifo #(FIFO_DEPTH=8, DATA_WIDTH=4)(

	input clk,
	input rst,
	input wr_en,
	input rd_en,
	input [DATA_WIDTH-1:0] data_in,
	output logic almost_full,
	output logic almost_empty,
	output logic full,
	output logic empty,
	output logic [DATA_WIDTH-1:0] data_out 
	
);

logic [$clog2(FIFO_DEPTH)-1:0] wr_ptr, rd_ptr;
logic [$clog2(FIFO_DEPTH)-1:0] count;

logic [DATA_WIDTH-1:0] fifo_mem[FIFO_DEPTH];

always @(posedge clk)begin
	if(rst)begin
		data_out<='0;
		wr_ptr<='0;
		rd_ptr<='0;
		count<='0;	
	end
	else begin

		if(wr_en && !full)begin
		       	fifo_mem[wr_ptr]<=data_in;
			count<=count+1;
			wr_ptr<=wr_ptr+1;
		end
		else if(rd_en && !empty)begin
		       	data_out<=fifo_mem[rd_ptr];
			rd_ptr<=rd_ptr+1;
			count<=count-1;
		end
		else begin
			count<=count;
		end

	end	
end
	
//logic for full and empty signals
always_comb begin

	{full,almost_full, empty, almost_empty}='0;
	if(count==(FIFO_DEPTH-4)) almost_full=1'b1;
	if(count==4) almost_empty=1'b1;
	if(count==FIFO_DEPTH-1) full=1'b1;
	if(count==0) empty=1'b1;

end


endmodule
