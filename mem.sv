module mem(input logic rst_mem,
				input logic write_mem,
				input logic [31:0] Student_No_mem,
				input logic [10:0] Time_mem,
				input logic [1:0] Seat_State_mem,
				input logic [4:0] Seat_No_mem,
				input logic [10:0] limit_time,
				output logic Do_Not_Seat);
				
	typedef logic [31:0] Student_Num_Table [0:31];
	Student_Num_Table RAM_DATA = '{ 32'b0, 32'b0, 32'b0, 32'b0, 32'b0, 
							32'b0, 32'b0, 32'b0, 32'b0, 32'b0,
							32'b0, 32'b0, 32'b0, 32'b0, 32'b0,
							32'b0, 32'b0, 32'b0, 32'b0, 32'b0,
							32'b0, 32'b0, 32'b0, 32'b0, 32'b0,
							32'b0, 32'b0, 32'b0, 32'b0, 32'b0,
							32'b0, 32'b0};
				
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
	logic [10:0] Time_temp = 0;
	
	always_comb begin
		for (int i=0; i<32; i++) begin
			Time_temp <= Time_mem-RAM_DATA1[i];
			if (RAM_DATA2[i] === 1 && Time_temp > limit_time) RAM_DATA2[i] <= 0;
		end
		
		if (RAM_DATA2[Seat_No_mem] === 2 && Seat_State_mem === 2) Do_Not_Seat = 1;
		else Do_Not_Seat = 0;
		
		if (rst_mem === 1) begin
			RAM_DATA <= '{ 32'b0, 32'b0, 32'b0, 32'b0, 32'b0, 
							32'b0, 32'b0, 32'b0, 32'b0, 32'b0,
							32'b0, 32'b0, 32'b0, 32'b0, 32'b0,
							32'b0, 32'b0, 32'b0, 32'b0, 32'b0,
							32'b0, 32'b0, 32'b0, 32'b0, 32'b0,
							32'b0, 32'b0, 32'b0, 32'b0, 32'b0,
							32'b0, 32'b0};
							
			RAM_DATA <= '{ 11'b0, 11'b0, 11'b0, 11'b0, 11'b0, 
								11'b0, 11'b0, 11'b0, 11'b0, 11'b0,
								11'b0, 11'b0, 11'b0, 11'b0, 11'b0,
								11'b0, 11'b0, 11'b0, 11'b0, 11'b0,
								11'b0, 11'b0, 11'b0, 11'b0, 11'b0,
								11'b0, 11'b0, 11'b0, 11'b0, 11'b0,
								11'b0, 11'b0};
		
			RAM_DATA2 <= '{ 2'b0, 2'b0, 2'b0, 2'b0, 2'b0, 
								2'b0, 2'b0, 2'b0, 2'b0, 2'b0,
								2'b0, 2'b0, 2'b0, 2'b0, 2'b0,
								2'b0, 2'b0, 2'b0, 2'b0, 2'b0,
								2'b0, 2'b0, 2'b0, 2'b0, 2'b0,
								2'b0, 2'b0, 2'b0, 2'b0, 2'b0,
								2'b0, 2'b0};
		end
		
		if (write_mem === 1 && Do_Not_Seat !== 1) begin
			RAM_DATA[Seat_No_mem] <= Student_No_mem;
			RAM_DATA1[Seat_No_mem] <= Time_mem;
			RAM_DATA2[Seat_No_mem] <= Seat_State_mem;
		end
			
	end
	
endmodule
