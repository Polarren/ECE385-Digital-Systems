module bullet_gen(  input   Clk,                // 50 MHz clock
                            Reset_h,              // Active-high reset signal
                            frame_clk,  
                            bullet,
                            direct,
                            key_R,        
                    input   [9:0]   DrawX, DrawY, Ball_X_Pos, Ball_Y_Pos,
                    input   [9:0]   bullet_X_Init, bullet_Y_Init,
                    output  logic   is_bullet,
                    output  [1:0]   shoot_counter  
);
    logic shoot_reset, shoot_reset_in;
    logic is_bullet_0,is_bullet_1,is_bullet_2,is_bullet_3;
    logic bullet_0,bullet_1,bullet_2,bullet_3;

    always_ff @ (posedge Clk)
    begin
        if (Reset_h||key_R)
            begin
                State <= wait_;
                shoot_counter<=0;
            end
        else
            begin
                State <= Next_state;
                shoot_counter <= shoot_counter_in;
            end
    end

    enum logic [2:0] { increase, wait_ ,increase_stay}  State, Next_state;

    logic [1:0] shoot_counter_in;

    always_comb
	begin 
        shoot_counter_in = shoot_counter;
        is_bullet = is_bullet_0|is_bullet_1|is_bullet_2|is_bullet_3;
        bullet_0 = 0;
        bullet_1 = 0;
        bullet_2 = 0;
        bullet_3 = 0;
		// Default next state is staying at current state
		Next_state = State;
        unique case (State)
			wait_ : 
				if (bullet) 
					Next_state = increase;                      
			increase : 
				if(~bullet)
				    Next_state = increase_stay;
            increase_stay:
                Next_state = wait_;
        endcase
        case(State)
            wait_:;
            increase:
            begin
                case(shoot_counter)
                    2'b00: bullet_0=1;
                    2'b01: bullet_1=1;
                    2'b10: bullet_2=1;
                    2'b11: bullet_3=1;
                endcase
            end
            increase_stay:
                shoot_counter_in = shoot_counter +1;
        endcase
	end

    bullet bull_0(.*,.bullet(bullet_0),.is_bullet(is_bullet_0));
    bullet bull_1(.*,.bullet(bullet_1),.is_bullet(is_bullet_1));
    bullet bull_2(.*,.bullet(bullet_2),.is_bullet(is_bullet_2));
    bullet bull_3(.*,.bullet(bullet_3),.is_bullet(is_bullet_3));

endmodule
