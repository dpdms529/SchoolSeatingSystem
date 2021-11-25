module mem1(input logic clk_mem1,
				input logic write_mem1,
				input logic [24:0] Student_No_mem1,
				input logic [7:0] Seat_No_mem1);
				
	typedef logic [24:0] Student_Num_Table [0:31];
	Student_Num_Table RAM_DATA = '{ 24'b0, 24'b0, 24'b0, 24'b0, 24'b0, 
							24'b0, 24'b0, 24'b0, 24'b0, 24'b0,
							24'b0, 24'b0, 24'b0, 24'b0, 24'b0,
							24'b0, 24'b0, 24'b0, 24'b0, 24'b0,
							24'b0, 24'b0, 24'b0, 24'b0, 24'b0,
							24'b0, 24'b0, 24'b0, 24'b0, 24'b0,
							24'b0, 24'b0};
	
	always_ff @(Student_No_mem1 or Seat_No_mem1 or write_mem1) begin
		if (write_mem1 === 1) begin
			RAM_DATA[Seat_No_mem1] <= Student_No_mem1;	// 입력받은 자리에 학번을 할당
		end
	end
	
endmodule
