class fifo_sequence; //#(sequence_item);

	sequence_item pkt;
	mailbox gen2driv;

	function new(mailbox mbx);
		gen2driv=mbx;
	endfunction

	function generate_pkt();
			for(int i=0; i<20;i++)begin
				pkt=new();
				if(i%2==0)begin
					assert (pkt.randomize() with {rd_en==1'b1};);
				end
				else begin
					assert (pkt.randomize() with {wr_en==1'b1};);
				end
				gen2driv.put(pkt);
			end
	endfunction	
	
endclass
