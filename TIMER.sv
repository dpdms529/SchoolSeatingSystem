module TIMER(input logic clk,
             input logic [10:0] reset_time,
             output logic rst_timer,
             output logic [10:0] time_out);

   logic [10:0] MIN_sig = -1;
	
   always_ff @(posedge clk)
		begin
			if (clk) 
				begin
					MIN_sig = MIN_sig + 1;
					if(reset_time === MIN_sig) begin
						MIN_sig <= 0;
						rst_timer <= 1;	//day end -> reset signal
						$strobe("[%2d:%2d] date changed",MIN_sig/60,MIN_sig%60);
					end
					else if(MIN_sig === 360)rst_timer <= 0;
				end
		end
   
   assign time_out = MIN_sig;
   
endmodule