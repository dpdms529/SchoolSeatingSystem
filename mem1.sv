module mem1(input logic write_mem1,
				input logic [31:0] Student_No_mem1,
				input logic [4:0] Seat_No_mem1);
				
	typedef logic [31:0] Student_Num_Table [0:31];
	Student_Num_Table RAM_DATA = '{ 32'b0, 32'b0, 32'b0, 32'b0, 32'b0, 
							32'b0, 32'b0, 32'b0, 32'b0, 32'b0,
							32'b0, 32'b0, 32'b0, 32'b0, 32'b0,
							32'b0, 32'b0, 32'b0, 32'b0, 32'b0,
							32'b0, 32'b0, 32'b0, 32'b0, 32'b0,
							32'b0, 32'b0, 32'b0, 32'b0, 32'b0,
							32'b0, 32'b0};
	
	always @(Student_No_mem1, Seat_No_mem1, write_mem1) begin
		if (write_mem1 === 1) begin
			RAM_DATA[Seat_No_mem1] <= Student_No_mem1;
		end
	end
	
endmodule
