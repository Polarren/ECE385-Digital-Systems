module Spike_Array_1( input   Reset_h,                   
				            key_R,
                            VGA_VS,
                            death,
                    input [3:0] state_index,
                    input   [9:0] Ball_X_Pos, Ball_Y_Pos,
                    input [9:0] DrawX, DrawY ,
                    output logic is_spike_1,
                    output logic [1:0] Spike_Direct_1,
                    output [9:0] Spike_X_Addr_1, Spike_Y_Addr_1
                    );

    logic [9:0] Spike_X_Pos [0:11];
    logic [9:0] Spike_Y_Pos [0:11];
    parameter [9:0] Spike_size = 20;
    logic [9:0] Spike_Y_Pos_initial,Spike_X_Pos_initial,Spike_Y_Pos_initial_2;
    logic [1:0] Spike_Direct_Array [0:11];
    parameter [1:0] Spike_Up    = 2'b00;
    parameter [1:0] Spike_Right = 2'b01;
    parameter [1:0] Spike_Down  = 2'b10;
    parameter [1:0] Spike_Left  = 2'b11;
    logic [9:0] Spike_X_Size [0:11];
    logic [9:0] Spike_Y_Size [0:11];
    always_comb
    begin
        Spike_X_Pos [0] = 300;
        Spike_Y_Pos_initial = 420;
        Spike_Direct_Array[0] = Spike_Up;
        Spike_X_Size[0] = 260;
        Spike_Y_Size[0] = 20;
        Spike_Direct_Array[0] = Spike_Up;

        Spike_X_Pos [1] = 280;
        Spike_Y_Pos [1] = 80;    
        Spike_X_Size[1] = 120;
        Spike_Y_Size[1] = 20;
        Spike_Direct_Array[1] = Spike_Down;

        Spike_X_Pos [2] = 20;
        Spike_Y_Pos [2] = 140;
        Spike_X_Size[2] = 60;
        Spike_Y_Size[2] = 20;
        Spike_Direct_Array[2] = Spike_Up;

        Spike_X_Pos [3] = 260;
        Spike_Y_Pos [3] = 220;   
        Spike_X_Size[3] = 100;
        Spike_Y_Size[3] = 20;
        Spike_Direct_Array[3] = Spike_Up;

        Spike_X_Pos [4] = 400;
        Spike_Y_Pos [4] = 220;   
        Spike_X_Size[4] = 100;
        Spike_Y_Size[4] = 20;
        Spike_Direct_Array[4] = Spike_Up;

        Spike_X_Pos [5] = 260;
        Spike_Y_Pos [5] = 258;   
        Spike_X_Size[5] = 240;
        Spike_Y_Size[5] = 20;
        Spike_Direct_Array[5] = Spike_Down;

        Spike_X_Pos [6] = 140;
        Spike_Y_Pos [6] = 340;   
        Spike_X_Size[6] = 20;
        Spike_Y_Size[6] = 20;
        Spike_Direct_Array[6] = Spike_Right;

        Spike_X_Pos [7] = 400;
        Spike_Y_Pos [7] = 220;   
        Spike_X_Size[7] = 100;
        Spike_Y_Size[7] = 20;
        Spike_Direct_Array[7] = Spike_Up;

        Spike_X_Pos [8] = 200;
        Spike_Y_Pos [8] = 360;   
        Spike_X_Size[8] = 20;
        Spike_Y_Size[8] = 80;
        Spike_Direct_Array[8] = Spike_Left;

        Spike_X_Pos [9] = 160;
        Spike_Y_Pos [9] = 420;   
        Spike_X_Size[9] = 40;
        Spike_Y_Size[9] = 20;
        Spike_Direct_Array[9] = Spike_Up;

        Spike_X_Pos_initial = 0;
        Spike_Y_Pos [10] = 300;   
        Spike_X_Size[10] = 20;
        Spike_Y_Size[10] = 40;
        Spike_Direct_Array[10] = Spike_Right;

        Spike_X_Pos [11] = 280;
        Spike_Y_Pos_initial_2 = 420;   
        Spike_X_Size[11] = 20;
        Spike_Y_Size[11] = 20;
        Spike_Direct_Array[11] = Spike_Up;
    end
    
    logic [9:0] Spike_X_Pos_in [0:11];
    logic [9:0] Spike_Y_Pos_in [0:11];
    logic trap_flag [0:11];
    logic trap_flag_in [0:11];
    always_ff @ (posedge VGA_VS)
    begin 
        if(Reset_h||key_R)
            begin
    			trap_flag [0] = 0;
                trap_flag [10] = 0;
                Spike_Y_Pos [0] = Spike_Y_Pos_initial;
                Spike_X_Pos [10] = Spike_X_Pos_initial;
            end
        else
            begin
                trap_flag [0] = trap_flag_in [0];
                Spike_Y_Pos [0] <= Spike_Y_Pos_in [0];
                trap_flag [10] = trap_flag_in [10];
                Spike_X_Pos [10] <= Spike_X_Pos_in [10];
            end
    end 

   always_comb//Flying Spike 1
   begin
       trap_flag_in [0] = trap_flag [0];
       if(death==0)
           Spike_Y_Pos_in [0] = Spike_Y_Pos [0];
       else if(Spike_Y_Pos [0]<20 && Spike_Y_Pos [0]>3)
           Spike_Y_Pos_in [0] = 10;
       else if(Ball_X_Pos >= Spike_X_Pos[0] - 20 && Ball_X_Pos <= Spike_X_Pos[0] + 20 && state_index == 3'd1)
           begin
               Spike_Y_Pos_in [0] = Spike_Y_Pos [0] - 6;
               trap_flag_in [0] = 1;
           end
       else if(trap_flag [0])	
           Spike_Y_Pos_in [0] = Spike_Y_Pos [0] - 6;
       else
           Spike_Y_Pos_in [0] = Spike_Y_Pos [0];
   end

    always_comb//Flying Spike 10
    begin
        trap_flag_in [10] = trap_flag [10];
        if(death==0)
            Spike_X_Pos_in [10] = Spike_X_Pos [10];
        else if(Spike_X_Pos [10]<540 && Spike_X_Pos [10]>533)
            Spike_X_Pos_in [10] = 540;
        else if(Ball_Y_Pos > Spike_Y_Pos[10] - 30 && Ball_Y_Pos <= Spike_Y_Pos[10] + 30 && state_index == 3'd1)
            begin
                Spike_X_Pos_in [10] = Spike_X_Pos [10] + 3;
                trap_flag_in [10] = 1;
            end
        else if(trap_flag [10])	
            Spike_X_Pos_in [10] = Spike_X_Pos [10] + 3;
        else
            Spike_X_Pos_in [10] = Spike_X_Pos [10];
    end

    always_comb//Flying Spike 11
    begin
        trap_flag_in [11] = trap_flag [11];
        if(death==0)
            Spike_Y_Pos_in [11] = Spike_Y_Pos [11];
        // else if(Spike_Y_Pos [11]<540 && Spike_Y_Pos [11]>533)
        //     Spike_Y_Pos_in [11] = 540;
        else if(Ball_X_Pos > Spike_X_Pos[11] - 20 && Ball_X_Pos <= Spike_Y_Pos[11] + 20 && state_index == 3'd1)
            begin
                Spike_Y_Pos_in [11] = Spike_Y_Pos [11] -6;
                trap_flag_in [11] = 1;
            end
        else if(trap_flag [11])	
            Spike_Y_Pos_in [11] = Spike_Y_Pos [11] -6;
        else
            Spike_Y_Pos_in [11] = Spike_Y_Pos [11];
    end

always_comb
begin
    if ((DrawX-Spike_X_Pos[0]>=0) && (DrawX-Spike_X_Pos[0]<Spike_X_Size[0]) && (DrawY-Spike_Y_Pos[0]>=0) && (DrawY-Spike_Y_Pos[0]<Spike_Y_Size[0]))
    begin
        is_spike_1 = 1'b1;
        Spike_X_Addr_1 = DrawX- Spike_X_Pos[0] ;
        Spike_Y_Addr_1 = DrawY- Spike_Y_Pos[0] ;
        Spike_Direct_1 = Spike_Direct_Array[0];
    end

    else if ((DrawX-Spike_X_Pos[1]>=0) && (DrawX-Spike_X_Pos[1]<Spike_X_Size[1]) && (DrawY-Spike_Y_Pos[1]>=0) && (DrawY-Spike_Y_Pos[1]<Spike_Y_Size[1]))
    begin
        is_spike_1 = 1'b1;
        Spike_X_Addr_1 = DrawX- Spike_X_Pos[1] ;
        Spike_Y_Addr_1 = DrawY- Spike_Y_Pos[1] ;
        Spike_Direct_1 = Spike_Direct_Array[1];
    end

    else if ((DrawX-Spike_X_Pos[2]>=0) && (DrawX-Spike_X_Pos[2]<Spike_X_Size[2]) && (DrawY-Spike_Y_Pos[2]>=0) && (DrawY-Spike_Y_Pos[2]<Spike_Y_Size[2]))
    begin
        is_spike_1 = 1'b1;
        Spike_X_Addr_1 = DrawX- Spike_X_Pos[2] ;
        Spike_Y_Addr_1 = DrawY- Spike_Y_Pos[2] ;
        Spike_Direct_1 = Spike_Direct_Array[2];
    end

    else if ((DrawX-Spike_X_Pos[3]>=0) && (DrawX-Spike_X_Pos[3]<Spike_X_Size[3]) && (DrawY-Spike_Y_Pos[3]>=0) && (DrawY-Spike_Y_Pos[3]<Spike_Y_Size[3]))
    begin
        is_spike_1 = 1'b1;
        Spike_X_Addr_1 = DrawX- Spike_X_Pos[3] ;
        Spike_Y_Addr_1 = DrawY- Spike_Y_Pos[3] ;
        Spike_Direct_1 = Spike_Direct_Array[3];
    end

    else if ((DrawX-Spike_X_Pos[4]>=0) && (DrawX-Spike_X_Pos[4]<Spike_X_Size[4]) && (DrawY-Spike_Y_Pos[4]>=0) && (DrawY-Spike_Y_Pos[4]<Spike_Y_Size[4]))
    begin
        is_spike_1 = 1'b1;
        Spike_X_Addr_1 = DrawX- Spike_X_Pos[4] ;
        Spike_Y_Addr_1 = DrawY- Spike_Y_Pos[4] ;
        Spike_Direct_1 = Spike_Direct_Array[4];
    end

    else if ((DrawX-Spike_X_Pos[5]>=0) && (DrawX-Spike_X_Pos[5]<Spike_X_Size[5]) && (DrawY-Spike_Y_Pos[5]>=0) && (DrawY-Spike_Y_Pos[5]<Spike_Y_Size[5]))
    begin
        is_spike_1 = 1'b1;
        Spike_X_Addr_1 = DrawX- Spike_X_Pos[5] ;
        Spike_Y_Addr_1 = DrawY- Spike_Y_Pos[5] ;
        Spike_Direct_1 = Spike_Direct_Array[5];
    end

    else if ((DrawX-Spike_X_Pos[6]>=0) && (DrawX-Spike_X_Pos[6]<Spike_X_Size[6]) && (DrawY-Spike_Y_Pos[6]>=0) && (DrawY-Spike_Y_Pos[6]<Spike_Y_Size[6]))
    begin
        is_spike_1 = 1'b1;
        Spike_X_Addr_1 = DrawX- Spike_X_Pos[6] ;
        Spike_Y_Addr_1 = DrawY- Spike_Y_Pos[6] ;
        Spike_Direct_1 = Spike_Direct_Array[6];
    end

    else if ((DrawX-Spike_X_Pos[7]>=0) && (DrawX-Spike_X_Pos[7]<Spike_X_Size[7]) && (DrawY-Spike_Y_Pos[7]>=0) && (DrawY-Spike_Y_Pos[7]<Spike_Y_Size[7]))
    begin
        is_spike_1 = 1'b1;
        Spike_X_Addr_1 = DrawX- Spike_X_Pos[7] ;
        Spike_Y_Addr_1 = DrawY- Spike_Y_Pos[7] ;
        Spike_Direct_1 = Spike_Direct_Array[7];
    end

    else if ((DrawX-Spike_X_Pos[8]>=0) && (DrawX-Spike_X_Pos[8]<Spike_X_Size[8]) && (DrawY-Spike_Y_Pos[8]>=0) && (DrawY-Spike_Y_Pos[8]<Spike_Y_Size[1]))
    begin
        is_spike_1 = 1'b1;
        Spike_X_Addr_1 = DrawX- Spike_X_Pos[8] ;
        Spike_Y_Addr_1 = DrawY- Spike_Y_Pos[8] ;
        Spike_Direct_1 = Spike_Direct_Array[8];
    end

    else if ((DrawX-Spike_X_Pos[9]>=0) && (DrawX-Spike_X_Pos[9]<Spike_X_Size[9]) && (DrawY-Spike_Y_Pos[9]>=0) && (DrawY-Spike_Y_Pos[9]<Spike_Y_Size[1]))
    begin
        is_spike_1 = 1'b1;
        Spike_X_Addr_1 = DrawX- Spike_X_Pos[9];
        Spike_Y_Addr_1 = DrawY- Spike_Y_Pos[9];
        Spike_Direct_1 = Spike_Direct_Array[9];
    end

    else if ((DrawX-Spike_X_Pos[10]>=0) && (DrawX-Spike_X_Pos[10]<Spike_X_Size[10]) && (DrawY-Spike_Y_Pos[10]>=0) && (DrawY-Spike_Y_Pos[10]<Spike_Y_Size[10]))
    begin
        is_spike_1 = 1'b1;
        Spike_X_Addr_1 = DrawX- Spike_X_Pos[10] ;
        Spike_Y_Addr_1 = DrawY- Spike_Y_Pos[10] ;
        Spike_Direct_1 = Spike_Direct_Array[10];
    end
    else if ((DrawX-Spike_X_Pos[11]>=0) && (DrawX-Spike_X_Pos[11]<Spike_X_Size[11]) && (DrawY-Spike_Y_Pos[11]>=0) && (DrawY-Spike_Y_Pos[11]<Spike_Y_Size[11]))
    begin
        is_spike_1 = 1'b1;
        Spike_X_Addr_1 = DrawX- Spike_X_Pos[11] ;
        Spike_Y_Addr_1 = DrawY- Spike_Y_Pos[11] ;
        Spike_Direct_1 = Spike_Direct_Array[11];
    end
    else 
    begin
        is_spike_1 = 1'b0;
        Spike_X_Addr_1 = DrawX- Spike_X_Pos[0] ;
        Spike_Y_Addr_1 = DrawY- Spike_Y_Pos[0] ;
        Spike_Direct_1 = Spike_Direct_Array[0];
    end
end
	 
endmodule
