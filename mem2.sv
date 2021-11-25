module mem2(input logic clk_mem2,
				input logic rst_mem2,
				input logic write_mem2,
				input logic [10:0] Time_mem2,
				input logic [1:0] Seat_State_mem2,
				input logic [7:0] Seat_No_mem2,
				input logic [10:0] limit_time,
				output logic Do_Not_Seat);
				
	typedef logic [10:0] Time_Table [0:31];
	Time_Table RAM_DATA1 = '{ 11'b0, 11'b0, 11'b0, 11'b0, 11'b0, 
									11'b0, 11'b0, 11'b0, 11'b0, 11'b0,
									11'b0, 11'b0, 11'b0, 11'b0, 11'b0,
									11'b0, 11'b0, 11'b0, 11'b0, 11'b0,
									11'b0, 11'b0, 11'b0, 11'b0, 11'b0,
									11'b0, 11'b0, 11'b0, 11'b0, 11'b0,
									11'b0, 11'b0};
	typedef logic [1:0] Seat_State_Table [0:31];
	Seat_State_Table RAM_DATA2 = '{ 2'b0, 2'b0, 2'b0, 2'b0, 2'b0, 
											2'b0, 2'b0, 2'b0, 2'b0, 2'b0,
											2'b0, 2'b0, 2'b0, 2'b0, 2'b0,
											2'b0, 2'b0, 2'b0, 2'b0, 2'b0,
											2'b0, 2'b0, 2'b0, 2'b0, 2'b0,
											2'b0, 2'b0, 2'b0, 2'b0, 2'b0,
											2'b0, 2'b0};
	logic [10:0] Time_temp;
	
	always_ff @(Time_mem2 or Seat_No_mem2 or write_mem2 or rst_mem2 or Seat_State_mem2, limit_time) begin
		for (int i=0; i<32; i++) begin
			Time_temp <= RAM_DATA1[i] - Time_mem2;
			if (Time_temp > limit_time && RAM_DATA2[i] === 1) begin
				RAM_DATA2[i] <= 0;
			end
		end
		
		if (RAM_DATA2[Seat_No_mem2] === 3 && Seat_State_mem2 === 3) begin
			Do_Not_Seat <= 1;
		end
		
		if (rst_mem2 === 1) begin
			RAM_DATA2 <= '{ 2'b0, 2'b0, 2'b0, 2'b0, 2'b0, 
								2'b0, 2'b0, 2'b0, 2'b0, 2'b0,
								2'b0, 2'b0, 2'b0, 2'b0, 2'b0,
								2'b0, 2'b0, 2'b0, 2'b0, 2'b0,
								2'b0, 2'b0, 2'b0, 2'b0, 2'b0,
								2'b0, 2'b0, 2'b0, 2'b0, 2'b0,
								2'b0, 2'b0};
		end
		
		if (write_mem2 === 1) begin
			RAM_DATA1[Seat_No_mem2] <= Time_mem2;
			RAM_DATA2[Seat_No_mem2] <= Seat_State_mem2;
		end
			
	end
	
endmodule
