module TIMER(input logic clk,
             input logic [10:0] reset_time,
             output logic rst_timer,
             output logic [10:0] time_out);

   logic clk_cnt1 = 0; // 1'b0?
   logic [5:0] clk_cnt2 = 6'b0;
   logic [4:0] HOUR_sig = 5'b0;
   logic [5:0] MIN_sig = 6'b0;
   
   always_ff @(posedge clk)
		begin
			if (clk) 
				begin
					clk_cnt1 <= ~clk_cnt1;
					if (clk_cnt1 === 1)
						begin
							clk_cnt1 <= 0;
							clk_cnt2 <= clk_cnt2 + 1;
							MIN_sig <= MIN_sig + 1;
							if (MIN_sig === 6'b111100) MIN_sig <= 6'b000000;
						end
					else if (clk_cnt2 === 6'b111100)
						begin
							clk_cnt2 <= 6'b000000;
							HOUR_sig <= HOUR_sig + 1;
							if(HOUR_sig === 5'b11000) HOUR_sig <= 5'b00000;
						end
				end
		end
		
	always @(reset_time)
		begin
			$display("reset_time : %b",reset_time);
			$display("HOUR_sig : %b", HOUR_sig);
			$display("isSame : %b", reset_time === HOUR_sig);
			if(reset_time === HOUR_sig) rst_timer <= 1;
			else rst_timer <= 0;
		end
   
   assign time_out = {HOUR_sig [4:0], MIN_sig [5:0]};
   
endmodule