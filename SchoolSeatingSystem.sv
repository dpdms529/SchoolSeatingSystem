module SchoolSeatingSystem(input logic clk,
                           input logic [31:0] Student_No,
                           input logic [4:0] Seat_No,
                           input logic write,
                           output logic [10:0] time_out,
                           input logic [1:0] Seat_State);

   logic [10:0] setted_reset_time, setted_limit_time, Time;
   logic rst_temp, Do_Not_Seat_sig;
   
   assign time_out = Time;
   
   set_up S0(setted_reset_time, setted_limit_time);
   TIMER T0(clk, setted_reset_time, rst_temp, Time);
   mem1 M1(clk, write, Student_No, Seat_No);
   mem2 M2(clk, rst_temp, write, Time, Seat_State, Seat_No, setted_limit_time, Do_Not_Seat_sig);
   
   
endmodule
