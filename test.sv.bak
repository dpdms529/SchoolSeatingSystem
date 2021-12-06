module test();
	logic clk_tb = 1;
	logic write_tb = 0;
	logic [31:0] Student_No_tb = 0;
	logic [4:0] Seat_No_tb = 0;
	logic [1:0] Seat_State_tb = 0;
	logic [10:0] Time_tb = 0;
	logic [1:0] write_set_tb = 0;
	logic [10:0] limit_time_tb = 5;
	logic [1:0] ban_tb = 2;
	
	SchoolSeatingSystem C0(clk_tb, Student_No_tb, Seat_No_tb, write_tb, Time_tb, Seat_State_tb, write_set_tb, limit_time_tb, ban_tb);
	
	always #5 clk_tb <= ~clk_tb;
	
	initial begin
		
		#3610; 
		write_tb <= 1;
		Student_No_tb <= 201819186;
		Seat_No_tb <= 1;
		Seat_State_tb <= 2;
		#5 write_tb <= 0;
		
		#15;
		write_tb <= 1;
		Student_No_tb <= 201912352;
		Seat_No_tb <= 2;
		Seat_State_tb <= 2;
		#5 write_tb <= 0;
		
		#5;
		write_tb <= 1;
		Student_No_tb <= 201912352;
		Seat_No_tb <= 2;
		Seat_State_tb <= 1;
		#5 write_tb <= 0;
		
		#50
		
		#5;
		write_tb <= 1;
		Student_No_tb <= 201912352;
		Seat_No_tb <= 2;
		Seat_State_tb <= 2;
		#5 write_tb <= 0;
		
		#5;
		write_set_tb <= 1;
		ban_tb = 0;
		#5 write_set_tb <= 0;
		
		#5;
		write_set_tb <= 2;
		limit_time_tb = 15;
		#5;
		write_set_tb <= 0;
		
		#15;
		write_tb <= 1;
		Student_No_tb <= 201918757;
		Seat_No_tb <= 5;
		Seat_State_tb <= 2;
		#5 write_tb <= 0;
		
		#5;
		write_tb <= 1;
		Student_No_tb <= 201918757;
		Seat_No_tb <= 5;
		Seat_State_tb <= 2;
		#5 write_tb <= 0;
		
		#5;
		write_tb <= 1;
		Student_No_tb <= 201918757;
		Seat_No_tb <= 3;
		Seat_State_tb <= 2;
		#5 write_tb <= 0;
		
		#5;
		write_tb <= 1;
		Student_No_tb <= 201918757;
		Seat_No_tb <= 5;
		Seat_State_tb <= 1;
		#5 write_tb <= 0;
		
		#5; 
		write_tb <= 1;
		Student_No_tb <= 201912379;
		Seat_No_tb <= 1; 
		Seat_State_tb <= 2;
		#5 write_tb <= 0;
		
		#5; 
		write_tb <= 1;
		Student_No_tb <= 201912379;
		Seat_No_tb <= 4; 
		Seat_State_tb <= 2;
		#5 write_tb <= 0;
		
		#5; 
		write_tb <= 1;
		Student_No_tb <= 201912379;
		Seat_No_tb <= 7; 
		Seat_State_tb <= 2;
		#5 write_tb <= 0;
		
		#5; 
		write_tb <= 1;
		Student_No_tb <= 201819186;
		Seat_No_tb <= 1;
		Seat_State_tb <= 0;
		#5 write_tb <= 0;
		
		#10580;
		
		#5;
		write_set_tb <= 1;
		ban_tb = 1;
		#5 write_set_tb <= 0;
		
		#5;
		write_tb <= 1;
		Student_No_tb <= 201912379;
		Seat_No_tb <= 6; 
		Seat_State_tb <= 2;
		#5 write_tb <= 0;
		
		#3590;
	
		#5;
		write_tb <= 1;
		Student_No_tb <= 201912379;
		Seat_No_tb <= 6; 
		Seat_State_tb <= 2;
		#5 write_tb <= 0;
		
		#5;
		write_tb <= 1;
		Student_No_tb <= 201819186;
		Seat_No_tb <= 3; 
		Seat_State_tb <= 2;
		#5 write_tb <= 0;
		
		
		$stop;
	end	
		
	
endmodule
