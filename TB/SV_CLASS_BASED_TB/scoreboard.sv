class scoreboard;

	mailbox mon2scb;
	sequence_item pkt;
	logic [FIFO_WIDTH-1:0] refq[$:DEPTH-1];	

	int pass, fail;

	function new(mailbox mon2scb);
		this.mon2scb=mon2scb;
	endfunction

	task main;
		
		$display("SCOREBOARD MAIN TASK");


	endtask
	

endclass
