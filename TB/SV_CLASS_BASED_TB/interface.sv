interface fifo_intf #(FIFO_DEPTH=8, DATA_WIDTH=4) (input clk);

	logic rst;
	logic wr_en;
	logic rd_en;
	logic [DATA_WIDTH-1:0] data_in;
	logic almost_empty;
	logic almost_full;
	logic empty;
	logic full;
	logic [DATA_WIDTH-1:0]	data_out;


endinterface
