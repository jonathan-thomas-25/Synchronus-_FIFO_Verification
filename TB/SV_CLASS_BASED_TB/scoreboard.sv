class scoreboard;

	mailbox mon2scb;
	sequence_item pkt, pkt1;
	logic [FIFO_WIDTH-1:0] refq[$:DEPTH-1];	


	bit empty, full, almost_empty, almost_full;
	bit data_validity, fifo_condition_validity;
	bit pass, fail;
	int tx_count;


	function new(mailbox mon2scb);
		this.mon2scb=mon2scb;
	endfunction

	task main;
		
		$display("SCOREBOARD MAIN TASK");


		forever begin
			tx_count=tx_count+1;
			pkt=new();
			pkt1=new();
			mon2scb.get(pkt);

			if(!pkt.rd_en && pkt.wr_en)begin
				refq.push_back(pkt);
			end	

			else if (pkt.rd_en && !pkt.wr_en)begin
				refq.pop_front(pkt1);
				if(pkt1.data_out==pkt.data_out)begin
					data_validity=1'b1;
				else 
					data_validity = 1'b0;
				end
			end

			else if (pkt.rd_en && pkt.wr_en)begin
				refq.size()==refq.size();	
			end

			//full,empty logic

			if(refq.size()==0)begin
				empty=1'b1;
			end

			else if(refq.size()==2)begin
				almost_empty=1'b1;
			end

			else if(refq.size()==DEPTH-1)begin
				full=1'b1;
			end

			else if(refq.size()==DEPTH-3)begin
				almost_full=1'b1;
			end

			else begin
				{full,almost_full, almost_empty,empty}='0;
			end
			
			if(pkt.empty==empty && pkt.almost_empty==almost_empty && pkt.full==full && pkt.almost_full==almost_full)
				fifo_condition_validity=1'b1;
			else
				fifo_condition_validity=1'b0;

			if(fifo_condition_validity && data_validity)begin
				$display("[SCOREBOARD PASS] - transaction number - %d",tx_count);
			end
			else begin
				$display("[SCOREBOARD FAIL] - transaction number - %d",tx_count);
			end


		end

	endtask
	

endclass
