module Win (input [9:0] DrawX, DrawY ,
            input logic win ,
            input [9:0] Ball_X_Pos, Ball_Y_Pos,
            output logic is_win,
            output [9:0] win_X_Addr, win_Y_Addr
);

parameter [9:0] Win_X_Size = 178; 
parameter [9:0] Win_Y_Size = 30;

logic [9:0] Win_X_Pos, Win_Y_Pos;

assign Win_Y_Pos = Ball_Y_Pos - Win_Y_Size - 20;
assign win_X_Addr = DrawX - Win_X_Pos;
assign win_Y_Addr = DrawY - Win_Y_Pos;

always_comb
begin
    if (Ball_X_Pos < 10'd11+(Win_X_Size>>1)) 
        Win_X_Pos = 10'd11;
    else if (Ball_X_Pos+(Win_X_Size>>1)> 10'd629)
        Win_X_Pos = 10'd628 - Win_X_Size;
    else    
        Win_X_Pos = Ball_X_Pos - (Win_X_Size>>1);

    if((win_X_Addr >=0) && (win_X_Addr < Win_X_Size)
    && (win_Y_Addr >=0) && (win_Y_Addr < Win_Y_Size) && win == 1'b1  )
        is_win = 1'b1;
    else 
        is_win = 1'b0;
end

endmodule
