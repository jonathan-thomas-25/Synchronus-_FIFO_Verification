module top;

	intf vif;
	bit clk;
	environment env;

	always #5 clk = ~clk;

	vif(.clk(clk));
	
	

endmodule
