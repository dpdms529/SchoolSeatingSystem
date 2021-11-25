module test();
	logic clk_tb = 0;
	logic write_tb = 0;
	logic [24:0] Student_No_tb = 25'b0;
	logic [4:0] Seat_No_tb = 5'b0;
	logic [1:0] Seat_State_tb = 2'b0;
	logic [10:0] Time = 11'b0;
	
	SchoolSeatingSystem C0(clk_tb, Student_No_tb, Seat_No_tb, write_tb, Time, Seat_State_tb);
	
	initial begin
		clk_tb <= ~clk_tb; #5;
		write_tb <= 1; #40;
		Student_No_tb <= 25'b1111111111111111111111111; #50;
		Student_No_tb <= 25'b1111011000001000011110011; #80;
		Student_No_tb <= 25'b1111001111100111111001111; #110;
		Student_No_tb <= 25'b1111111111111111111111111; #120;
		
		Seat_No_tb <= 5'b00001; #50;
		Seat_No_tb <= 5'b00010; #80;
		Seat_No_tb <= 5'b00101; #110;
		Seat_No_tb <= 5'b00001; #120;
		
		Seat_State_tb <= 2'b11; #50;
		Seat_State_tb <= 2'b11; #80;
		Seat_State_tb <= 2'b11; #110;
		Seat_State_tb <= 2'b01; #120;
	end
	
endmodule
