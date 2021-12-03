module mem(input logic rst_mem,
				input logic write_mem,
				input logic [31:0] Student_No_mem,
				input logic [10:0] Time_mem,
				input logic [1:0] Seat_State_mem,
				input logic [4:0] Seat_No_mem,
				input logic [10:0] limit_time);
				
	logic [31:0] Student_Num_Table [0:31] = '{32'b0, 32'b0, 32'b0, 32'b0, 32'b0, 
															32'b0, 32'b0, 32'b0, 32'b0, 32'b0,
															32'b0, 32'b0, 32'b0, 32'b0, 32'b0,
															32'b0, 32'b0, 32'b0, 32'b0, 32'b0,
															32'b0, 32'b0, 32'b0, 32'b0, 32'b0,
															32'b0, 32'b0, 32'b0, 32'b0, 32'b0,
															32'b0, 32'b0};
				
	logic [10:0] Time_Table [0:31] = '{ 11'b0, 11'b0, 11'b0, 11'b0, 11'b0, 
													11'b0, 11'b0, 11'b0, 11'b0, 11'b0,
													11'b0, 11'b0, 11'b0, 11'b0, 11'b0,
													11'b0, 11'b0, 11'b0, 11'b0, 11'b0,
													11'b0, 11'b0, 11'b0, 11'b0, 11'b0,
													11'b0, 11'b0, 11'b0, 11'b0, 11'b0,
													11'b0, 11'b0};

	logic [1:0] Seat_State_Table [0:31] = '{2'b0, 2'b0, 2'b0, 2'b0, 2'b0, 
														2'b0, 2'b0, 2'b0, 2'b0, 2'b0,
														2'b0, 2'b0, 2'b0, 2'b0, 2'b0,
														2'b0, 2'b0, 2'b0, 2'b0, 2'b0,
														2'b0, 2'b0, 2'b0, 2'b0, 2'b0,
														2'b0, 2'b0, 2'b0, 2'b0, 2'b0,
														2'b0, 2'b0};
											
											
	logic [10:0] Time_temp = 0;
	
	always_comb begin
		
		for (int i=0; i<32; i++) begin
			Time_temp = Time_mem - Time_Table[i];
			if (Seat_State_Table[i] === 1 && Time_temp > limit_time) begin
				$strobe("[%d]%d : seat[%d] returned", Time_mem,Student_Num_Table[i], i);
				Student_Num_Table[i] <= 0;
				Time_Table[i] <= 0;
				Seat_State_Table[i] <= 0;
			end
		end
		
		
		if (rst_mem === 1) begin
			Student_Num_Table <= '{ 32'b0, 32'b0, 32'b0, 32'b0, 32'b0, 
											32'b0, 32'b0, 32'b0, 32'b0, 32'b0,
											32'b0, 32'b0, 32'b0, 32'b0, 32'b0,
											32'b0, 32'b0, 32'b0, 32'b0, 32'b0,
											32'b0, 32'b0, 32'b0, 32'b0, 32'b0,
											32'b0, 32'b0, 32'b0, 32'b0, 32'b0,
											32'b0, 32'b0};
							
			Time_Table <= '{11'b0, 11'b0, 11'b0, 11'b0, 11'b0, 
								11'b0, 11'b0, 11'b0, 11'b0, 11'b0,
								11'b0, 11'b0, 11'b0, 11'b0, 11'b0,
								11'b0, 11'b0, 11'b0, 11'b0, 11'b0,
								11'b0, 11'b0, 11'b0, 11'b0, 11'b0,
								11'b0, 11'b0, 11'b0, 11'b0, 11'b0,
								11'b0, 11'b0};
		
			Seat_State_Table <= '{2'b0, 2'b0, 2'b0, 2'b0, 2'b0, 
										2'b0, 2'b0, 2'b0, 2'b0, 2'b0,
										2'b0, 2'b0, 2'b0, 2'b0, 2'b0,
										2'b0, 2'b0, 2'b0, 2'b0, 2'b0,
										2'b0, 2'b0, 2'b0, 2'b0, 2'b0,
										2'b0, 2'b0, 2'b0, 2'b0, 2'b0,
										2'b0, 2'b0};
								
		end
		
		if (write_mem === 1 && Seat_State_mem !== Seat_State_Table[Seat_No_mem] && ((Student_Num_Table[Seat_No_mem] === Student_No_mem) || Student_Num_Table[Seat_No_mem] === 0)) begin : writeBlock
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
