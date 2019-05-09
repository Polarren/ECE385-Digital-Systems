module Title( input [9:0] DrawX, DrawY ,
                    output logic is_title, 
                    output [9:0] Title_X_Addr, Title_Y_Addr
                    );


    parameter [9:0] Title_X_Pos = 28;
    parameter [9:0] Title_Y_Pos = 80;
    parameter [9:0] Title_X_Size= 583;
    parameter [9:0] Title_Y_Size= 162;

	assign Title_X_Addr = DrawX - Title_X_Pos;
    assign Title_Y_Addr = DrawY - Title_Y_Pos;


always_comb
begin
    if((Title_X_Addr >=0) && (Title_X_Addr < Title_X_Size)
    && (Title_Y_Addr >=0) && (Title_Y_Addr < Title_Y_Size) )
        is_title = 1'b1;
    else 
        is_title = 1'b0;
end

endmodule