/*
 * ECE385-HelperTools/PNG-To-Txt
 * Author: Rishi Thakkar
 *
 */
//musice RAM
module  frameRAM
(
		input [8:0] read_address,
		input Clk,

		output logic [15:0] data_Out
);

// mem has width of 3 bits and a total of 400 addresses
logic [15:0] mem [0:399];

initial
begin
	 $readmemh("music_space.txt", mem);
end


always_ff @ (posedge Clk) begin
//	if (we)
//		mem[write_address] <= data_In;
	data_Out<= mem[read_address];
end

endmodule

//RAM of idle character
module  IdleRAM
(
		input [18:0] read_address,
		input Clk,

		output logic [5:0] data_Out
);

// mem has width of 3 bits and a total of 400 addresses
logic [5:0] mem [0:2267];

initial
begin
	 $readmemh("Idle.txt", mem);
end


always_ff @ (posedge Clk) begin
	data_Out<= mem[read_address];
end

endmodule

//RAM of walking character
module  WalkingRAM
(
		input [18:0] read_address,
		input Clk,

		output logic [5:0] data_Out
);


logic [5:0] mem [0:2624];

initial
begin
	 $readmemh("Walking.txt", mem);
end


always_ff @ (posedge Clk) begin
	data_Out<= mem[read_address];
end

endmodule


//RAM of ground
module  GroundRAM
(
		input [18:0] read_address,
		input Clk,
		output logic [5:0] data_Out
);

logic [5:0] mem [0:399];

initial
begin
	 $readmemh("Ground.txt", mem);
end


always_ff @ (posedge Clk) begin
	data_Out<= mem[read_address];
end

endmodule

//RAM of ground
module  MapEndRAM
(
		input [18:0] read_address,
		input Clk,
		output logic [5:0] data_Out
);

logic [5:0] mem [0:1223];

initial
begin
	 $readmemh("MapEnd.txt", mem);
end


always_ff @ (posedge Clk) begin
	data_Out<= mem[read_address];
end

endmodule

//RAM of spikes
module  SpikeRAM
(
		input [18:0] read_address,
		input Clk,

		output logic [5:0] data_Out
);

// mem has width of 3 bits and a total of 400 addresses
logic [5:0] mem [0:399];

initial
begin
	 $readmemh("Spike.txt", mem);
end


always_ff @ (posedge Clk) begin
	data_Out<= mem[read_address];
end

endmodule

//RAM of Gameover icon
module  GameoverRAM
(
		input [18:0] read_address,
		input Clk,

		output logic [5:0] data_Out
);

// mem has width of 3 bits and a total of 400 addresses
logic [5:0] mem [0:9791];

initial
begin
	 $readmemh("Gameover.txt", mem);
end

always_ff @ (posedge Clk) begin
	data_Out<= mem[read_address];
end

endmodule


//RAM of Win
module  WinRAM
(
		input [18:0] read_address,
		input Clk,

		output logic [5:0] data_Out
);

// mem has width of 3 bits and a total of 400 addresses
logic [5:0] mem [0:5339];

initial
begin
	 $readmemh("Win.txt", mem);
end


always_ff @ (posedge Clk) begin
	data_Out<= mem[read_address];
end

endmodule

//Apple ram
module  AppleRAM
(
		input [18:0] read_address,
		input Clk,

		output logic [5:0] data_Out
);

// mem has width of 3 bits and a total of 400 addresses
logic [5:0] mem [0:349];

initial
begin
	 $readmemh("Apple.txt", mem);
end


always_ff @ (posedge Clk) begin
	data_Out<= mem[read_address];
end

endmodule

//LifeCount ram
module  StatusRAM
(
		input [18:0] read_address,
		input Clk,

		output logic [5:0] data_Out
);

// mem has width of 3 bits and a total of 400 addresses
logic [5:0] mem [0:1847];

initial
begin
	 $readmemh("Status.txt", mem);
end


always_ff @ (posedge Clk) begin
	data_Out<= mem[read_address];
end

endmodule


//LifeCount ram
module  BossRAM
(
		input [18:0] read_address,
		input Clk,

		output logic [5:0] data_Out
);

// mem has width of 3 bits and a total of 400 addresses
logic [5:0] mem [0:2699];

initial
begin
	 $readmemh("fpga.txt", mem);
end


always_ff @ (posedge Clk) begin
	data_Out<= mem[read_address];
end

endmodule

//LifeCount ram
module  TitleRAM
(
		input [18:0] read_address,
		input Clk,

		output logic [5:0] data_Out
);

// mem has width of 3 bits and a total of 400 addresses
logic [5:0] mem [0:94446];

initial
begin
	 $readmemh("Title.txt", mem);
end


always_ff @ (posedge Clk) begin
	data_Out<= mem[read_address];
end

endmodule
