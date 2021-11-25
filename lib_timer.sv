module lib_timer(input logic clk,
                  input logic [10:0] reset_time,
                  output logic rst_timer,
                  output logic [10:0] time_out);
   logic clk_cnt1 = 0; // 1'b0?
   logic [5:0] clk_cnt2 = 6'bb000000;
   logic [4:0] HOUR_sig = 5'b00000;
   logic [5:0] MIN_sig = 6'b000000;
   
   always @(posedge clk)
      begin
         if (clk) clk_cnt1 <= ~clk_cnt1;
         if (clk_cnt1 == 1)
            begin
               clk_cnt1 <= 0;
               clk_cnt2 <= clk_cnt2 + 1;
               MIN_sig <= MIN_sig + 1;
               if (MIN_sig == 6'b111100)
                  MIN_sig <= 6'b000000;
               end
         else if (clk_cnt2 == 6'b111100)
            begin
               clk_cnt2 <= 6'b000000;
               HOUR_sig <= HOUR_sig + 1;
               if(HOUR_sig == 5'b11000) HOUR_sig <= 5'b00000;
            end
      end
   
   always @(reset_time)
      begin
         if(reset_time == HOUR_sig) rst_timer <= 1;
         else rst_timer <= 0;
      end
   
   assign time_out = HOUR_sig  [4:0] & MIN_sig [5:0];
   
endmodule