module HP_bar(
        input  [8:0]  boss_counter,  
        input  [9:0]  DrawX, DrawY,
        output is_bar
);

    logic [9:0] bar_X_Pos, bar_Y_Pos;
    logic [9:0] HP_Size_origin, Hp_Size;
    logic [9:0] HP_Y_size;

    always_comb
    begin
        HP_Y_size = 10;
        HP_Size_origin = 10'd200;
        bar_X_Pos = 10'd320;
        bar_Y_Pos = 10'd40;
        if(boss_counter <= 200)
            Hp_Size = HP_Size_origin - boss_counter;
        else
            Hp_Size = 0;
    end


    always_comb begin
		is_bar = 1'b0;
        if ( DrawX >= bar_X_Pos-Hp_Size && DrawX <=bar_X_Pos+Hp_Size && DrawY>= bar_Y_Pos- HP_Y_size && DrawY <= bar_Y_Pos + HP_Y_size  && boss_counter<200) 
            begin
                if(Hp_Size!=0)
                    is_bar = 1'b1;
            end

    end
endmodule





