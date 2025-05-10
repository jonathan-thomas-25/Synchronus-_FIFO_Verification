class environment;

	driver drv;
	monitor mon;
	fifo_sequence seq;
	scoreboard scb;

	mailbox gen2driv, mon2scb;
	virtual intf vif;

	function new();
		drv=new(gen2driv, vif);
		mon=new(mon2scb, vif);
		seq=new(gen2driv);
		scb=new(mon2scb);
	endfunction

	task main;

		$display("Inside main task of scoreboard");
				
	endtask	

	task do_stuff;
		drv.reset_fifo();
		fork 
			drv.drive();
			seq.generate_pkt();
			mon.read_transaction();
			scb.main();
		join_any
		$finish;
	endtask

endclass
