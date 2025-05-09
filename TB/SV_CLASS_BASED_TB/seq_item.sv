class sequence_item;

	rand logic rst;
	rand logic wr_en;
	rand logic rd_en;
	rand logic data_in;

	//constraints

	constraint data_range {data_in inside{[1:5]};}

endclass
