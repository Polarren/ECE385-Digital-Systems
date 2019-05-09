module apple_shooter(input  Clk,                // 50 MHz clock
                            Reset,              // Active-high reset signal
                            frame_clk,
							rtc_clk, 
							key_R,
              input  [8:0]  boss_counter,      
              input  [9:0]   DrawX, DrawY, Ball_X_Pos, Ball_Y_Pos,boss_X_Pos, boss_Y_Pos,
			  output [9:0] boss_bullet_X_Addr, boss_bullet_Y_Addr,
              output logic  is_boss_bullet            
);
	
  parameter [9:0] boss_bullet_X_Init = 10'd600;  // Center position on the X axis
  parameter [9:0] boss_bullet_Y_Init = 10'd40;  // Center position on the Y axis
  parameter [9:0] boss_bullet_X_Min = 10'd0;       // Leftmost point on the X axis
  parameter [9:0] boss_bullet_X_Max = 10'd639;     // Rightmost point on the X axis
  parameter [9:0] boss_bullet_X_Step = 10'd6;      // Step size on the X axis
  parameter [9:0] boss_bullet_X_Size = 12;        // boss_bullet size
  parameter [9:0] boss_bullet_Y_Size = 14;        // boss_bullet size

	logic [9:0] boss_bullet_X_Pos,boss_bullet_X_Pos_in, boss_bullet_X_Motion_in, boss_bullet_X_Motion,
                boss_bullet_Y_Pos,boss_bullet_Y_Pos_in, boss_bullet_Y_Motion_in, boss_bullet_Y_Motion;
	logic boundary,direct_out,direct_in;		  
	logic frame_clk_delayed, frame_clk_rising_edge;
    logic rtc_clk_delayed, rtc_clk_rising_edge;
    always_ff @ (posedge Clk) begin
        rtc_clk_delayed <= rtc_clk;
        rtc_clk_rising_edge <= (rtc_clk == 1'b1) && (rtc_clk_delayed == 1'b0);
        frame_clk_delayed <= frame_clk;
        frame_clk_rising_edge <= (frame_clk == 1'b1) && (frame_clk_delayed == 1'b0);
    end
	
  always_ff @ (posedge Clk)
  begin
      if (Reset||key_R)
      begin
			State <= sil;
            boss_bullet_X_Pos <= boss_bullet_X_Init;
            boss_bullet_X_Motion <= 10'd0;
            boss_bullet_Y_Motion <= 10'd0;
			boss_bullet_Y_Pos <= boss_bullet_Y_Init;
			direct_in <= 1;
      end
      else
      begin
			State <= Next_state;
            boss_bullet_X_Pos <= boss_bullet_X_Pos_in;
            boss_bullet_X_Motion <= boss_bullet_X_Motion_in;
            boss_bullet_Y_Motion <= boss_bullet_Y_Motion_in;
			direct_in <= direct_out;
			boss_bullet_Y_Pos <= boss_bullet_Y_Pos_in;
      end
  end

    enum logic [2:0] {  sil, shooting,shoot_p}  State, Next_state;
	always_comb
	begin 
		// Default next state is staying at current state
		Next_state = State;
		boss_bullet_Y_Pos_in = boss_bullet_Y_Pos;
		boss_bullet_X_Pos_in = boss_bullet_X_Pos;
		boss_bullet_Y_Motion_in = boss_bullet_Y_Motion;
		boss_bullet_X_Motion_in = boss_bullet_X_Motion;
		//boundary = 0;
		unique case (State)
			sil : 
				if (rtc_clk_rising_edge && boss_counter<200) 
					Next_state = shoot_p;                      
			shoot_p : 
				if(~rtc_clk_rising_edge)
				Next_state = shooting;
            shooting : 
				if(boundary)
				Next_state = sil;
		endcase
		case (State)
			sil: 
				begin
					boss_bullet_X_Motion_in = 10'd0;
                    boss_bullet_Y_Motion_in = 10'd0;
					boundary =0;
					boss_bullet_X_Pos_in = boss_X_Pos;
					boss_bullet_Y_Pos_in = boss_Y_Pos;
				end
			shoot_p : 
				begin 
					boss_bullet_X_Motion_in =(~(boss_bullet_X_Step) + 1'b1);
                    boundary =0;
                    if(Ball_Y_Pos>=boss_bullet_Y_Pos)
                        boss_bullet_Y_Motion_in = (Ball_Y_Pos - boss_bullet_Y_Pos)/((boss_bullet_X_Pos - Ball_X_Pos)/boss_bullet_X_Step);
					else
                        boss_bullet_Y_Motion_in = ~( (boss_bullet_Y_Pos - Ball_Y_Pos)/((boss_bullet_X_Pos - Ball_X_Pos)/boss_bullet_X_Step)) + 1'b1;
                end
            shooting:
                begin
      			if (frame_clk_rising_edge)
                    begin
						boss_bullet_X_Pos_in = boss_bullet_X_Pos + boss_bullet_X_Motion;
                        boss_bullet_Y_Pos_in = boss_bullet_Y_Pos + boss_bullet_Y_Motion;
                    end
				if ( boss_bullet_X_Pos < 10'd11 || boss_bullet_Y_Pos > 10'd400 || boss_bullet_Y_Pos < 10'd10 )  // boss_bullet is at the left edge!
						boundary = 1;
					else
						boundary = 0;
				end
                
			endcase
	end


    assign boss_bullet_X_Addr = DrawX - boss_bullet_X_Pos;
    assign boss_bullet_Y_Addr = DrawY - boss_bullet_Y_Pos;
    always_comb begin
        if ((DrawX-boss_bullet_X_Pos>=0)&& boss_counter<200 && (DrawX-boss_bullet_X_Pos<boss_bullet_X_Size) && (DrawY-boss_bullet_Y_Pos>=0) && (DrawY-boss_bullet_Y_Pos<boss_bullet_Y_Size))
            is_boss_bullet = 1'b1;
        else
            is_boss_bullet = 1'b0;
  end
				  
				  
endmodule




