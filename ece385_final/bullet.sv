module  bullet ( input Clk,                // 50 MHz clock
                       Reset_h,              // Active-high reset signal
                       frame_clk,  
							  bullet,
							  direct,
							  key_R,        
                input  [9:0]   DrawX, DrawY, Ball_X_Pos, Ball_Y_Pos,
				input [9:0] bullet_X_Init, bullet_Y_Init,
                output logic  is_bullet            
              );
	
    parameter [9:0] bullet_X_Min = 10'd0;       // Leftmost point on the X axis
    parameter [9:0] bullet_X_Max = 10'd639;     // Rightmost point on the X axis
    parameter [9:0] bullet_X_Step = 10'd6;      // Step size on the X axis
    parameter [9:0] bullet_X_Size = 10'd2;        // bullet size
    parameter [9:0] bullet_Y_Size = 10'd2;        // bullet size

	logic [9:0] bullet_X_Pos,bullet_X_Pos_in, bullet_X_Motion_in, bullet_X_Motion,bullet_Y_Pos,bullet_Y_Pos_in;
	logic boundary,direct_out,direct_in;		  
	enum logic [2:0] {  sil, shooting}  State, Next_state;

	 logic frame_clk_delayed, frame_clk_rising_edge;
    always_ff @ (posedge Clk) begin
        frame_clk_delayed <= frame_clk;
        frame_clk_rising_edge <= (frame_clk == 1'b1) && (frame_clk_delayed == 1'b0);
    end
	
    always_ff @ (posedge Clk)
    begin
        if (Reset_h||key_R)
        begin
			State <= sil;
            bullet_X_Pos <= bullet_X_Init;
            bullet_X_Motion <= 10'd0;
			bullet_Y_Pos <= bullet_Y_Init;
			direct_in <= 1;
        end
        else
        begin
			State <= Next_state;
            bullet_X_Pos <= bullet_X_Pos_in;
            bullet_X_Motion <= bullet_X_Motion_in;
			direct_in <= direct_out;
			bullet_Y_Pos <= bullet_Y_Pos_in;
        end
    end


	always_comb
	begin 
		// Default next state is staying at current state
		Next_state = State;
		bullet_Y_Pos_in = bullet_Y_Pos;
		bullet_X_Pos_in = bullet_X_Pos;
		direct_out = direct_in;
		unique case (State)
			sil : 
				if (bullet) 
					Next_state = shooting;                      
			shooting : 
				if(boundary)
				Next_state = sil;
		endcase
		case (State)
			sil: 
				begin
					bullet_X_Pos_in = Ball_X_Pos;
					bullet_X_Motion <= 10'd0;
					direct_out = direct;
					boundary =0;
					bullet_Y_Pos_in = Ball_Y_Pos;
				end
			shooting : 
				begin 
					if(direct_out)
						bullet_X_Motion = bullet_X_Step;
					else
						bullet_X_Motion =(~(bullet_X_Step) + 1'b1);

        			if (frame_clk_rising_edge)
						bullet_X_Pos_in = bullet_X_Pos + bullet_X_Motion;

					if( bullet_X_Pos > 10'd629 )  // bullet is at the right edge
						begin
							boundary = 1;
						end
        			else if ( bullet_X_Pos < 10'd11 )  // bullet is at the left edge!
            			begin
							boundary = 1;
						end
					else
						boundary = 0;
				end
		endcase
	end

	int DistX, DistY;
    assign DistX = DrawX - bullet_X_Pos;
    assign DistY = DrawY - bullet_Y_Pos;
    always_comb 
	begin
        if ( (( DistX*DistX ) <= (bullet_X_Size*bullet_X_Size)) &&(( DistY*DistY ) <= (bullet_Y_Size*bullet_Y_Size)) ) 
            is_bullet = 1'b1;
        else
            is_bullet = 1'b0;
    end
				  
				  
endmodule

