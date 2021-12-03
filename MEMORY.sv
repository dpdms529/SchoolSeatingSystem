module MEMORY(input logic rst_mem,
				input logic write_mem,
				input logic [31:0] Student_No_mem,
				input logic [10:0] Time_mem,
				input logic [1:0] Seat_State_mem,
				input logic [4:0] Seat_No_mem,
				input logic [1:0] write_set_mem,
				input logic [10:0] limit_time_mem,
				input logic [1:0] ban_mem);
				
	logic [31:0] Student_Num_Table [0:31] = '{0, 0, 0, 0, 0, 
															0, 0, 0, 0, 0,
															0, 0, 0, 0, 0,
															0, 0, 0, 0, 0,
															0, 0, 0, 0, 0,
															0, 0, 0, 0, 0,
															0, 0};
				
	logic [10:0] Time_Table [0:31] = '{	0, 0, 0, 0, 0, 
													0, 0, 0, 0, 0,
													0, 0, 0, 0, 0,
													0, 0, 0, 0, 0,
													0, 0, 0, 0, 0,
													0, 0, 0, 0, 0,
													0, 0};
													
	logic [1:0] Seat_State_Table [0:31] = '{0, 0, 0, 0, 0, 
														0, 0, 0, 0, 0,
														0, 0, 0, 0, 0,
														0, 0, 0, 0, 0,
														0, 0, 0, 0, 0,
														0, 0, 0, 0, 0,
														0, 0};
	
	
	logic [10:0] Time_temp = 0;
			
	always_comb begin
		if(write_set_mem === 1 && ban_mem !== 2) begin
			$strobe("[%d]manager set banned state -> %d", Time_mem, ban_mem);
			for(int i = 0;i<32;i++) begin
				if(i%2 === ban_mem) begin 
					Seat_State_Table[i] <= 3;
					Student_Num_Table[i] <= 0;
					Time_Table[i] <= 0;
				end
			end
		end
		else if(write_set_mem === 1) begin
			$strobe("[%d]manager set banned state -> %d", Time_mem, ban_mem);
			for(int i = 0;i<32;i++) begin
				if(Seat_State_Table[i] === 3) begin 
					Seat_State_Table[i] <= 0;
				end
			end			
		end
		if(write_set_mem === 2) $strobe("[%d]manager set limit_time -> %d", Time_mem, limit_time_mem);			
	
		for (int i=0; i<32; i++) begin
			Time_temp = Time_mem - Time_Table[i];
			if (Seat_State_Table[i] === 1 && Time_temp >= limit_time_mem) begin
				$strobe("[%d]%d : seat[%d] returned", Time_mem,Student_Num_Table[i], i);
				Student_Num_Table[i] <= 0;
				Time_Table[i] <= 0;
				Seat_State_Table[i] <= 0;
			end
		end
		
		if (rst_mem === 1) begin
			Student_Num_Table <= '{ 0, 0, 0, 0, 0, 
											0, 0, 0, 0, 0,
											0, 0, 0, 0, 0,
											0, 0, 0, 0, 0,
											0, 0, 0, 0, 0,
											0, 0, 0, 0, 0,
											0, 0};
							
			Time_Table <= '{0, 0, 0, 0, 0, 
								0, 0, 0, 0, 0,
								0, 0, 0, 0, 0,
								0, 0, 0, 0, 0,
								0, 0, 0, 0, 0,
								0, 0, 0, 0, 0,
								0, 0};
		
			if(ban_mem !== 2) begin
				for(int i = 0;i<32;i++) begin
					if(i%2 === ban_mem) Seat_State_Table[i] <= 3;
					else Seat_State_Table[i] <= 0;
				end
			end
								
		end
		
		if (write_mem === 1 && Seat_State_mem !== Seat_State_Table[Seat_No_mem] && ((Student_Num_Table[Seat_No_mem] === Student_No_mem) || Student_Num_Table[Seat_No_mem] === 0)) begin : writeBlock
			if(Seat_State_Table[Seat_No_mem] === 3) begin
				$strobe("[%d]%d : manager banned this seat[%d]", Time_mem, Student_No_mem, Seat_No_mem);
				disable writeBlock;
			end
			for(int i = 0;i<32;i++)begin
				if(Student_Num_Table[i] === Student_No_mem && i !== Seat_No_mem) begin
					$strobe("[%d]%d : can't access other seat[%d]", Time_mem, Student_No_mem, Seat_No_mem);
					disable writeBlock;
				end
			end
			if(Seat_State_mem === 0)begin
				Student_Num_Table[Seat_No_mem] <= 0;
				Time_Table[Seat_No_mem] <= 0;
				Seat_State_Table[Seat_No_mem] <= 0;
				$strobe("[%d]%d : checked out seat[%d]", Time_mem, Student_No_mem, Seat_No_mem);
			end
			else if(!(Seat_State_mem === 1 && Seat_State_Table[Seat_No_mem] === 0)) begin
				Student_Num_Table[Seat_No_mem] <= Student_No_mem;
				Time_Table[Seat_No_mem] <= Time_mem;
				Seat_State_Table[Seat_No_mem] <= Seat_State_mem;
				$strobe("[%d]%d : seat[%d] state changed (%d)", Time_mem, Student_No_mem,Seat_No_mem,Seat_State_mem);
			end
		end
		else if(write_mem ===1) $strobe("[%d]%d : access denied seat[%d]", Time_mem, Student_No_mem, Seat_No_mem);
			
	end
	
endmodule
