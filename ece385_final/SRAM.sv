module SRAM_title(output logic SRAM_UB_N, SRAM_LB_N, SRAM_CE_N, SRAM_OE_N, SRAM_WE_N,
                output logic [19:0] SRAM_ADDR,
                input   [9:0] DrawX, DrawY,
                inout wire [15:0] SRAM_DQ,
                output is_title
                );

	assign SRAM_UB_N = 1'b0;
	assign SRAM_LB_N = 1'b0;
	assign SRAM_CE_N = 1'b0;
    assign SRAM_OE_N = 1'b0;
    assign SRAM_WE_N = 1'b1;

    parameter [9:0] Title_X_Pos = 28;
    parameter [9:0] Title_Y_Pos = 140;
    parameter [9:0] Title_X_Size= 583;
    parameter [9:0] Title_Y_Size= 162;

    logic     [9:0] Title_X_Addr ;
    logic     [9:0] Title_Y_Addr ;
	assign Title_X_Addr = DrawX - Title_X_Pos;
    assign Title_Y_Addr = DrawY - Title_Y_Pos;


    always_comb
    begin
        if (Title_X_Addr>= 0 && Title_X_Addr<Title_X_Size && Title_Y_Addr>=0 && Title_Y_Addr< Title_Y_Size)
            is_title = 1;
        else 
            is_title = 0;
    end

    assign SRAM_ADDR = (Title_X_Addr + Title_X_Size*Title_Y_Addr);


endmodule


module SRAM(output logic SRAM_UB_N, SRAM_LB_N, SRAM_CE_N, SRAM_OE_N, SRAM_WE_N,
                output logic [19:0] SRAM_ADDR,
                input   [9:0] DrawX, DrawY,
                inout wire [15:0] SRAM_DQ
                );

	assign SRAM_UB_N = 1'b0;
	assign SRAM_LB_N = 1'b0;
	assign SRAM_CE_N = 1'b0;
    assign SRAM_OE_N = 1'b0;
    assign SRAM_WE_N = 1'b1;

    assign SRAM_ADDR = (DrawX + 640*DrawY);


endmodule