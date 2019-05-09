module boss (input          Clk,                // 50 MHz clock
                            Reset,              // Active-high reset signal
                            frame_clk,          // The clock indicating a new frame (~60Hz)
				    		rtc_clk,
                            key_R,
                            is_bullet,
             input [3:0]    state_index,
             input [9:0]   DrawX, DrawY, Ball_X_Pos, Ball_Y_Pos,
             output [9:0]  boss_bullet_X_Addr, boss_bullet_Y_Addr,boss_X_Addr, boss_Y_Addr,
             output logic  is_boss,is_boss_bullet,is_bar,
             output [8:0] boss_counter 


);
    
    parameter [9:0] boss_X_Init = 10'd600;  // Init position on the X axis
    parameter [9:0] boss_Y_Init = 10'd40; 
    parameter [9:0] boss_Y_Step = 10'd3; 
    parameter [9:0] boss_X_Size = 10'd45; 
    parameter [9:0] boss_Y_Size = 10'd60;
    parameter [9:0] boss_Y_Min = 10'd4;       // Topmost point on the Y axis
    parameter [9:0] boss_Y_Max = 10'd400;
    logic [9:0] boss_X_Pos, boss_Y_Pos, boss_Y_Motion;
    logic [9:0] boss_Y_Pos_in, boss_Y_Motion_in;
    logic [8:0] boss_counter_in;

    apple_shooter boss_killer(.*);
    HP_bar hp_bar(.*);

    assign boss_X_Pos = boss_X_Init;
    assign boss_X_Addr = DrawX - boss_X_Pos;
    assign boss_Y_Addr = DrawY - boss_Y_Pos;   

    logic shoot_reset_in,shoot_reset;

    logic frame_clk_delayed, frame_clk_rising_edge;
    logic rtc_clk_delayed, rtc_clk_rising_edge;
    always_ff @ (posedge Clk) begin
        frame_clk_delayed <= frame_clk;
        frame_clk_rising_edge <= (frame_clk == 1'b1) && (frame_clk_delayed == 1'b0);
		rtc_clk_delayed <= rtc_clk;
        rtc_clk_rising_edge <= (rtc_clk == 1'b1) && (rtc_clk_delayed == 1'b0);
    end

    always_ff @ (posedge Clk)
    begin
        if (Reset||key_R)
        begin
            boss_Y_Pos <= boss_Y_Init;
            boss_Y_Motion <= boss_Y_Step;
            shoot_reset <= 0;
            boss_counter <= 0;
        end
        else
        begin
            boss_Y_Pos <= boss_Y_Pos_in;
            boss_Y_Motion <= boss_Y_Motion_in;
            shoot_reset <= shoot_reset_in;
            boss_counter <= boss_counter_in;
        end
    end

    always_comb
    begin
        boss_Y_Pos_in = boss_Y_Pos;
        boss_Y_Motion_in = boss_Y_Motion;
            if( boss_Y_Pos + boss_Y_Size >= boss_Y_Max )  // boss is at the bottom edge, BOUNCE!
                begin
						 boss_Y_Motion_in = (~(boss_Y_Step) + 1'b1);  // 2's complement.  
					 end
            else if ( boss_Y_Pos <= boss_Y_Min )  // boss is at the top edge, BOUNCE!
					 begin
						boss_Y_Motion_in = boss_Y_Step;
					end

        if (frame_clk_rising_edge)
		    begin
            // Update the ball's position with its motion
			boss_Y_Pos_in = boss_Y_Pos + boss_Y_Motion;
        end
    end

    

    always_comb 
    begin
        boss_counter_in = boss_counter;
        shoot_reset_in = shoot_reset;
		is_boss = 1'b0;
        if ( boss_X_Addr>=0 && boss_X_Addr<= boss_X_Size && boss_Y_Addr>=0 && boss_Y_Addr<= boss_Y_Size &&state_index==2 && boss_counter<200) 
            begin
                is_boss = 1'b1;
                if(is_bullet && shoot_reset == 0)
                begin
                    boss_counter_in = boss_counter + 1;
                    shoot_reset_in =1;
                end
                if(is_bullet==0)
                    shoot_reset_in = 0;
            end

    end


endmodule


