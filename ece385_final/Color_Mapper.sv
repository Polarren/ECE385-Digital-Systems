//-------------------------------------------------------------------------
//    Color_Mapper.sv                                                    --
//    Stephen Kempf                                                      --
//    3-1-06                                                             --
//                                                                       --
//    Modified by David Kesler  07-16-2008                               --
//    Translated by Joe Meng    07-07-2013                               --
//    Modified by Po-Han Huang  10-06-2017                               --
//                                                                       --
//    Fall 2017 Distribution                                             --
//                                                                       --
//    For use with ECE 385 Lab 8                                         --
//    University of Illinois ECE Department                              --
//-------------------------------------------------------------------------

// color_mapper: Decide which color to be output to VGA for each pixel.
module  color_mapper (  input   is_ball,            // Whether current pixel belongs to ball 
                                Reset_h,                    //   or background (computed in ball.sv)
								key_R,
                                is_bullet,
                                is_boss,
								direct,
                                key_T,
                                win,
                                is_boss_bullet,
                                is_bar,
                                sec_clk,
                        input [3:0] state_index,
                        input [9:0] Block_X_Pos [0:16],
                                Block_Y_Pos [0:16],
                                Block_X_size [0:16],
                                Block_Y_size [0:16],
						input	Clk,rtc_clk,VGA_VS,is_MapEnd,
                        input   [9:0] DrawX, DrawY, Ball_Y_Motion, Ball_X_Motion,     // Current pixel coordinates
                        input   [9:0] boss_bullet_X_Addr, boss_bullet_Y_Addr,Ball_X_Pos, Ball_Y_Pos, 
                                MapEnd_X_Addr, MapEnd_Y_Addr,boss_X_Addr, boss_Y_Addr,
                        output logic [7:0] VGA_R, VGA_G, VGA_B, // VGA RGB output
					    output  in_air, death_in,death,blocked,top,
                        output logic [9:0] Ball_Y_Pos_Block,StayY
								//inout wire [15:0] SRAM_DQ
							);
    
    logic [7:0] Red, Green, Blue;
    logic [5:0] palette,palette_killer,palette_block,palette_gate;
    // logic [4:0] palette_trap;

    logic [9:0] Ball_X_Pos_Co,StayY_in;

	logic [23:0] RGB_data, RGB_killer,RGB_block,RGB_gate,RGB_title;
    // logic [23:0] RGB_trap;

	logic [4:0] Idle_palette;
	logic [18:0] Idle_address;
	logic [1:0] Idle_counter,Idle_counter_in;

    logic [4:0] Walking_palette;
	logic [18:0] Walking_address;
	logic [2:0] Walking_counter,Walking_counter_in;
    parameter [9:0] Walking_size = 125;

    logic [4:0] Gameover_palette;
	logic [18:0] Gameover_address;
	logic is_gameover;
    parameter [9:0] Gameover_X_Size = 204;
	logic [9:0] Gameover_X_Addr;
	logic [9:0] Gameover_Y_Addr;		

    logic [4:0] Spike_palette;
	logic [18:0] Spike_address;
	logic is_spike;
    logic [1:0] Spike_Direct;
    parameter [9:0] Spike_size = 20;
	logic [9:0] Spike_X_Addr;
	logic [9:0] Spike_Y_Addr;
    parameter [1:0] Spike_Up    = 2'b00;
    parameter [1:0] Spike_Right = 2'b01;
    parameter [1:0] Spike_Down  = 2'b10;
    parameter [1:0] Spike_Left  = 2'b11; 


    logic [4:0] Apple_palette;
	logic [18:0] Apple_address;
	logic is_apple;
    parameter [9:0] Apple_size = 25;
	logic [9:0] Apple_X_Addr;
	logic [9:0] Apple_Y_Addr;
    logic [1:0] Apple_counter,Apple_counter_in;

    logic [4:0] boss_bullet_palette;
	logic [18:0] boss_bullet_address;
	//logic is_boss_bullet;
    parameter [9:0] boss_bullet_size = 25;
	// logic [9:0] boss_bullet_X_Addr;
	// logic [9:0] boss_bullet_Y_Addr;

    logic [4:0] MapEnd_palette;
	logic [18:0] MapEnd_address;
	// logic is_mapend;
    parameter [9:0] MapEnd_size = 51;
	// logic [9:0] MapEnd_X_Addr;
	// logic [9:0] MapEnd_Y_Addr;
    logic [1:0] MapEnd_counter,MapEnd_counter_in;

    logic [5:0] Title_palette,palette_title;
	logic [18:0] Title_address;
    logic [9:0] Title_X_Addr;
    logic [9:0] Title_Y_Addr;
    parameter [9:0] Title_size = 583;
    logic is_title;
    //assign Title_palette = SRAM_DQ[13:8];

    logic [5:0] boss_palette;
	logic [18:0] boss_address;
    parameter [9:0] boss_size = 10'd45;

    logic [5:0] LifeCount_palette;
	logic [18:0] LifeCount_address;
	logic is_LifeCount;
    parameter [9:0] LifeCount_size =154;
	logic [9:0] LifeCount_X_Addr;
	logic [9:0] LifeCount_Y_Addr;
    logic [7:0] LifeCount_counter,LifeCount_counter_in;
    int LifeCount_Bit1, LifeCount_Bit0;
    logic LifeCount_trigger, LifeCount_trigger_in;
    assign LifeCount_Bit1= LifeCount_counter/10;
    assign LifeCount_Bit0= LifeCount_counter%10;

    logic [9:0]Minute_counter,Minute_counter_in;
    logic [9:0]Minute_counter_Bit1, Minute_counter_Bit0;
    assign Minute_counter = Second_counter/60;
    assign Minute_counter_Bit0 = Minute_counter%10;
    assign Minute_counter_Bit1 = (Minute_counter/10);
    logic [9:0]Second_counter, Second_counter_in;
    logic [9:0]Second_counter_Bit1, Second_counter_Bit0;
    assign Second_counter_Bit0 = Second_counter%10;
    assign Second_counter_Bit1 = (Second_counter/10)%6;

    logic [4:0] Block_palette;
	logic [18:0] Block_address;
	logic is_block;
    parameter [9:0] Block_size = 20;
    logic [9:0] Block_X_Addr, Block_Y_Addr;

    logic [4:0] win_palette;
	logic [18:0] win_address;
	logic is_win;
    parameter [9:0] win_size = 178;
    logic [9:0] win_X_Addr, win_Y_Addr;

	logic [23:0] RGB_ground;
    logic [4:0] Ground_palette;
    logic [18:0] Ground_address;
	
    logic [3:0] KILLER_TYPE;
	logic [3:0] Type;
    parameter [3:0] GROUND    = 4'b0000;
	parameter [3:0] IDLE      = 4'b0001;
    parameter [3:0] SPIKE     = 4'b0010;
    parameter [3:0] APPLE     = 4'b0011;
    parameter [3:0] GAMEOVER  = 4'b0100;
    parameter [3:0] BLOCK     = 4'b0101;
    parameter [3:0] LIFECOUNT = 4'b0110;
    parameter [3:0] WALKING   = 4'b0111;
    parameter [3:0] MAPEND    = 4'b1000;
    parameter [3:0] BOSS      = 4'b1001;
    parameter [3:0] BOSS_BULLET = 4'b1010;
    parameter [3:0] WINNER = 4'b1011;
    parameter [3:0] TITLE     = 4'b1100;

    logic top_in;
	logic in_air_in;
    logic blocked_in;
    logic is_killer;
	 //Drawing type decision
    //Spike detection module

	logic is_apple_0;
	logic [9:0] Apple_X_Addr_0;
	logic [9:0] Apple_Y_Addr_0;
    Apple_Array_0 apple_array_0(.*);

	logic is_apple_1;
	logic [9:0] Apple_X_Addr_1;
	logic [9:0] Apple_Y_Addr_1;
    Apple_Array_1 apple_array_1(.*);

    logic is_apple_2;
	 logic [9:0] Apple_X_Addr_2;
	 logic [9:0] Apple_Y_Addr_2;
    Apple_Array_2 apple_array_2(.*);


	logic is_spike_0;
    logic [1:0] Spike_Direct_0;
	logic [9:0] Spike_X_Addr_0;
	logic [9:0] Spike_Y_Addr_0;
    Spike_Array_0 spike_array_0( .* );

	logic is_spike_1;
    logic [1:0] Spike_Direct_1;
	logic [9:0] Spike_X_Addr_1;
	logic [9:0] Spike_Y_Addr_1;
    Spike_Array_1 spike_array_1( .* );

    logic is_spike_2;
    logic [1:0] Spike_Direct_2;
	logic [9:0] Spike_X_Addr_2;
	logic [9:0] Spike_Y_Addr_2;
    Spike_Array_2 spike_array_2( .* );

    always_comb
    begin
        case(state_index)
            4'd0:
            begin
                Spike_X_Addr = Spike_X_Addr_0;
                Spike_Y_Addr = Spike_Y_Addr_0;
                is_spike = is_spike_0;
                Apple_X_Addr = Apple_X_Addr_0;
                Apple_Y_Addr = Apple_Y_Addr_0;
                is_apple = is_apple_0;
                Spike_Direct = Spike_Direct_0;
            end
            4'd1:
            begin
                Spike_X_Addr = Spike_X_Addr_1;
                Spike_Y_Addr = Spike_Y_Addr_1;
                is_spike = is_spike_1;
                Apple_X_Addr = Apple_X_Addr_1;
                Apple_Y_Addr = Apple_Y_Addr_1;
                is_apple = is_apple_1;
                Spike_Direct = Spike_Direct_1;
            end
            4'd2:
            begin
                Spike_X_Addr = Spike_X_Addr_2;
                Spike_Y_Addr = Spike_Y_Addr_2;
                is_spike = is_spike_2;
                Apple_X_Addr = Apple_X_Addr_2;
                Apple_Y_Addr = Apple_Y_Addr_2;
                is_apple = is_apple_2;
                Spike_Direct = Spike_Direct_2;
            end
			default:
				begin
				Spike_X_Addr = Spike_X_Addr_0;
                Spike_Y_Addr = Spike_Y_Addr_0;
                is_spike = is_spike_0;
                Apple_X_Addr = Apple_X_Addr_0;
                Apple_Y_Addr = Apple_Y_Addr_0;
                is_apple = is_apple_0;
                Spike_Direct = Spike_Direct_0;
            end
		 endcase
    end
    Win winner(.*);
    Gameover gameover(.*);
    Block_Array block_array(.*);
    Status status(.*);
    Title title(.*);
    // MapEnd mapend(.*);

    assign is_killer = is_apple | is_spike |(( is_boss_bullet |is_boss )&& state_index ==2);
    always_comb
    begin 
        // if(is_bullet)
        //     Type = BULLET
        // else 
        if (is_gameover)
            Type = GAMEOVER;
        else if (is_ball && Ball_X_Motion==0 )
            Type = IDLE;
        else if (is_ball && Ball_X_Motion!=0 )
            Type = WALKING;
        else if (is_boss && state_index == 2 )
            Type = BOSS;
        else if (is_boss_bullet && state_index==2)
            Type = BOSS_BULLET;            
        else if (is_MapEnd)
            Type = MAPEND;
        else if (is_LifeCount)
            Type = LIFECOUNT;
		  else if (is_win)
            Type = WINNER;
        else if (is_block)
            Type = BLOCK;        
        else if (is_apple)
            Type = APPLE;
        else if (is_spike)
            Type = SPIKE;
        else if (is_title && state_index == 0)
            Type = TITLE;
        else
            Type = GROUND;

        if(is_boss && state_index==2)
            KILLER_TYPE = BOSS;
        else if(is_boss_bullet && state_index==2)
            KILLER_TYPE = BOSS_BULLET;
        else if (is_apple)
            KILLER_TYPE = APPLE;
        else if (is_spike)
            KILLER_TYPE = SPIKE;
        else
            KILLER_TYPE = SPIKE;    
    end

	//Counter implement
	always_ff @ (posedge rtc_clk)
	begin
        if (Reset_h || key_R)
        begin
            Idle_counter <= 0;
            Apple_counter<= 0;
            Walking_counter<=0;
            MapEnd_counter<=0;
        end
        else
        begin
		    Idle_counter <= Idle_counter_in+1;
            Apple_counter<= Apple_counter_in+1;
            Walking_counter<= (Walking_counter_in+1)%5;
            MapEnd_counter <= (MapEnd_counter_in + 1)%3;
        end
	end

    always_comb 
    begin
	    Idle_counter_in = Idle_counter;
        Apple_counter_in = Apple_counter;
        Walking_counter_in = Walking_counter;
        MapEnd_counter_in = MapEnd_counter;
        if (!death) //Trigger of life counter
            LifeCount_trigger_in = 1;
        else 
            LifeCount_trigger_in = 0;
        if (Reset_h == 1)
            LifeCount_counter_in = 7'b0;
        else if (LifeCount_counter >= 99)
            LifeCount_counter_in = 7'd99;
        else if (LifeCount_trigger == 0 && death == 0 ) //implement of life counter
            LifeCount_counter_in = LifeCount_counter + 1;
        else   
            LifeCount_counter_in = LifeCount_counter;
    end

	always_ff @ (posedge Clk)
	begin
		if(Reset_h||key_R)
			death <= 1;
		else
			begin 
                StayY = StayY_in; 
                blocked <= blocked_in;
				in_air <= in_air_in;
				top = top_in;
				death <= death_in;
                LifeCount_trigger <= LifeCount_trigger_in;
			end
        if (Reset_h||key_T) //Life counter does not need reset when R is pressed
            LifeCount_counter<= 7'b0;
        else
            LifeCount_counter<= LifeCount_counter_in;
	end

    always_ff @ (posedge sec_clk)
    begin
        if (Reset_h||key_R)
        begin
            Second_counter <= 9'b0;
        end
        else
            Second_counter <= Second_counter_in + 1;
    end
    always_comb
    begin
        Second_counter_in = Second_counter;
        if (Reset_h||key_T)
            Second_counter_in = 9'b0;
        else
            Second_counter_in = Second_counter;
    end
/*---------------------------------------


---------------------------------------------*/
	
	//Memory address calculation
	always_comb //Idle address calculaiton
	begin
        if (direct)
        begin 
            case (Idle_counter)
                2'b00:Idle_address = 12 + DrawX-Ball_X_Pos + (9+DrawY-Ball_Y_Pos) * 108;
                2'b01:Idle_address = 12 + DrawX-Ball_X_Pos + (9+DrawY-Ball_Y_Pos) * 108+27;
                2'b10:Idle_address = 12 + DrawX-Ball_X_Pos + (9+DrawY-Ball_Y_Pos) * 108+55;
                2'b11:Idle_address = 12 + DrawX-Ball_X_Pos + (9+DrawY-Ball_Y_Pos) * 108+82;
                default: Idle_address = 12 + DrawX - Ball_X_Pos + (9+DrawY-Ball_Y_Pos) * 108;		
		    endcase
        end 
        else
        begin
            case (Idle_counter)
                2'b00:Idle_address = 12 - (DrawX-Ball_X_Pos) + (9+DrawY-Ball_Y_Pos) * 108;
                2'b01:Idle_address = 12 - (DrawX-Ball_X_Pos) + (9+DrawY-Ball_Y_Pos) * 108+27;
                2'b10:Idle_address = 12 - DrawX+Ball_X_Pos + (9+DrawY-Ball_Y_Pos) * 108+55;
                2'b11:Idle_address = 12 - DrawX+Ball_X_Pos + (9+DrawY-Ball_Y_Pos) * 108+82;
                default: Idle_address = 12- DrawX + Ball_X_Pos + (9+DrawY-Ball_Y_Pos) * 108;		
		    endcase
        end
	end

    always_comb //Walking address calculaiton
	begin
        if (direct)
            Walking_address = 12 + DrawX-Ball_X_Pos + (9+DrawY-Ball_Y_Pos) * Walking_size + 25*Walking_counter;
        else
            Walking_address = 12 - (DrawX-Ball_X_Pos) + (9+DrawY-Ball_Y_Pos) * Walking_size + 25*Walking_counter;
	end

    always_comb //Apple address calculaiton
    begin
        if (Apple_counter>1)
            Apple_address = Apple_X_Addr + (Apple_Y_Addr)*Apple_size + 13;
        else
            Apple_address =  Apple_X_Addr + (Apple_Y_Addr)*Apple_size;
    end 

    always_comb//LifeCount address calculation
    begin
        if (LifeCount_X_Addr<24)
            LifeCount_address = LifeCount_X_Addr + LifeCount_Y_Addr*LifeCount_size;
        else if (LifeCount_X_Addr>=24 && LifeCount_X_Addr<34 )
            LifeCount_address = LifeCount_X_Addr + LifeCount_Y_Addr*LifeCount_size + 10*LifeCount_Bit1;
        else if (LifeCount_X_Addr>=34 && LifeCount_X_Addr<44 )
            LifeCount_address = LifeCount_X_Addr - 10 + LifeCount_Y_Addr*LifeCount_size + 10*LifeCount_Bit0;
        else if (LifeCount_X_Addr>=44 && LifeCount_X_Addr<54)
            LifeCount_address = 0 ;
        else if (LifeCount_X_Addr>=54 && LifeCount_X_Addr<76)
            LifeCount_address = LifeCount_X_Addr - 54 + LifeCount_Y_Addr*LifeCount_size + 124;
        else if (LifeCount_X_Addr>=76 && LifeCount_X_Addr<86)
            LifeCount_address = LifeCount_X_Addr - 76 + 24 + LifeCount_Y_Addr*LifeCount_size + 10*Minute_counter_Bit1 ;
        else if (LifeCount_X_Addr>=86 && LifeCount_X_Addr<96)
            LifeCount_address = LifeCount_X_Addr - 86 + 24 + LifeCount_Y_Addr*LifeCount_size + 10*Minute_counter_Bit0 ;
        else if (LifeCount_X_Addr>=96 && LifeCount_X_Addr<104)//colomn
            LifeCount_address = LifeCount_X_Addr - 96 + 146 + LifeCount_Y_Addr*LifeCount_size ;
        else if (LifeCount_X_Addr>=104 && LifeCount_X_Addr<114)
            LifeCount_address = LifeCount_X_Addr - 104 + 24 + LifeCount_Y_Addr*LifeCount_size + 10*Second_counter_Bit1 ;
        else if (LifeCount_X_Addr>=114 && LifeCount_X_Addr<124)
            LifeCount_address = LifeCount_X_Addr - 114 + 24 + LifeCount_Y_Addr*LifeCount_size + 10*Second_counter_Bit0 ;
        else 
            LifeCount_address = 0;
    end

    always_comb//Spike address calculation
    begin
        case(Spike_Direct)
            Spike_Up:Spike_address = Spike_X_Addr%Spike_size + (Spike_Y_Addr%Spike_size)*Spike_size;
            Spike_Right:Spike_address = (Spike_size-(Spike_X_Addr%Spike_size))*Spike_size + Spike_Y_Addr%Spike_size;
            Spike_Down:Spike_address = Spike_size -  Spike_X_Addr%Spike_size + (Spike_size-Spike_Y_Addr%Spike_size)*Spike_size;
            Spike_Left:Spike_address = Spike_size *( Spike_X_Addr%Spike_size) + Spike_size - Spike_Y_Addr%Spike_size;
            default:Spike_address = Spike_X_Addr%Spike_size + (Spike_Y_Addr%Spike_size)*Spike_size;
        endcase
    end

    always_comb
    begin
        win_address = win_X_Addr + win_Y_Addr*win_size;
        boss_bullet_address =  boss_bullet_X_Addr + (boss_bullet_Y_Addr)*boss_bullet_size;
        Ground_address = DrawX%20 + ((DrawY-400)%20) * 20;
        MapEnd_address = MapEnd_X_Addr + (MapEnd_Y_Addr)*MapEnd_size + MapEnd_counter * 17;
        Block_address = Block_X_Addr + (Block_Y_Addr)*Block_size;
        Gameover_address = Gameover_X_Addr + Gameover_Y_Addr * Gameover_X_Size;
        boss_address = boss_X_Addr + boss_Y_Addr * boss_size;
        Title_address = Title_X_Addr + Title_Y_Addr * Title_size;
    end

    // RAM instance
    IdleRAM IdleRAM_instance(.read_address(Idle_address), .Clk(Clk), .data_Out(Idle_palette));
    WalkingRAM WalkingRAM_instance(.read_address(Walking_address), .Clk(Clk), .data_Out(Walking_palette));
	GroundRAM GroundRAM_instance(.read_address(Ground_address), .Clk(Clk), .data_Out(Ground_palette));
	SpikeRAM SpikeRAM_instance(.read_address(Spike_address), .Clk(Clk), .data_Out(Spike_palette));
    AppleRAM AppleRAM_instance(.read_address(Apple_address), .Clk(Clk), .data_Out(Apple_palette));
    GroundRAM BlockRAM(.read_address(Block_address), .Clk(Clk), .data_Out(Block_palette));
    GameoverRAM GameoverRAM_instance(.read_address(Gameover_address), .Clk(Clk), .data_Out(Gameover_palette));
    StatusRAM LifeCountRAM_instance(.read_address(LifeCount_address), .Clk(Clk), .data_Out(LifeCount_palette));
    MapEndRAM MapEndRAM_instance(.read_address(MapEnd_address), .Clk(Clk), .data_Out(MapEnd_palette));
    AppleRAM Boss_bullet_instance(.read_address(boss_bullet_address), .Clk(Clk), .data_Out(boss_bullet_palette));
    BossRAM BossRAM_instance(.read_address(boss_address), .Clk(Clk), .data_Out(boss_palette));
    WinRAM winRAM_instance(.read_address(win_address), .Clk(Clk), .data_Out(win_palette));
    TitleRAM TitleRAM_instance(.read_address(Title_address), .Clk(Clk), .data_Out(Title_palette));

    //palette selection
    always_comb
    begin
        palette_block = Block_palette;
        palette_gate = MapEnd_palette;
        palette_title = Title_palette;

        case(KILLER_TYPE)//killer palette selection
            SPIKE:
			    palette_killer = Spike_palette;
            APPLE:
                palette_killer = Apple_palette;
            BOSS:
                palette_killer = boss_palette;
            BOSS_BULLET:
                palette_killer = boss_bullet_palette;
            default:
                palette_killer = Spike_palette;
        endcase

        case (Type)
            WINNER :
                palette = win_palette;
            GAMEOVER:
                palette = Gameover_palette;
			IDLE:
                palette = Idle_palette;
            WALKING:
                palette = Walking_palette;
            BOSS:
                palette = boss_palette;
            BOSS_BULLET:
                palette = boss_bullet_palette;
            SPIKE:
                palette = Spike_palette;
            APPLE:
                palette = Apple_palette;
            MAPEND:
                palette = MapEnd_palette;
            BLOCK:
                palette = Block_palette;
            LIFECOUNT:
                palette = LifeCount_palette;
            TITLE:
                palette = Title_palette;
            default:
                palette = Ground_palette;
	     endcase
    end
	 

     //sprite palette translator
	 always_comb
	 begin
			case(palette) // 25*21
				6'h00: RGB_data = 24'hF400FF;
                6'h01: RGB_data = 24'hFFFFFE;
                6'h02: RGB_data = 24'hC9C9C9;
                6'h03: RGB_data = 24'h030303;
                6'h04: RGB_data = 24'h1E1E1E; 
                6'h05: RGB_data = 24'h474747; 
                6'h06: RGB_data = 24'h3F0606; 
                6'h07: RGB_data = 24'h880606; 
                6'h08: RGB_data = 24'hAB0000; 
                6'h09: RGB_data = 24'hA40000; 
                6'h0a: RGB_data = 24'h5A2712; 
                6'h0b: RGB_data = 24'hDF4426; 
                6'h0c: RGB_data = 24'hFF0000; 
                6'h0d: RGB_data = 24'hFFC78F; 
                6'h0e: RGB_data = 24'hEFE300; 
                6'h0f: RGB_data = 24'h154269; 
                6'h10: RGB_data = 24'h323E92; 
                6'h11: RGB_data = 24'hED1C24;
                6'h12: RGB_data = 24'h342505;
                6'h13: RGB_data = 24'h47450F;
                6'h14: RGB_data = 24'h126401;
                6'h15: RGB_data = 24'h064100;
                6'h16: RGB_data = 24'h080000;
                6'h17: RGB_data = 24'h1E0B05;
                6'h18: RGB_data = 24'h893A1A;
                6'h19: RGB_data = 24'h873B19;
                6'h1a: RGB_data = 24'hB35A32;
                6'h1b: RGB_data = 24'hF30000;
                6'h1c: RGB_data = 24'h640000;
                6'h1d: RGB_data = 24'hF35B5B;
                6'h1e: RGB_data = 24'h676868;
				6'h1f: RGB_data = 24'h8f8f8e;
                6'h20: RGB_data = 24'hc9c9c8;
                6'h21: RGB_data = 24'h262626;
                6'h22: RGB_data = 24'h454444;
                6'h23: RGB_data = 24'h353434;
                6'h24: RGB_data = 24'h302f2f;
                6'h25: RGB_data = 24'h3e3c3c;
                6'h26: RGB_data = 24'ha4a4a4;
                6'h27: RGB_data = 24'h545555;
                6'h28: RGB_data = 24'hb2b2b1;
                6'h29: RGB_data = 24'hdfdfde;
                6'h2a: RGB_data = 24'h666565;
                6'h2b: RGB_data = 24'h535252;
                6'h2c: RGB_data = 24'h1e1e1e;
                6'h2d: RGB_data = 24'h414040;
                6'h2e: RGB_data = 24'hd6d5d5;
                6'h2f: RGB_data = 24'hbbbaba;
                6'h30: RGB_data = 24'hcac9c9;
                6'h31: RGB_data = 24'h595858;
                6'h32: RGB_data = 24'h878787;
                6'h33: RGB_data = 24'h5a5a5a;
                6'h34: RGB_data = 24'h2c2b2b;
                6'h35: RGB_data = 24'h737373;
                6'h36: RGB_data = 24'h393939;
                6'h37: RGB_data = 24'h6e6e6e;
                6'h38: RGB_data = 24'hebebeb;
                6'h39: RGB_data = 24'hfafafa;
                6'h3a: RGB_data = 24'h6e6e6e;
                6'h3b: RGB_data = 24'h434343;
					 default:RGB_data = 24'hF400FF;
            endcase
	 end

	 always_comb
	 begin
			case(palette_killer) // 25*21
				6'h00: RGB_killer = 24'hF400FF;
                6'h01: RGB_killer = 24'hFFFFFE;
                6'h02: RGB_killer = 24'hC9C9C9;
                6'h03: RGB_killer = 24'h030303;
                6'h04: RGB_killer = 24'h1E1E1E; 
                6'h05: RGB_killer = 24'h474747; 
                6'h06: RGB_killer = 24'h3F0606; 
                6'h07: RGB_killer = 24'h880606; 
                6'h08: RGB_killer = 24'hAB0000; 
                6'h09: RGB_killer = 24'hA40000; 
                6'h0a: RGB_killer = 24'h5A2712; 
                6'h0b: RGB_killer = 24'hDF4426; 
                6'h0c: RGB_killer = 24'hFF0000; 
                6'h0d: RGB_killer = 24'hFFC78F; 
                6'h0e: RGB_killer = 24'hEFE300; 
                6'h0f: RGB_killer = 24'h154269; 
                6'h10: RGB_killer = 24'h323E92; 
                6'h11: RGB_killer = 24'hED1C24;
                6'h12: RGB_killer = 24'h342505;
                6'h13: RGB_killer = 24'h47450F;
                6'h14: RGB_killer = 24'h126401;
                6'h15: RGB_killer = 24'h064100;
                6'h16: RGB_killer = 24'h080000;
                6'h17: RGB_killer = 24'h1E0B05;
                6'h18: RGB_killer = 24'h893A1A;
                6'h19: RGB_killer = 24'h873B19;
                6'h1a: RGB_killer = 24'hB35A32;
                6'h1b: RGB_killer = 24'hF30000;
                6'h1c: RGB_killer = 24'h640000;
                6'h1d: RGB_killer = 24'hF35B5B;
					 default:RGB_killer = 24'hF400FF;
            endcase
	 end

	 always_comb
	 begin
			case(Block_palette) // 25*21
				6'h00: RGB_block = 24'hF400FF;
                6'h01: RGB_block = 24'hFFFFFE;
                6'h02: RGB_block = 24'hC9C9C9;
                6'h03: RGB_block = 24'h030303;
                6'h04: RGB_block = 24'h1E1E1E; 
                6'h05: RGB_block = 24'h474747; 
                6'h06: RGB_block = 24'h3F0606; 
                6'h07: RGB_block = 24'h880606; 
                6'h08: RGB_block = 24'hAB0000; 
                6'h09: RGB_block = 24'hA40000; 
                6'h0a: RGB_block = 24'h5A2712; 
                6'h0b: RGB_block = 24'hDF4426; 
                6'h0c: RGB_block = 24'hFF0000; 
                6'h0d: RGB_block = 24'hFFC78F; 
                6'h0e: RGB_block = 24'hEFE300; 
                6'h0f: RGB_block = 24'h154269; 
                6'h10: RGB_block = 24'h323E92; 
                6'h11: RGB_block = 24'hED1C24;
                6'h12: RGB_block = 24'h342505;
                6'h13: RGB_block = 24'h47450F;
                6'h14: RGB_block = 24'h126401;
                6'h15: RGB_block = 24'h064100;
                6'h16: RGB_block = 24'h080000;
                6'h17: RGB_block = 24'h1E0B05;
                6'h18: RGB_block = 24'h893A1A;
                6'h19: RGB_block = 24'h873B19;
                6'h1a: RGB_block = 24'hB35A32;
                6'h1b: RGB_block = 24'hF30000;
                6'h1c: RGB_block = 24'h640000;
                6'h1d: RGB_block = 24'hF35B5B;
					 default:RGB_block = 24'hF400FF;
            endcase
	 end

	 always_comb
	 begin
			case(palette_title) // 25*21
				6'h00: RGB_title = 24'hF400FF;
                6'h01: RGB_title = 24'hFFFFFE;
                6'h02: RGB_title = 24'hC9C9C9;
                6'h03: RGB_title = 24'h030303;
                6'h04: RGB_title = 24'h1E1E1E; 
                6'h05: RGB_title = 24'h474747; 
                6'h06: RGB_title = 24'h3F0606; 
                6'h07: RGB_title = 24'h880606; 
                6'h08: RGB_title = 24'hAB0000; 
                6'h09: RGB_title = 24'hA40000; 
                6'h0a: RGB_title = 24'h5A2712; 
                6'h0b: RGB_title = 24'hDF4426; 
                6'h0c: RGB_title = 24'hFF0000; 
                6'h0d: RGB_title = 24'hFFC78F; 
                6'h0e: RGB_title = 24'hEFE300; 
                6'h0f: RGB_title = 24'h154269; 
                6'h10: RGB_title = 24'h323E92; 
                6'h11: RGB_title = 24'hED1C24;
                6'h12: RGB_title = 24'h342505;
                6'h13: RGB_title = 24'h47450F;
                6'h14: RGB_title = 24'h126401;
                6'h15: RGB_title = 24'h064100;
                6'h16: RGB_title = 24'h080000;
                6'h17: RGB_title = 24'h1E0B05;
                6'h18: RGB_title = 24'h893A1A;
                6'h19: RGB_title = 24'h873B19;
                6'h1a: RGB_title = 24'hB35A32;
                6'h1b: RGB_title = 24'hF30000;
                6'h1c: RGB_title = 24'h640000;
                6'h1d: RGB_title = 24'hF35B5B;
					 default:RGB_title = 24'hF400FF;
            endcase
	 end

    always_comb
	begin
			case(palette_gate) // 25*21
				6'h00: RGB_gate = 24'hF400FF;
                6'h01: RGB_gate = 24'hFFFFFE;
                6'h02: RGB_gate = 24'hC9C9C9;
                6'h03: RGB_gate = 24'h030303;
                6'h04: RGB_gate = 24'h1E1E1E; 
                6'h05: RGB_gate = 24'h474747; 
                6'h06: RGB_gate = 24'h3F0606; 
                6'h07: RGB_gate = 24'h880606; 
                6'h08: RGB_gate = 24'hAB0000; 
                6'h09: RGB_gate = 24'hA40000; 
                6'h0a: RGB_gate = 24'h5A2712; 
                6'h0b: RGB_gate = 24'hDF4426; 
                6'h0c: RGB_gate = 24'hFF0000; 
                6'h0d: RGB_gate = 24'hFFC78F; 
                6'h0e: RGB_gate = 24'hEFE300; 
                6'h0f: RGB_gate = 24'h154269; 
                6'h10: RGB_gate = 24'h323E92; 
                6'h11: RGB_gate = 24'hED1C24;
                6'h12: RGB_gate = 24'h342505;
                6'h13: RGB_gate = 24'h47450F;
                6'h14: RGB_gate = 24'h126401;
                6'h15: RGB_gate = 24'h064100;
                6'h16: RGB_gate = 24'h080000;
                6'h17: RGB_gate = 24'h1E0B05;
                6'h18: RGB_gate = 24'h893A1A;
                6'h19: RGB_gate = 24'h873B19;
                6'h1a: RGB_gate = 24'hB35A32;
                6'h1b: RGB_gate = 24'hF30000;
                6'h1c: RGB_gate = 24'h640000;
                6'h1d: RGB_gate = 24'hF35B5B;
					 default:RGB_gate = 24'hF400FF;
            endcase
	 end
	//ground palette translator
	 always_comb
	 begin
			case(Ground_palette) 
				6'h00: RGB_ground = 24'hF400FF;
                6'h01: RGB_ground = 24'hFFFFFE;
                6'h02: RGB_ground = 24'hC9C9C9;
                6'h03: RGB_ground = 24'h030303;
                6'h04: RGB_ground = 24'h1E1E1E; 
                6'h05: RGB_ground = 24'h474747; 
                6'h06: RGB_ground = 24'h3F0606; 
                6'h07: RGB_ground = 24'h880606; 
                6'h08: RGB_ground = 24'hAB0000; 
                6'h09: RGB_ground = 24'hA40000; 
                6'h0a: RGB_ground = 24'h5A2712; 
                6'h0b: RGB_ground = 24'hDF4426; 
                6'h0c: RGB_ground = 24'hFF0000; 
                6'h0d: RGB_ground = 24'hFFC78F; 
                6'h0e: RGB_ground = 24'hEFE300; 
                6'h0f: RGB_ground = 24'h154269; 
                6'h10: RGB_ground = 24'h323E92; 
                6'h11: RGB_ground = 24'hED1C24;
                6'h12: RGB_ground = 24'h342505;
                6'h13: RGB_ground = 24'h47450F;
                6'h14: RGB_ground = 24'h126401;
                6'h15: RGB_ground = 24'h064100;
                6'h16: RGB_ground = 24'h080000;
                6'h17: RGB_ground = 24'h1E0B05;
                6'h18: RGB_ground = 24'h893A1A;
                6'h19: RGB_ground = 24'h873B19;
                6'h1a: RGB_ground = 24'hB35A32;
                6'h1b: RGB_ground = 24'hF30000;
                6'h1c: RGB_ground = 24'h640000;
                6'h1d: RGB_ground = 24'hF35B5B;
					 default:RGB_ground = 24'h1051c9;
            endcase
	 end

    // Output colors to VGA
    assign VGA_R = Red;
    assign VGA_G = Green;
    assign VGA_B = Blue;
    
    // Assign color based on is_ball signal
    always_comb 
    begin
		  StayY_in = StayY;
        if((Type == IDLE || Type == WALKING)&&(RGB_data != 24'hf400ff)&&(RGB_killer != 24'hf400ff)&&is_killer)
            death_in = 0;
        else    
            death_in = death;

        if((Type == IDLE || Type == WALKING)&&(RGB_data == 24'hf400ff)&&(RGB_killer != 24'hf400ff)&&is_killer)
			begin
                Red = RGB_killer[23:16];
				Green =  RGB_killer[15:8];
				Blue = RGB_killer[7:0];
			end
        else if(((Type == IDLE || Type == WALKING) || (Type == GAMEOVER) || (Type == WINNER)||(Type == LIFECOUNT)||Type == BOSS_BULLET )&&(RGB_data == 24'hf400ff)&&(RGB_block != 24'hf400ff)&&is_block)
            begin
                Red = RGB_block[23:16];
				Green =  RGB_block[15:8];
				Blue = RGB_block[7:0];
            end
        else if((Type == IDLE || Type == WALKING) &&(RGB_data == 24'hf400ff)&&(RGB_gate != 24'hf400ff)&&is_MapEnd)
            begin
                Red = RGB_gate[23:16];
				Green =  RGB_gate[15:8];
				Blue = RGB_gate[7:0];
            end
         else if((Type == IDLE || Type == WALKING) &&(RGB_data == 24'hf400ff)&&(RGB_title != 24'hf400ff)&&is_title&&state_index==0)
            begin
                Red = RGB_title[23:16];
				Green =  RGB_title[15:8];
				Blue = RGB_title[7:0];
            end
        else if((Type!= GROUND) && (RGB_data != 24'hf400ff )) 
			  begin
				Red = RGB_data[23:16];
				Green =  RGB_data[15:8];
				Blue = RGB_data[7:0];
			  end
        else if(is_bullet)
			begin
                Red = 8'hff;
                Green = 8'hff;
                Blue = 8'hff;
			end
        else if(is_bar && state_index == 2)
			begin
                if(DrawX>320)
                    Red = 8'hff-(DrawX-10'd320)/4;
                else
                    Red = 8'hff-(10'd320-DrawX)/4;
                Green = 8'h00;
                Blue = 8'h00;
			end
        else 
			begin
				Red = 8'h10;
				Green = 8'h51+(6*DrawY)/25;
				Blue = 8'hc9;					
			end

		if(DrawX == Ball_X_Pos && DrawY == Ball_Y_Pos+10)
			begin
				if(Green!=8'h51+(6*DrawY)/25 && is_MapEnd==0 && is_apple==0&& is_spike==0)
    				in_air_in = 1'b0;
				else
					in_air_in = 1'b1;
			end
		else
			in_air_in = in_air;

		if(DrawX == Ball_X_Pos && DrawY == Ball_Y_Pos-10)
			begin
				if(is_block)
                begin
                    StayY_in = DrawY+1;
    			    top_in = 1'b1;
                end
				else
					top_in = 1'b0;
			end
		else
			top_in = top;

        if(direct)
            Ball_X_Pos_Co = Ball_X_Pos + 12;
        else
            Ball_X_Pos_Co = Ball_X_Pos - 12;

		if(DrawX == Ball_X_Pos_Co && DrawY == Ball_Y_Pos)
			begin
				if(is_block)
					blocked_in = 1'b1;
				else
					blocked_in = 1'b0;
			end
		else
			blocked_in = blocked;
    end 
        
endmodule
