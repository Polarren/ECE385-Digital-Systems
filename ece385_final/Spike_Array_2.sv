module Spike_Array_2( input   Reset_h,                   
				            key_R,
                            VGA_VS,
                            death,
                    input [3:0] state_index,
                    input   [9:0] Ball_X_Pos, Ball_Y_Pos,
                    input [9:0] DrawX, DrawY ,
                    output logic is_spike_2,
                    output logic [1:0] Spike_Direct_2,
                    output [9:0] Spike_X_Addr_2, Spike_Y_Addr_2
                    );

    logic [9:0] Spike_X_Pos [0:9];
    logic [9:0] Spike_Y_Pos [0:9];
    logic [9:0] Spike_X_Size [0:9];
    logic [9:0] Spike_Y_Size [0:9];
    logic [1:0] Spike_Direct_Array [0:9];
    parameter [9:0] Spike_size = 20;
    logic [9:0] Spike_Y_Pos_initial;
    parameter [1:0] Spike_Up    = 2'b00;
    parameter [1:0] Spike_Right = 2'b01;
    parameter [1:0] Spike_Down  = 2'b10;
    parameter [1:0] Spike_Left  = 2'b11;
    always_comb
    begin
        Spike_X_Pos [0] = 560;
        Spike_Y_Pos_initial = 400;
        Spike_X_Size[0] = 40;
        Spike_Y_Size[0] = 20; 
        Spike_Direct_Array[0] = Spike_Up;

        Spike_X_Pos [6] = 100;
        Spike_Y_Pos [6] = 380;
        Spike_X_Size[6] = 20;
        Spike_Y_Size[6] = 20; 
        Spike_Direct_Array[6] = Spike_Right;        

        Spike_X_Pos [1] = 220;
        Spike_Y_Pos [1] = 380;   
        Spike_X_Size[1] = 40;
        Spike_Y_Size[1] = 20; 

   
        Spike_X_Pos [3] = 320;
        Spike_Y_Pos [3] = 380;
        Spike_X_Size[3] = 20;
        Spike_Y_Size[3] = 20;
        Spike_Direct_Array[3] = Spike_Up;

        Spike_X_Pos [4] = 300;
        Spike_Y_Pos [4] = 380;
        Spike_X_Size[4] = 20;
        Spike_Y_Size[4] = 20;        
        Spike_Direct_Array[4] = Spike_Left; 

        Spike_X_Pos [5] = 340;
        Spike_Y_Pos [5] = 380;
        Spike_X_Size[5] = 20;
        Spike_Y_Size[5] = 20;
        Spike_Direct_Array[5] = Spike_Up; 
    end
    logic [9:0] Spike_Y_Pos_in [0:3];
    logic trap_flag [0:6];
    logic trap_flag_in [0:6];
    always_ff @ (posedge VGA_VS)
    begin 
        if(Reset_h||key_R)
            begin
    			trap_flag [0] = 0;
                Spike_Y_Pos [0] = Spike_Y_Pos_initial;
            end
        else
            begin
                trap_flag [0] = trap_flag_in [0];
                Spike_Y_Pos [0] <= Spike_Y_Pos_in [0];
            end
    end 

    always_comb
    begin
        trap_flag_in [0] = trap_flag [0];
        if(death==0)
            Spike_Y_Pos_in [0] = Spike_Y_Pos [0];
        else if(Spike_Y_Pos [0]<=380 && Spike_Y_Pos [0]>3)
            Spike_Y_Pos_in [0] = 380;
        else if(Ball_X_Pos >= Spike_X_Pos[0] - 20 && Ball_X_Pos <= Spike_X_Pos[0] + 20 && state_index == 3'd2)
            begin
                Spike_Y_Pos_in [0] = Spike_Y_Pos [0] - 5;
                trap_flag_in [0] = 1;
            end
        else if(trap_flag [0])	
            Spike_Y_Pos_in [0] = Spike_Y_Pos [0] - 5;
        else
            Spike_Y_Pos_in [0] = Spike_Y_Pos [0];
    end


always_comb
begin
    if ((DrawX-Spike_X_Pos[0]>=0) && (DrawX-Spike_X_Pos[0]<Spike_size) && (DrawY-Spike_Y_Pos[0]>=0) && (DrawY-Spike_Y_Pos[0]<Spike_size))
    begin
        is_spike_2 = 1'b1;
        Spike_X_Addr_2 = DrawX- Spike_X_Pos[0] ;
        Spike_Y_Addr_2 = DrawY- Spike_Y_Pos[0] ;
        Spike_Direct_2 = Spike_Direct_Array[0];
    end

    else if ((DrawX-Spike_X_Pos[1]>=0) && (DrawX-Spike_X_Pos[1]<Spike_size) && (DrawY-Spike_Y_Pos[1]>=0) && (DrawY-Spike_Y_Pos[1]<Spike_size))
    begin
        is_spike_2 = 1'b1;
        Spike_X_Addr_2 = DrawX- Spike_X_Pos[1] ;
        Spike_Y_Addr_2 = DrawY- Spike_Y_Pos[1] ;
        Spike_Direct_2 = Spike_Direct_Array[1];
    end

    else if ((DrawX-Spike_X_Pos[2]>=0) && (DrawX-Spike_X_Pos[2]<Spike_size) && (DrawY-Spike_Y_Pos[2]>=0) && (DrawY-Spike_Y_Pos[2]<Spike_size))
    begin
        is_spike_2 = 1'b1;
        Spike_X_Addr_2 = DrawX- Spike_X_Pos[2] ;
        Spike_Y_Addr_2 = DrawY- Spike_Y_Pos[2] ;
        Spike_Direct_2 = Spike_Direct_Array[2];
    end

    else if ((DrawX-Spike_X_Pos[3]>=0) && (DrawX-Spike_X_Pos[3]<Spike_size) && (DrawY-Spike_Y_Pos[3]>=0) && (DrawY-Spike_Y_Pos[3]<Spike_size))
    begin
        is_spike_2 = 1'b1;
        Spike_X_Addr_2 = DrawX- Spike_X_Pos[3] ;
        Spike_Y_Addr_2 = DrawY- Spike_Y_Pos[3] ;
        Spike_Direct_2 = Spike_Direct_Array[3];
    end
    else if ((DrawX-Spike_X_Pos[4]>=0) && (DrawX-Spike_X_Pos[4]<Spike_size) && (DrawY-Spike_Y_Pos[4]>=0) && (DrawY-Spike_Y_Pos[4]<Spike_size))
    begin
        is_spike_2 = 1'b1;
        Spike_X_Addr_2 = DrawX- Spike_X_Pos[4] ;
        Spike_Y_Addr_2 = DrawY- Spike_Y_Pos[4] ;
        Spike_Direct_2 = Spike_Direct_Array[4];
    end
    else if ((DrawX-Spike_X_Pos[5]>=0) && (DrawX-Spike_X_Pos[5]<Spike_size) && (DrawY-Spike_Y_Pos[5]>=0) && (DrawY-Spike_Y_Pos[5]<Spike_size))
    begin
        is_spike_2 = 1'b1;
        Spike_X_Addr_2 = DrawX- Spike_X_Pos[5] ;
        Spike_Y_Addr_2 = DrawY- Spike_Y_Pos[5] ;
        Spike_Direct_2 = Spike_Direct_Array[5];
    end
    else if ((DrawX-Spike_X_Pos[6]>=0) && (DrawX-Spike_X_Pos[6]<Spike_size) && (DrawY-Spike_Y_Pos[6]>=0) && (DrawY-Spike_Y_Pos[6]<Spike_size))
    begin
        is_spike_2 = 1'b1;
        Spike_X_Addr_2 = DrawX- Spike_X_Pos[6] ;
        Spike_Y_Addr_2 = DrawY- Spike_Y_Pos[6] ;
        Spike_Direct_2 = Spike_Direct_Array[6];
    end

    else 
    begin
        is_spike_2 = 1'b0;
        Spike_X_Addr_2 = DrawX- Spike_X_Pos[0] ;
        Spike_Y_Addr_2 = DrawY- Spike_Y_Pos[0] ;
        Spike_Direct_2 = Spike_Direct_Array[0];
    end
end
	 
endmodule
