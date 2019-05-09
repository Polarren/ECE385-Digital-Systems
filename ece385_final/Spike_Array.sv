module Spike_Array_0( input   Reset_h,                   
				            key_R,
                            VGA_VS,
                            death,
                    input [3:0] state_index,
                    input   [9:0] Ball_X_Pos, Ball_Y_Pos,
                    input [9:0] DrawX, DrawY ,
                    output logic is_spike_0,
                    output logic [1:0] Spike_Direct_0,
                    output [9:0] Spike_X_Addr_0, Spike_Y_Addr_0
                    );

    logic [9:0] Spike_X_Pos [0:3];
    logic [9:0] Spike_Y_Pos [0:3];
    parameter [9:0] Spike_size = 20;
    logic [9:0] Spike_Y_Pos_initial;

    assign Spike_X_Pos [0] = 200;
    assign Spike_Y_Pos_initial = 380;
    assign Spike_X_Pos [1] = 220;
    assign Spike_Y_Pos [1] = 380;    
    assign Spike_X_Pos [2] = 240;
    assign Spike_Y_Pos [2] = 380;    
    assign Spike_X_Pos [3] = 320;
    assign Spike_Y_Pos [3] = 380;
//    assign Spike_X_Pos [4] = 300;
//    assign Spike_Y_Pos [4] = 380;
    logic [9:0] Spike_Y_Pos_in [0:3];
    logic trap_flag [0:3];
    logic trap_flag_in [0:3];
    // always_ff @ (posedge VGA_VS)
    // begin 
    //     if(Reset_h||key_R)
    //         begin
    // 			trap_flag [0] = 0;
    //             Spike_Y_Pos [0] = Spike_Y_Pos_initial;
    //         end
    //     else
    //         begin
    //             trap_flag [0] = trap_flag_in [0];
    //             Spike_Y_Pos [0] <= Spike_Y_Pos_in [0];
    //         end
    // end 

    // always_comb
    // begin
    //     trap_flag_in [0] = trap_flag [0];
    //     if(death==0)
    //         Spike_Y_Pos_in [0] = Spike_Y_Pos [0];
    //     else if(Spike_Y_Pos [0]<20 && Spike_Y_Pos [0]>3)
    //         Spike_Y_Pos_in [0] = 10;
    //     else if(Ball_X_Pos >= Spike_X_Pos[0] - 20 && Ball_X_Pos <= Spike_X_Pos[0] + 20)
    //         begin
    //             Spike_Y_Pos_in [0] = Spike_Y_Pos [0] - 6;
    //             trap_flag_in [0] = 1;
    //         end
    //     else if(trap_flag [0])	
    //         Spike_Y_Pos_in [0] = Spike_Y_Pos [0] - 6;
    //     else
    //         Spike_Y_Pos_in [0] = Spike_Y_Pos [0];
    // end


always_comb
begin
    // if ((DrawX-Spike_X_Pos[0]>=0) && (DrawX-Spike_X_Pos[0]<Spike_size) && (DrawY-Spike_Y_Pos[0]>=0) && (DrawY-Spike_Y_Pos[0]<Spike_size))
    // begin
    //     is_spike_0 = 1'b1;
    //     Spike_X_Addr_0 = DrawX- Spike_X_Pos[0] ;
    //     Spike_Y_Addr_0 = DrawY- Spike_Y_Pos[0] ;
    // end

    // else if ((DrawX-Spike_X_Pos[1]>=0) && (DrawX-Spike_X_Pos[1]<Spike_size) && (DrawY-Spike_Y_Pos[1]>=0) && (DrawY-Spike_Y_Pos[1]<Spike_size))
    // begin
    //     is_spike_0 = 1'b1;
    //     Spike_X_Addr_0 = DrawX- Spike_X_Pos[1] ;
    //     Spike_Y_Addr_0 = DrawY- Spike_Y_Pos[1] ;
    // end

    // else if ((DrawX-Spike_X_Pos[2]>=0) && (DrawX-Spike_X_Pos[2]<Spike_size) && (DrawY-Spike_Y_Pos[2]>=0) && (DrawY-Spike_Y_Pos[2]<Spike_size))
    // begin
    //     is_spike_0 = 1'b1;
    //     Spike_X_Addr_0 = DrawX- Spike_X_Pos[2] ;
    //     Spike_Y_Addr_0 = DrawY- Spike_Y_Pos[2] ;
    // end

    // else if ((DrawX-Spike_X_Pos[3]>=0) && (DrawX-Spike_X_Pos[3]<Spike_size) && (DrawY-Spike_Y_Pos[3]>=0) && (DrawY-Spike_Y_Pos[3]<Spike_size))
    // begin
    //     is_spike_0 = 1'b1;
    //     Spike_X_Addr_0 = DrawX- Spike_X_Pos[3] ;
    //     Spike_Y_Addr_0 = DrawY- Spike_Y_Pos[3] ;
    // end

    // else 
    // begin
        is_spike_0 = 1'b0;
        Spike_X_Addr_0 = DrawX- Spike_X_Pos[0] ;
        Spike_Y_Addr_0 = DrawY- Spike_Y_Pos[0] ;
    // end
end
	 
endmodule
