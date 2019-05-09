//-------------------------------------------------------------------------
//    Ball.sv                                                            --
//    Viral Mehta                                                        --
//    Spring 2005                                                        --
//                                                                       --
//    Modified by Stephen Kempf 03-01-2006                               --
//                              03-12-2007                               --
//    Translated by Joe Meng    07-07-2013                               --
//    Modified by Po-Han Huang  12-08-2017                               --
//    Spring 2018 Distribution                                           --
//                                                                       --
//    For use with ECE 385 Lab 8                                         --
//    UIUC ECE Department                                                --
//-------------------------------------------------------------------------


module  zuofu ( input       Clk,                // 50 MHz clock
                            Reset,              // Active-high reset signal
                            frame_clk,          // The clock indicating a new frame (~60Hz)
							rtc_clk,
							death,
							in_air,
							blocked,
							top,
							update_flag,
				input [7:0] keycode, keycode_2,
                input [9:0] DrawX, DrawY, Ball_Y_Pos_Block,
			         		MapEnd_X_Pos, MapEnd_Y_Pos,
               	input [9:0] Ball_X_Init, Ball_Y_Init ,StayY,
				output logic is_ball, key_R, bullet,direct,Ending,key_T,            // Whether current pixel belongs to ball or background
                output [9:0] Ball_X_Pos, Ball_Y_Pos,
				output [9:0] Ball_Y_Motion,Ball_Y_Motion_in,Ball_X_Motion,
				output [3:0] counter,
				output [3:0] jump_count,jump_count_time, jump_reset
              );
    

    parameter [9:0] Ball_X_Min = 10'd0;       // Leftmost point on the X axis
    parameter [9:0] Ball_X_Max = 10'd639;     // Rightmost point on the X axis
    parameter [9:0] Ball_Y_Min = 10'd0;       // Topmost point on the Y axis
    parameter [9:0] Ball_Y_Max = 10'd399;     // Bottommost point on the Y axis
    parameter [9:0] Ball_X_Step = 10'd3;      // Step size on the X axis
    parameter [9:0] Ball_Y_Step = 10'd4;      // Step size on the Y axis
    parameter [9:0] Ball_X_Size = 10'd12;        // Ball size
    parameter [9:0] Ball_Y_Size = 10'd9;        // Ball size
    parameter [9:0] gravity = 10'd2;

	int jump_count_in,air_reset,air_reset_in;
	logic direct_in;
	int jump_count_time_in,jump_reset_in;
    logic [9:0] Ball_X_Pos_in, Ball_X_Motion_in, Ball_Y_Pos_in;//, Ball_Y_Motion_in;

    // Detect rising edge of frame_clk
    logic frame_clk_delayed, frame_clk_rising_edge;
    logic rtc_clk_delayed, rtc_clk_rising_edge;
    always_ff @ (posedge Clk) begin
        frame_clk_delayed <= frame_clk;
        frame_clk_rising_edge <= (frame_clk == 1'b1) && (frame_clk_delayed == 1'b0);
		rtc_clk_delayed <= rtc_clk;
        rtc_clk_rising_edge <= (rtc_clk == 1'b1) && (rtc_clk_delayed == 1'b0);
    end
    // Update registers
	always_ff @(posedge frame_clk)
		begin
			if (Reset||key_R)
				air_reset <= 1;
			else
				air_reset <= air_reset_in;
		end

    always_ff @ (posedge Clk)
    begin
        if (Reset||key_R)
        begin
            Ball_X_Pos <= Ball_X_Init;
            Ball_Y_Pos <= Ball_Y_Init;
            Ball_X_Motion <= 10'd0;
            Ball_Y_Motion <= 10'd0;
			jump_count <= 1;
			jump_count_time <= 0;
			jump_reset <= 0;
			direct <= 1;
        end
		else if(update_flag)
			begin
				Ball_X_Pos <= Ball_X_Init;
				Ball_Y_Pos <= Ball_Y_Init;
			end
        else
        begin
            Ball_X_Pos <= Ball_X_Pos_in;
            Ball_Y_Pos <= Ball_Y_Pos_in;
            Ball_X_Motion <= Ball_X_Motion_in;
            Ball_Y_Motion <= Ball_Y_Motion_in;
			jump_count <= jump_count_in;
			jump_count_time <= jump_count_time_in;
			jump_reset <= jump_reset_in;
			direct <= direct_in;

        end
    end

    always_comb
    begin
        // By default, keep motion and position unchanged
        Ball_X_Pos_in = Ball_X_Pos;
        Ball_Y_Pos_in = Ball_Y_Pos;
        Ball_X_Motion_in = 0;
        Ball_Y_Motion_in = Ball_Y_Motion;
		jump_count_in = jump_count;
		counter = jump_count_in;
		jump_count_time_in = jump_count_time;
		jump_reset_in = jump_reset;
		bullet = 0;
		direct_in = direct;
		  
		if(keycode == 8'h15 || keycode_2 == 8'h15)
			key_R = 1'b1;
		else
			key_R = 1'b0;
		if(keycode == 8'h17 || keycode_2 == 8'h17)
			key_T = 1'b1;
		else
			key_T = 1'b0;
			
		if(keycode && death)
			begin
				unique case (keycode)
				8'd4://left
					begin
						Ball_X_Motion_in =(~(Ball_X_Step) + 1'b1);
						direct_in = 0;
					end
				8'h7://right					
					begin
						Ball_X_Motion_in = Ball_X_Step;
						direct_in = 1;
					end
				8'hd:
					begin
						bullet = 1;;
					end
				8'he: // K jump
				begin
					if(jump_count!=0 && jump_count_time < 2 && jump_reset == 0)
					begin
						jump_reset_in = 1;
						jump_count_in = 0;
						jump_count_time_in ++;
						Ball_Y_Motion_in =(~(Ball_Y_Step) + 1'b1);
					end
				end
				default: ;
				endcase
			end
			
		if(keycode_2 && death)
			begin
				unique case (keycode_2)
				8'd4://left
					begin
						Ball_X_Motion_in =(~(Ball_X_Step) + 1'b1);
						direct_in = 0;
					end
				8'h7://right					
					begin
						Ball_X_Motion_in = Ball_X_Step;
						direct_in = 1;
					end
				8'hd:
					begin
						bullet = 1;
					end
				8'he: // K jump
				begin
					if(jump_count!=0 && jump_count_time < 2 && jump_reset == 0)
					begin
						jump_reset_in = 1;
						jump_count_in = 0;
						jump_count_time_in ++;
						Ball_Y_Motion_in =(~(Ball_Y_Step) + 1'b1);
					end
				end
				default: ;
				endcase
			end
			
		if(keycode!=8'he && keycode_2!=8'he)
			jump_reset_in = 0;
		else
			jump_reset_in = 1;


		air_reset_in = air_reset;
		if(in_air)	
			air_reset_in = 1;
					
        if ( Ball_Y_Pos <= Ball_Y_Min + Ball_Y_Size )  // Ball is at the top edge, BOUNCE!
			begin
				Ball_Y_Pos_in =  Ball_Y_Min + Ball_Y_Size+1;
			end
		if(jump_count ==0)
			begin
				Ball_Y_Motion_in = ~(Ball_Y_Step) + 1'b1;
			end
		else if (jump_count!=0 && in_air == 0 && air_reset)
			begin
				air_reset_in = 0;
				Ball_Y_Pos_in = Ball_Y_Pos_Block;//Ball_Y_Pos;
				Ball_Y_Motion_in = 0;
				jump_count_time_in = 0;
			end

        // TODO: Add other boundary detections and handle keypress here.
			if( Ball_X_Pos> 10'd629 )  // Ball is at the right edge
				Ball_X_Pos_in = 10'd629;
        	else if ( Ball_X_Pos < 10'd11 )  // Ball is at the left edge!
				Ball_X_Pos_in = 10'd11;
			else if(blocked)
				Ball_X_Motion_in = 0;
			else if(top)
				begin
					Ball_Y_Motion_in = 0;
					Ball_Y_Pos_in = StayY+11;
				end

        // Update position and motion only at rising edge of frame clock
        if (frame_clk_rising_edge)
		    begin
            // Update the ball's position with its motion
            Ball_X_Pos_in = Ball_X_Pos + Ball_X_Motion;
			Ball_Y_Pos_in = Ball_Y_Pos + Ball_Y_Motion;	
        	end
		  
		if(rtc_clk_rising_edge)
			begin
			if(jump_count ==0)
				begin
					Ball_Y_Motion_in = ~(Ball_Y_Step) + 1'b1;
					jump_count_in+=1;
				end	
			else if (jump_count!=0 && in_air == 0)
			 		Ball_Y_Motion_in = 0;
			else if(jump_count!=0 && in_air)
				begin
					Ball_Y_Motion_in = Ball_Y_Motion + gravity;
					jump_count_in = jump_count;
				end
			else
				begin
					Ball_Y_Motion_in = Ball_Y_Motion;
				end
			end
		end
    

    // Compute whether the pixel corresponds to ball or background
    /* Since the multiplicants are required to be signed, we have to first cast them
       from logic to int (signed by default) before they are multiplied. */
    int DistX, DistY;
    assign DistX = DrawX - Ball_X_Pos;
    assign DistY = DrawY - Ball_Y_Pos;
    always_comb begin
        if ( (( DistX*DistX ) <= (Ball_X_Size*Ball_X_Size)) &&(( DistY*DistY ) <= (Ball_Y_Size*Ball_Y_Size)) ) 
            is_ball = 1'b1;
        else
            is_ball = 1'b0;
        /* The ball's (pixelated) circle is generated using the standard circle formula.  Note that while 
           the single line is quite powerful descriptively, it causes the synthesis tool to use up three
           of the 12 available multipliers on the chip! */
    end
    
	parameter [9:0] MapEnd_X_Size = 10'd8;       
    parameter [9:0] MapEnd_Y_Size = 10'd12; 
	always_comb
	begin
		if((Ball_X_Pos+6 >= MapEnd_X_Pos-MapEnd_X_Size && Ball_X_Pos-6 <= MapEnd_X_Pos+MapEnd_X_Size) 
		&& (Ball_Y_Pos+5 >= MapEnd_Y_Pos-MapEnd_Y_Size && Ball_Y_Pos-5 <= MapEnd_Y_Pos+MapEnd_Y_Size))
			Ending = 1;
		else
			Ending = 0;
	end

endmodule
