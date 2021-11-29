module TIMER(input logic clk,
             input logic [10:0] reset_time,
             output logic rst_timer,
             output logic [10:0] time_out);

   logic [4:0] HOUR_sig = 0;
   logic [5:0] MIN_sig = -1;
   
   always_ff @(posedge clk)
		begin
			if (clk) 
				begin
					MIN_sig <= MIN_sig + 1;
					if (MIN_sig === 60) 
						begin
							MIN_sig <= 0;
							HOUR_sig <= HOUR_sig + 1;
							if(HOUR_sig === 24) HOUR_sig <= 0;
						end
				end
		end
		
	always @(reset_time)
		begin
			if(reset_time === HOUR_sig) rst_timer <= 1;	//day end -> reset signal
			else rst_timer <= 0;
		end
   
   assign time_out = {HOUR_sig [4:0], MIN_sig [5:0]};
   
endmodule