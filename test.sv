module test();
	logic clk_tb = 0;
	logic write_tb = 0;
	logic [31:0] Student_No_tb = 32'b0;
	logic [4:0] Seat_No_tb = 5'b0;
	logic [1:0] Seat_State_tb = 2'b0;
	logic [10:0] Time = 11'b0;
	
	SchoolSeatingSystem C0(clk_tb, Student_No_tb, Seat_No_tb, write_tb, Time, Seat_State_tb);
	
	always #5 clk_tb <= ~clk_tb;
	
	initial begin
		
		#10; 
		write_tb <= 1;
		Student_No_tb <= 201819186;
		Seat_No_tb <= 1;
		Seat_State_tb <= 2;
		#5 write_tb <= 0;
		
		#20;
		write_tb <= 1;
		Student_No_tb <= 201912352;
		Seat_No_tb <= 2;
		Seat_State_tb <= 2;
		#5 write_tb <= 0;
		
		#10;
		write_tb <= 1;
		Student_No_tb <= 201912352;
		Seat_No_tb <= 2;
		Seat_State_tb <= 1;
		#5 write_tb <= 0;
		
		#20;
		write_tb <= 1;
		Student_No_tb <= 201918757;
		Seat_No_tb <= 5;
		Seat_State_tb <= 2;
		#5 write_tb <= 0;
		
		#10 
		write_tb <= 1;
		Student_No_tb <= 2019123179;
		Seat_No_tb <= 5'b00001; 
		Seat_State_tb <= 2;
		#5 write_tb <= 0;
		
		#60

		$stop;
	end	
		
	
endmodule
