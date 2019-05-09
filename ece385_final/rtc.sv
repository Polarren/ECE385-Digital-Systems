module RTC ( input logic VGA_VS,Reset_h,
				 output logic rtc_clk
				);
		logic freq;
		int count;
		always_ff @ (posedge VGA_VS or posedge Reset_h)
		begin
		if (Reset_h) begin 
			freq <=  1'b0;
			count <= 0; end 
		else if (count < 2)
			count++;
		else begin 
			freq <= ~(freq);
			count <= 0;
	end end 
	assign rtc_clk = freq;
	
endmodule

module sec_clk ( input logic Clk,Reset_h,key_R,
				 output logic sec_clk
				);
		logic freq;
		int count;
		always_ff @ (posedge Clk)
		begin
		if (Reset_h| key_R) begin 
			freq <=  1'b0;
			count <= 0; end 
		else if (count < 8333333*3)
			count++;
		else begin 
			freq <= ~(freq);
			count <= 0;
	end end 
	assign sec_clk = freq;
	
endmodule

