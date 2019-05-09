module Apple_Array_1( input [9:0] DrawX, DrawY ,
                    input is_bullet,
                          Reset_h,                   
				          key_R,
                          VGA_VS,
                          Clk,
                    input [3:0] state_index,
                    output logic is_apple_1,
                    output [9:0] Apple_X_Addr_1, Apple_Y_Addr_1
                    );

    logic [9:0] Apple_X_Pos [0:3];
    logic [9:0] Apple_Y_Pos [0:3];
    parameter [9:0] Apple_X_size = 12;
    parameter [9:0] Apple_Y_size = 14;
    // logic sig_apple;
    assign Apple_X_Pos [0] = 600;
    assign Apple_Y_Pos [0] = 305;
    assign Apple_X_Pos [1] = 220;
    assign Apple_Y_Pos [1] = 145;    
    assign Apple_X_Pos [2] = 240;
    assign Apple_Y_Pos [2] = 145;    
    assign Apple_X_Pos [3] = 460;
    assign Apple_Y_Pos [3] = 80;

    logic apple_elimate [0:3];
    logic apple_elimate_in [0:3];
    always_ff @ (posedge Clk)
    begin 
        if(Reset_h||key_R)
            begin
    			apple_elimate [0] <= 0;
                apple_elimate [1] <= 0;
                apple_elimate [2] <= 0;
                apple_elimate [3] <= 0;
                //Spike_Y_Pos [0] <= 380;
            end
        else
            begin
                apple_elimate [0] <= apple_elimate_in [0];
                apple_elimate [1] <= apple_elimate_in [1];
                apple_elimate [2] <= apple_elimate_in [2];
                apple_elimate [3] <= apple_elimate_in [3];
                //Spike_Y_Pos [0] <= Spike_Y_Pos_in [0];
            end
    end 



always_comb
begin

    apple_elimate_in [0] = apple_elimate [0];
    apple_elimate_in [1] = apple_elimate [1];
    apple_elimate_in [2] = apple_elimate [2];
    apple_elimate_in [3] = apple_elimate [3];


    if ((DrawX-Apple_X_Pos[0]>=0) && (DrawX-Apple_X_Pos[0]<Apple_X_size) && state_index == 1 && (DrawY-Apple_Y_Pos[0]>=0) && (DrawY-Apple_Y_Pos[0]<Apple_Y_size))
    begin
	    Apple_X_Addr_1 = DrawX- Apple_X_Pos[0] ;
        Apple_Y_Addr_1 = DrawY- Apple_Y_Pos[0] ;
        if(is_bullet)
            apple_elimate_in [0] = 1;
        if(apple_elimate [0] == 0)
            is_apple_1 = 1'b1;
        else
            is_apple_1 = 1'b0;
    end

    else if ((DrawX-Apple_X_Pos[1]>=0) && (DrawX-Apple_X_Pos[1]<Apple_X_size) && state_index == 1 &&(DrawY-Apple_Y_Pos[1]>=0) && (DrawY-Apple_Y_Pos[1]<Apple_Y_size))
    begin
        Apple_X_Addr_1 = DrawX- Apple_X_Pos[1] ;
        Apple_Y_Addr_1 = DrawY- Apple_Y_Pos[1] ;
        if(is_bullet)
            apple_elimate_in [1] = 1;
        if(apple_elimate [1] == 0)
            is_apple_1 = 1'b1;
        else
            is_apple_1 = 1'b0;
    end

    else if ((DrawX-Apple_X_Pos[2]>=0) && (DrawX-Apple_X_Pos[2]<Apple_X_size) &&state_index == 1 && (DrawY-Apple_Y_Pos[2]>=0) && (DrawY-Apple_Y_Pos[2]<Apple_Y_size))
    begin
	     Apple_X_Addr_1 = DrawX- Apple_X_Pos[2] ;
        Apple_Y_Addr_1 = DrawY- Apple_Y_Pos[2] ;
        if(is_bullet)
            apple_elimate_in [2] = 1;
        if(apple_elimate [2] == 0)
            is_apple_1 = 1'b1;
        else
            is_apple_1 = 1'b0;
    end

    else if ((DrawX-Apple_X_Pos[3]>=0) && (DrawX-Apple_X_Pos[3]<Apple_X_size) &&state_index == 1 && (DrawY-Apple_Y_Pos[3]>=0) && (DrawY-Apple_Y_Pos[3]<Apple_Y_size))
    begin
        Apple_X_Addr_1 = DrawX- Apple_X_Pos[3] ;
        Apple_Y_Addr_1 = DrawY- Apple_Y_Pos[3] ;
        if(is_bullet)
            apple_elimate_in [3] = 1;
        if(apple_elimate [3] == 0)
            is_apple_1 = 1'b1;
        else
            is_apple_1 = 1'b0;
    end

    else 
    begin
        is_apple_1 = 1'b0;
        Apple_X_Addr_1 = DrawX- Apple_X_Pos[0] ;
        Apple_Y_Addr_1 = DrawY- Apple_Y_Pos[0] ;
    end
end
	 
endmodule
