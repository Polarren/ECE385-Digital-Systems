module Life_Count( input [9:0] DrawX, DrawY ,
                    output logic is_LifeCount,
                    output [9:0] LifeCount_X_Addr, LifeCount_Y_Addr
                    );

    logic [9:0] LifeCount_X_Pos;
    logic [9:0] LifeCount_Y_Pos;
    assign LifeCount_X_Pos = 10;
    assign LifeCount_Y_Pos = 460;
    assign LifeCount_X_Addr = DrawX - LifeCount_X_Pos;
    assign LifeCount_Y_Addr = DrawY - LifeCount_Y_Pos;
    parameter LifeCount_X_Size = 44;
    parameter LifeCount_Y_Size = 12;

    always_comb
    begin
        if ((LifeCount_X_Addr>=0 && LifeCount_X_Addr<LifeCount_X_Size) &&(LifeCount_Y_Addr>=0 && LifeCount_Y_Addr<LifeCount_Y_Size) )
            is_LifeCount = 1;
        else 
            is_LifeCount = 0;
    end

endmodule

module Status( input [9:0] DrawX, DrawY ,
                    output logic is_LifeCount,
                    output [9:0] LifeCount_X_Addr, LifeCount_Y_Addr
                    );

    logic [9:0] LifeCount_X_Pos;
    logic [9:0] LifeCount_Y_Pos;
    assign LifeCount_X_Pos = 10;
    assign LifeCount_Y_Pos = 460;
    assign LifeCount_X_Addr = DrawX - LifeCount_X_Pos;
    assign LifeCount_Y_Addr = DrawY - LifeCount_Y_Pos;
    parameter LifeCount_X_Size = 124;
    parameter LifeCount_Y_Size = 12;

    always_comb
    begin
        if ((LifeCount_X_Addr>=0 && LifeCount_X_Addr<LifeCount_X_Size) &&(LifeCount_Y_Addr>=0 && LifeCount_Y_Addr<LifeCount_Y_Size) )
            is_LifeCount = 1;
        else 
            is_LifeCount = 0;
    end

endmodule
