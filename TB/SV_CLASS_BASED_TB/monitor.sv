class monitor;

	mailbox mon2scb;
	virtual intf mon_intf;

	sequence_item pkt;

	function new(mailbox mon2scb, virtual intf mon_intf);
		this.mon2scb=mon2scb;
		this.mon_intf=mon_intf;
	endfunction

	task read_transaction;
		forever begin
			pkt=new();
			wait(mon_vif.rd_en||mon_vif.wr_en);
			@(posedge mon_vif.clk);
			//if(mon_vif.rd_en && !mon_vif.wr_en)begin  //I dont think i even need this if condition
				pkt.rd_en<=mon_vif.rd_en;
				pkt.wr_en<=mon_vif.wr_en;
				pkt.rst<=mon_vif.rst;
				pkt.data_in<=mon_vif.data_in;
			//end	
		end
	endtask

endclass
