module set_up(output logic [10:0] user_Reset_time,
         output logic [10:0] user_limit_time);
   assign user_reset_time = 11'b00000000000;
   assign user_limit_time = 11'b00001000000;
	
endmodule