module TIMER(input logic clk,
             input logic [10:0] reset_time,
             output logic rst_timer,
             output logic [10:0] time_out);

   logic [10:0] MIN_sig = 0;
   
   always_ff @(posedge clk)
		begin
			if (clk) 
				begin
					MIN_sig <= MIN_sig + 1;
					if(reset_time === MIN_sig) begin
						MIN_sig <= 0;
						rst_timer <= 1;	//day end -> reset signal
					end
					else rst_timer <= 0;
				end
		end
		
//	always @(MIN_sig)
//		begin
//			if(reset_time === MIN_sig) begin
//				MIN_sig <= 0;
//				rst_timer <= 1;	//day end -> reset signal
//			end
//			else rst_timer <= 0;
//		end
   
   assign time_out = MIN_sig;
   
endmodule