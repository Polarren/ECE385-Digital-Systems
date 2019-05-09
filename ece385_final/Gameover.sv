module Gameover( input [9:0] DrawX, DrawY ,
                    input logic death ,VGA_VS,
                    output logic is_gameover,
                    output [9:0] Gameover_X_Addr, Gameover_Y_Addr
                    );

parameter [9:0] Gameover_X_Size = 204; 
parameter [9:0] Gameover_Y_Size = 48;

logic [9:0] Gameover_X_Pos, Gameover_Y_Pos, Gameover_Y_Pos_in;
assign Gameover_X_Pos = 218;
assign Gameover_X_Addr = DrawX - Gameover_X_Pos;
assign Gameover_Y_Addr = DrawY - Gameover_Y_Pos;

logic death_pre, death_cur;
always_ff @ (posedge VGA_VS)
begin 
    death_cur <= death;
    death_pre <= death_cur;
    Gameover_Y_Pos <= Gameover_Y_Pos_in;
end 


//calculation of Y position
always_comb
begin
    if (death_cur)
        Gameover_Y_Pos_in = 0;
    else if (death_pre == 1 && death_cur ==0)
        Gameover_Y_Pos_in = 0;
    else if (Gameover_Y_Pos >= 216 )
        Gameover_Y_Pos_in = Gameover_Y_Pos;
    else if(death_cur == 0)
        Gameover_Y_Pos_in = Gameover_Y_Pos + 3;
	 else	
		  Gameover_Y_Pos_in = Gameover_Y_Pos;
end

//Output calculation
// assign is_gameover = 1'b1;
always_comb
begin 
    if ((Gameover_X_Addr >=0) && (Gameover_X_Addr < Gameover_X_Size)
    && (Gameover_Y_Addr >=0) && (Gameover_Y_Addr < Gameover_Y_Size) && death_cur == 1'b0  )
        is_gameover = 1'b1;
    else 
        is_gameover = 1'b0;
end

endmodule
