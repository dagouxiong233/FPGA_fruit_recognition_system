
`timescale 1ns/1ps
module  threshold_binary_0#(

          parameter DW        = 24 ,
          parameter Y_TH      = 225,
          parameter Y_TL      = 60 ,
          parameter CB_TH     = 141,
          parameter CB_TL     = 111,
          parameter CR_TH     = 139,
          parameter CR_TL     = 98 

)(
        input                            pixelclk   ,
        input                            reset_n    ,
        input [DW-1:0]                   i_ycbcr    ,
        input [DW-1:0]                   i_rgb      ,
        input                            i_hsync    ,
        input                            i_vsync    ,
        input                            i_de       ,
   
        
//        output [DW-1:0]                  o_binary   ,
        output [DW-1:0]                  o_rgb      ,
        output                           o_hsync    ,
        output                           o_vsync    , 
        output                           x0         ,
        output    reg                    en        ,
        output                           o_de                                                                                                
);


reg  [DW-1:0]           binary_r      ;
reg  [DW-1:0]           i_rgb_r       ;
                                     
reg                     h_sync_r      ;
reg                     v_sync_r      ;
reg                     de_r          ;
wire                    en0           ;
wire                    en1           ;
wire                    en2           ;


//assign o_binary = binary_r; 
assign o_rgb    = i_rgb_r;
assign o_hsync  = h_sync_r;
assign o_vsync  = v_sync_r;
assign o_de     = de_r;

////////////////////// threshold//////////////////////////////////////
assign en0        =i_ycbcr[23:16] >=Y_TL  && i_ycbcr[23:16] <= Y_TH;
assign en1        =i_ycbcr[15: 8] >=CB_TL && i_ycbcr[15: 8] <= CB_TH;
assign en2        =i_ycbcr[ 7: 0] >=CR_TL && i_ycbcr[ 7: 0] <= CR_TH;

/********************************************************************************************/

/***************************************timing***********************************************/

always @(posedge pixelclk)begin
    h_sync_r<= i_hsync;
    v_sync_r<= i_vsync;
    de_r    <= i_de;
    i_rgb_r <= i_rgb;
end 

/********************************************************************************************/

/***************************************Binarization threshold*******************************/
 
always @(posedge pixelclk or negedge reset_n) begin
    if(!reset_n)begin 
	
        binary_r <= 24'd15;
        en<=1'b0;
	   
    end 
    else begin 
        if(en0==1'b1 && en1 ==1'b1 && en2==1'b1) 
		begin 

          binary_r <= 24'h0;
          en<=1'b1;
			
        end   
        else begin
		
             binary_r<=24'h15;
             en<=1'b1;
        
        end 
    end  
end 
assign x0= (binary_r == 24'h0  )?1'b0:1'b1;

endmodule 