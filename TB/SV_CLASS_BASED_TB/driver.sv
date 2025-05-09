class driver;

	mailbox gen2driv;
	virtual intf driver_intf;
	sequence_item pkt;

	function new(mailbox mbx, virtual intf driver_intf);
		gen2driv=mbx;
		this.driver_intf=driver_intf;
	endfunction


	task reset();
		@(negedge driver_intf.clk);		
	endtask

	task drive();
		pkt=new();
		gen2driv.get(pkt);
		forever begin
		@(negedge driver_intf.clk)
		//write drive logic
		if(pkt.wr_en && !driver_intf.full)begin
		driver_intf.rst<=pkt.rst;
		driver_intf.wr_en<=pkt.wr_en;
		driver_intf.data_in<=pkt.data_in;
		end
		//read drive logic
		if(pkt.rd_en && !driver_intf.empty)begin
		driver_intf.rst<=pkt.rst;
		driver_intf.rd_en<=pkt.rd_en;
		end
		@(negedge driver_intf.clk);
		end		
	endtask

endclass
