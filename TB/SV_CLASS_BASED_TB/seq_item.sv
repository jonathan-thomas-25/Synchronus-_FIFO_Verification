class sequence_item;

	rand logic rst;
	rand logic wr_en;
	rand logic rd_en;
	rand logic [DATA_WIDTH-1:0] data_in;
	logic [DATA_WIDTH-1:0] data_out;
        logic almost_full;
	logic full;
	logic almost_empty;
	logic empty;	

	//constraints

	constraint data_range {data_in inside{[1:5]};}

endclass
