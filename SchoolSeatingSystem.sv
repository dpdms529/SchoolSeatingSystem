module SchoolSeatingSystem(input logic clk,
                           input logic [31:0] Student_No,
                           input logic [4:0] Seat_No,
                           input logic write,
                           output logic [10:0] time_out,
                           input logic [1:0] Seat_State,
									input logic [1:0] write_set,
									input logic [10:0] limit_time,
									input logic [1:0] ban);

   logic [10:0] setted_reset_time = 1440, Time;
   logic rst_temp;
   
   assign time_out = Time;

   TIMER T0(clk, setted_reset_time, rst_temp, Time);
   MEMORY M0(rst_temp, write, Student_No, Time, Seat_State, Seat_No, write_set, limit_time, ban);
	
   
endmodule
