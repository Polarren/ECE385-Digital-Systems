module Block_Array( input [9:0] DrawX, DrawY ,
                    input [9:0] Ball_X_Pos, Ball_Y_Pos,Ball_Y_Motion,
                    input [9:0] Block_X_Pos [0:16],
                                Block_Y_Pos [0:16],
                                Block_X_size [0:16],
                                Block_Y_size [0:16],
                    output logic is_block,
                    output [9:0] Block_X_Addr, Block_Y_Addr, Ball_Y_Pos_Block
                    );


//choose which block to draw
always_comb
begin
    if ((Block_X_size [0] != 0) && (DrawX-Block_X_Pos[0]>=0) && (DrawX-Block_X_Pos[0]<Block_X_size[0]) && (DrawY-Block_Y_Pos[0]>=0) && (DrawY-Block_Y_Pos[0]<Block_Y_size[0]))
    begin
        is_block = 1'b1;
        Block_X_Addr = (DrawX- Block_X_Pos[0])%20 ;
        Block_Y_Addr = (DrawY- Block_Y_Pos[0])%20 ;
    end
    else if ((Block_X_size [1] != 0) && (DrawX-Block_X_Pos[1]>=0) && (DrawX-Block_X_Pos[1]<Block_X_size[1]) && (DrawY-Block_Y_Pos[1]>=0) && (DrawY-Block_Y_Pos[1]<Block_Y_size[1]))
    begin
        is_block = 1'b1;
        Block_X_Addr = (DrawX- Block_X_Pos[1])%20 ;
        Block_Y_Addr = (DrawY- Block_Y_Pos[1])%20 ;
    end
    else if ((Block_X_size [2] != 0) && (DrawX-Block_X_Pos[2]>=0) && (DrawX-Block_X_Pos[2]<Block_X_size[2]) && (DrawY-Block_Y_Pos[2]>=0) && (DrawY-Block_Y_Pos[2]<Block_Y_size[2]))
    begin
        is_block = 1'b1;
        Block_X_Addr = (DrawX- Block_X_Pos[2])%20 ;
        Block_Y_Addr = (DrawY- Block_Y_Pos[2])%20 ;
    end
    else if ((Block_X_size [3] != 0) && (DrawX-Block_X_Pos[3]>=0) && (DrawX-Block_X_Pos[3]<Block_X_size[3]) && (DrawY-Block_Y_Pos[3]>=0) && (DrawY-Block_Y_Pos[3]<Block_Y_size[3]))
    begin
        is_block = 1'b1;
        Block_X_Addr = (DrawX- Block_X_Pos[3])%20 ;
        Block_Y_Addr = (DrawY- Block_Y_Pos[3])%20 ;
    end
    else if ((Block_X_size [4] != 0) && (DrawX-Block_X_Pos[4]>=0) && (DrawX-Block_X_Pos[4]<Block_X_size[4]) && (DrawY-Block_Y_Pos[4]>=0) && (DrawY-Block_Y_Pos[4]<Block_Y_size[4]))
    begin
        is_block = 1'b1;
        Block_X_Addr = (DrawX- Block_X_Pos[4])%20 ;
        Block_Y_Addr = (DrawY- Block_Y_Pos[4])%20 ;
    end
    else if ((Block_X_size [5] != 0) && (DrawX-Block_X_Pos[5]>=0) && (DrawX-Block_X_Pos[5]<Block_X_size[5]) && (DrawY-Block_Y_Pos[5]>=0) && (DrawY-Block_Y_Pos[5]<Block_Y_size[5]))
    begin
        is_block = 1'b1;
        Block_X_Addr = (DrawX- Block_X_Pos[5])%20 ;
        Block_Y_Addr = (DrawY- Block_Y_Pos[5])%20 ;
    end
    else if ((Block_X_size [6] != 0) && (DrawX-Block_X_Pos[6]>=0) && (DrawX-Block_X_Pos[6]<Block_X_size[6]) && (DrawY-Block_Y_Pos[6]>=0) && (DrawY-Block_Y_Pos[6]<Block_Y_size[6]))
    begin
        is_block = 1'b1;
        Block_X_Addr = (DrawX- Block_X_Pos[6])%20 ;
        Block_Y_Addr = (DrawY- Block_Y_Pos[6])%20 ;
    end
    else if ((Block_X_size [7] != 0) && (DrawX-Block_X_Pos[7]>=0) && (DrawX-Block_X_Pos[7]<Block_X_size[7]) && (DrawY-Block_Y_Pos[7]>=0) && (DrawY-Block_Y_Pos[7]<Block_Y_size[7]))
    begin
        is_block = 1'b1;
        Block_X_Addr = (DrawX- Block_X_Pos[7])%20 ;
        Block_Y_Addr = (DrawY- Block_Y_Pos[7])%20 ;
    end
    else if ((Block_X_size [8] != 0) && (DrawX-Block_X_Pos[8]>=0) && (DrawX-Block_X_Pos[8]<Block_X_size[8]) && (DrawY-Block_Y_Pos[8]>=0) && (DrawY-Block_Y_Pos[8]<Block_Y_size[8]))
    begin
        is_block = 1'b1;
        Block_X_Addr = (DrawX- Block_X_Pos[8])%20 ;
        Block_Y_Addr = (DrawY- Block_Y_Pos[8])%20 ;
    end
    else if ((Block_X_size [9] != 0) && (DrawX-Block_X_Pos[9]>=0) && (DrawX-Block_X_Pos[9]<Block_X_size[9]) && (DrawY-Block_Y_Pos[9]>=0) && (DrawY-Block_Y_Pos[9]<Block_Y_size[9]))
    begin
        is_block = 1'b1;
        Block_X_Addr = (DrawX- Block_X_Pos[9])%20 ;
        Block_Y_Addr = (DrawY- Block_Y_Pos[9])%20 ;
    end
    else if ((Block_X_size [10] != 0) && (DrawX-Block_X_Pos[10]>=0) && (DrawX-Block_X_Pos[10]<Block_X_size[10]) && (DrawY-Block_Y_Pos[10]>=0) && (DrawY-Block_Y_Pos[10]<Block_Y_size[10]))
    begin
        is_block = 1'b1;
        Block_X_Addr = (DrawX- Block_X_Pos[10])%20 ;
        Block_Y_Addr = (DrawY- Block_Y_Pos[10])%20 ;
    end
    else if ((Block_X_size [11] != 0) && (DrawX-Block_X_Pos[11]>=0) && (DrawX-Block_X_Pos[11]<Block_X_size[11]) && (DrawY-Block_Y_Pos[11]>=0) && (DrawY-Block_Y_Pos[11]<Block_Y_size[11]))
    begin
        is_block = 1'b1;
        Block_X_Addr = (DrawX- Block_X_Pos[11])%20 ;
        Block_Y_Addr = (DrawY- Block_Y_Pos[11])%20 ;
    end
    else if ((Block_X_size [12] != 0) && (DrawX-Block_X_Pos[12]>=0) && (DrawX-Block_X_Pos[12]<Block_X_size[12]) && (DrawY-Block_Y_Pos[12]>=0) && (DrawY-Block_Y_Pos[12]<Block_Y_size[12]))
    begin
        is_block = 1'b1;
        Block_X_Addr = (DrawX- Block_X_Pos[12])%20 ;
        Block_Y_Addr = (DrawY- Block_Y_Pos[12])%20 ;
    end
    else if ((Block_X_size [13] != 0) && (DrawX-Block_X_Pos[13]>=0) && (DrawX-Block_X_Pos[13]<Block_X_size[13]) && (DrawY-Block_Y_Pos[13]>=0) && (DrawY-Block_Y_Pos[13]<Block_Y_size[13]))
    begin
        is_block = 1'b1;
        Block_X_Addr = (DrawX- Block_X_Pos[13])%20 ;
        Block_Y_Addr = (DrawY- Block_Y_Pos[13])%20 ;
    end
    else if ((Block_X_size [14] != 0) && (DrawX-Block_X_Pos[14]>=0) && (DrawX-Block_X_Pos[14]<Block_X_size[14]) && (DrawY-Block_Y_Pos[14]>=0) && (DrawY-Block_Y_Pos[14]<Block_Y_size[14]))
    begin
        is_block = 1'b1;
        Block_X_Addr = (DrawX- Block_X_Pos[14])%20 ;
        Block_Y_Addr = (DrawY- Block_Y_Pos[14])%20 ;
    end
    else if ((Block_X_size [15] != 0) && (DrawX-Block_X_Pos[15]>=0) && (DrawX-Block_X_Pos[15]<Block_X_size[15]) && (DrawY-Block_Y_Pos[15]>=0) && (DrawY-Block_Y_Pos[15]<Block_Y_size[15]))
    begin
        is_block = 1'b1;
        Block_X_Addr = (DrawX- Block_X_Pos[15])%20 ;
        Block_Y_Addr = (DrawY- Block_Y_Pos[15])%20 ;
    end
    else if ((Block_X_size [16] != 0) && (DrawX-Block_X_Pos[16]>=0) && (DrawX-Block_X_Pos[16]<Block_X_size[16]) && (DrawY-Block_Y_Pos[16]>=0) && (DrawY-Block_Y_Pos[16]<Block_Y_size[16]))
    begin
        is_block = 1'b1;
        Block_X_Addr = (DrawX- Block_X_Pos[16])%20 ;
        Block_Y_Addr = (DrawY- Block_Y_Pos[16])%20 ;
    end
    else 
    begin
        is_block = 1'b0;
        Block_X_Addr = DrawX- Block_X_Pos[0] ;
        Block_Y_Addr = DrawY- Block_Y_Pos[0] ;
    end
end
	 
//Determine the next Y position of Zuofu if he is touching the ground
always_comb
begin
    // for(int i = $size(Block_X_Pos)-1; i >=0; i--)begin
    if ((Ball_X_Pos>=Block_X_Pos[0]) && (Ball_X_Pos<Block_X_Pos[0] + Block_X_size[0])
    && (
    (Ball_Y_Pos+10+Ball_Y_Motion>Block_Y_Pos[0]) && (Ball_Y_Pos+10+Ball_Y_Motion<Block_Y_Pos[0] + Block_Y_size[0])
    ||((Ball_Y_Pos+10+Ball_Y_Motion<Block_Y_Pos[0]+ Block_Y_size[0]) &&(Ball_Y_Pos+10+Ball_Y_Motion>Block_Y_Pos[0])&&Ball_Y_Pos+10+Ball_Y_Motion<480)
    ))
        Ball_Y_Pos_Block = Block_Y_Pos[0] - 10;

    else if ((Ball_X_Pos>=Block_X_Pos[1]) && (Ball_X_Pos<Block_X_Pos[1] + Block_X_size[1])
    && (
    (Ball_Y_Pos+10+Ball_Y_Motion>Block_Y_Pos[1]) && (Ball_Y_Pos+10+Ball_Y_Motion<Block_Y_Pos[1] + Block_Y_size[1])
    ||((Ball_Y_Pos+10+Ball_Y_Motion<Block_Y_Pos[1]+ Block_Y_size[1]) &&(Ball_Y_Pos+10+Ball_Y_Motion>Block_Y_Pos[1])&&Ball_Y_Pos+10+Ball_Y_Motion<480)
    ))
        Ball_Y_Pos_Block = Block_Y_Pos[1] - 10;

    else if ((Ball_X_Pos>=Block_X_Pos[2]) && (Ball_X_Pos<Block_X_Pos[2] + Block_X_size[2])
    && (
    (Ball_Y_Pos+10+Ball_Y_Motion>Block_Y_Pos[2]) && (Ball_Y_Pos+10+Ball_Y_Motion<Block_Y_Pos[2] + Block_Y_size[2])
    ||((Ball_Y_Pos+10+Ball_Y_Motion<Block_Y_Pos[2]+ Block_Y_size[2]) &&(Ball_Y_Pos+10+Ball_Y_Motion>Block_Y_Pos[2])&&Ball_Y_Pos+10+Ball_Y_Motion<480)
    ))
        Ball_Y_Pos_Block = Block_Y_Pos[2] - 10;

    else if ((Ball_X_Pos>=Block_X_Pos[3]) && (Ball_X_Pos<Block_X_Pos[3] + Block_X_size[3])
    && (
    (Ball_Y_Pos+10+Ball_Y_Motion>Block_Y_Pos[3]) && (Ball_Y_Pos+10+Ball_Y_Motion<Block_Y_Pos[3] + Block_Y_size[3])
    ||((Ball_Y_Pos+10+Ball_Y_Motion<Block_Y_Pos[3]+ Block_Y_size[3]) &&(Ball_Y_Pos+10+Ball_Y_Motion>Block_Y_Pos[3])&&Ball_Y_Pos+10+Ball_Y_Motion<480)
    ))
            Ball_Y_Pos_Block = Block_Y_Pos[3] - 10;

    else if ((Ball_X_Pos>=Block_X_Pos[4]) && (Ball_X_Pos<Block_X_Pos[4] + Block_X_size[4])
    && (
    (Ball_Y_Pos+10+Ball_Y_Motion>Block_Y_Pos[4]) && (Ball_Y_Pos+10+Ball_Y_Motion<Block_Y_Pos[4] + Block_Y_size[4])
    ||((Ball_Y_Pos+10+Ball_Y_Motion<Block_Y_Pos[4]+ Block_Y_size[4]) &&(Ball_Y_Pos+10+Ball_Y_Motion>Block_Y_Pos[4])&&Ball_Y_Pos+10+Ball_Y_Motion<480)
    ))
        Ball_Y_Pos_Block = Block_Y_Pos[4] - 10;
    else if ((Ball_X_Pos>=Block_X_Pos[5]) && (Ball_X_Pos<Block_X_Pos[5] + Block_X_size[5])
    && (
    (Ball_Y_Pos+10+Ball_Y_Motion>Block_Y_Pos[5]) && (Ball_Y_Pos+10+Ball_Y_Motion<Block_Y_Pos[5] + Block_Y_size[5])
    ||((Ball_Y_Pos+10+Ball_Y_Motion<Block_Y_Pos[5]+ Block_Y_size[5]) &&(Ball_Y_Pos+10+Ball_Y_Motion>Block_Y_Pos[5])&&Ball_Y_Pos+10+Ball_Y_Motion<480)
    ))
        Ball_Y_Pos_Block = Block_Y_Pos[5] - 10;
    
    else if ((Ball_X_Pos>=Block_X_Pos[6]) && (Ball_X_Pos<Block_X_Pos[6] + Block_X_size[6])
    && (
    (Ball_Y_Pos+10+Ball_Y_Motion>Block_Y_Pos[6]) && (Ball_Y_Pos+10+Ball_Y_Motion<Block_Y_Pos[6] + Block_Y_size[6])
    ||((Ball_Y_Pos+10+Ball_Y_Motion<Block_Y_Pos[6]+ Block_Y_size[6]) &&(Ball_Y_Pos+10+Ball_Y_Motion>Block_Y_Pos[6])&&Ball_Y_Pos+10+Ball_Y_Motion<480)
    ))
        Ball_Y_Pos_Block = Block_Y_Pos[6] - 10;
    
    else if ((Ball_X_Pos>=Block_X_Pos[7]) && (Ball_X_Pos<Block_X_Pos[7] + Block_X_size[7])
    && (
    (Ball_Y_Pos+10+Ball_Y_Motion>Block_Y_Pos[7]) && (Ball_Y_Pos+10+Ball_Y_Motion<Block_Y_Pos[7] + Block_Y_size[7])
    ||((Ball_Y_Pos+10+Ball_Y_Motion<Block_Y_Pos[7]+ Block_Y_size[7]) &&(Ball_Y_Pos+10+Ball_Y_Motion>Block_Y_Pos[7])&&Ball_Y_Pos+10+Ball_Y_Motion<480)
    ))
        Ball_Y_Pos_Block = Block_Y_Pos[7] - 10;
    
    else if ((Ball_X_Pos>=Block_X_Pos[8]) && (Ball_X_Pos<Block_X_Pos[8] + Block_X_size[8])
    && (
    (Ball_Y_Pos+10+Ball_Y_Motion>Block_Y_Pos[8]) && (Ball_Y_Pos+10+Ball_Y_Motion<Block_Y_Pos[8] + Block_Y_size[8])
    ||((Ball_Y_Pos+10+Ball_Y_Motion<Block_Y_Pos[8]+ Block_Y_size[8]) &&(Ball_Y_Pos+10+Ball_Y_Motion>Block_Y_Pos[8])&&Ball_Y_Pos+10+Ball_Y_Motion<480)
    ))
        Ball_Y_Pos_Block = Block_Y_Pos[8] - 10;
    
    else if ((Ball_X_Pos>=Block_X_Pos[9]) && (Ball_X_Pos<Block_X_Pos[9] + Block_X_size[9])
    && (
    (Ball_Y_Pos+10+Ball_Y_Motion>Block_Y_Pos[9]) && (Ball_Y_Pos+10+Ball_Y_Motion<Block_Y_Pos[9] + Block_Y_size[9])
    ||((Ball_Y_Pos+10+Ball_Y_Motion<Block_Y_Pos[9]+ Block_Y_size[9]) &&(Ball_Y_Pos+10+Ball_Y_Motion>Block_Y_Pos[9])&&Ball_Y_Pos+10+Ball_Y_Motion<480)
    ))
        Ball_Y_Pos_Block = Block_Y_Pos[9] - 10;
    
    else if ((Ball_X_Pos>=Block_X_Pos[10]) && (Ball_X_Pos<Block_X_Pos[10] + Block_X_size[10])
    && (
    (Ball_Y_Pos+10+Ball_Y_Motion>Block_Y_Pos[10]) && (Ball_Y_Pos+10+Ball_Y_Motion<Block_Y_Pos[10] + Block_Y_size[10])
    ||((Ball_Y_Pos+10+Ball_Y_Motion<Block_Y_Pos[10]+ Block_Y_size[10]) &&(Ball_Y_Pos+10+Ball_Y_Motion>Block_Y_Pos[10])&&Ball_Y_Pos+10+Ball_Y_Motion<480)
    ))
        Ball_Y_Pos_Block = Block_Y_Pos[10] - 10;
    
    else if ((Ball_X_Pos>=Block_X_Pos[11]) && (Ball_X_Pos<Block_X_Pos[11] + Block_X_size[11])
    && (
    (Ball_Y_Pos+10+Ball_Y_Motion>Block_Y_Pos[11]) && (Ball_Y_Pos+10+Ball_Y_Motion<Block_Y_Pos[11] + Block_Y_size[11])
    ||((Ball_Y_Pos+10+Ball_Y_Motion<Block_Y_Pos[11]+ Block_Y_size[11]) &&(Ball_Y_Pos+10+Ball_Y_Motion>Block_Y_Pos[11])&&Ball_Y_Pos+10+Ball_Y_Motion<480)
    ))
        Ball_Y_Pos_Block = Block_Y_Pos[11] - 10;
    
    else if ((Ball_X_Pos>=Block_X_Pos[12]) && (Ball_X_Pos<Block_X_Pos[12] + Block_X_size[12])
    && (
    (Ball_Y_Pos+10+Ball_Y_Motion>Block_Y_Pos[12]) && (Ball_Y_Pos+10+Ball_Y_Motion<Block_Y_Pos[12] + Block_Y_size[12])
    ||((Ball_Y_Pos+10+Ball_Y_Motion<Block_Y_Pos[12]+ Block_Y_size[12]) &&(Ball_Y_Pos+10+Ball_Y_Motion>Block_Y_Pos[12])&&Ball_Y_Pos+10+Ball_Y_Motion<480)
    ))
        Ball_Y_Pos_Block = Block_Y_Pos[12] - 10;
    
    else if ((Ball_X_Pos>=Block_X_Pos[13]) && (Ball_X_Pos<Block_X_Pos[13] + Block_X_size[13])
    && (
    (Ball_Y_Pos+10+Ball_Y_Motion>Block_Y_Pos[13]) && (Ball_Y_Pos+10+Ball_Y_Motion<Block_Y_Pos[13] + Block_Y_size[13])
    ||((Ball_Y_Pos+10+Ball_Y_Motion<Block_Y_Pos[13]+ Block_Y_size[13]) &&(Ball_Y_Pos+10+Ball_Y_Motion>Block_Y_Pos[13])&&Ball_Y_Pos+10+Ball_Y_Motion<480)
    ))
        Ball_Y_Pos_Block = Block_Y_Pos[13] - 10;
    
    else if ((Ball_X_Pos>=Block_X_Pos[14]) && (Ball_X_Pos<Block_X_Pos[14] + Block_X_size[14])
    && (
    (Ball_Y_Pos+10+Ball_Y_Motion>Block_Y_Pos[14]) && (Ball_Y_Pos+10+Ball_Y_Motion<Block_Y_Pos[14] + Block_Y_size[14])
    ||((Ball_Y_Pos+10+Ball_Y_Motion<Block_Y_Pos[14]+ Block_Y_size[14]) &&(Ball_Y_Pos+10+Ball_Y_Motion>Block_Y_Pos[14])&&Ball_Y_Pos+10+Ball_Y_Motion<480)
    ))
        Ball_Y_Pos_Block = Block_Y_Pos[14] - 10;
    
    else if ((Ball_X_Pos>=Block_X_Pos[15]) && (Ball_X_Pos<Block_X_Pos[15] + Block_X_size[15])
    && (
    (Ball_Y_Pos+10+Ball_Y_Motion>Block_Y_Pos[15]) && (Ball_Y_Pos+10+Ball_Y_Motion<Block_Y_Pos[15] + Block_Y_size[15])
    ||((Ball_Y_Pos+10+Ball_Y_Motion<Block_Y_Pos[15]+ Block_Y_size[15]) &&(Ball_Y_Pos+10+Ball_Y_Motion>Block_Y_Pos[15])&&Ball_Y_Pos+10+Ball_Y_Motion<480)
    ))
        Ball_Y_Pos_Block = Block_Y_Pos[15] - 10;
    
    else if ((Ball_X_Pos>=Block_X_Pos[16]) && (Ball_X_Pos<Block_X_Pos[16] + Block_X_size[16])
    && (
    (Ball_Y_Pos+10+Ball_Y_Motion>Block_Y_Pos[16]) && (Ball_Y_Pos+10+Ball_Y_Motion<Block_Y_Pos[16] + Block_Y_size[16])
    ||((Ball_Y_Pos+10+Ball_Y_Motion<Block_Y_Pos[16]+ Block_Y_size[16]) &&(Ball_Y_Pos+10+Ball_Y_Motion>Block_Y_Pos[16])&&Ball_Y_Pos+10+Ball_Y_Motion<480)
    ))
        Ball_Y_Pos_Block = Block_Y_Pos[16] - 10;
    else 
        Ball_Y_Pos_Block = Ball_Y_Pos;
    // end
end


endmodule
