
`timescale 1ns/1ps
module  threshold_binary#(

        parameter DW        = 24 ,
        parameter Y_TH      = 225,
        parameter Y_TL      = 60 ,
        parameter CB_TH     = 141,
        parameter CB_TL     = 111,
        parameter CR_TH     = 139,
        parameter CR_TL     = 98 ,


//        parameter Y_TH_A    = 46 ,
//        parameter Y_TL_A    = 28 ,
//        parameter CB_TH_A   =127 ,
//        parameter CB_TL_A   =121,
//        parameter CR_TH_A   = 146 ,
//        parameter CR_TL_A   = 132,//apple

        parameter Y_TH_A    = 67 ,
        parameter Y_TL_A    = 26 ,
        parameter CB_TH_A   =127 ,
        parameter CB_TL_A   =120,
        parameter CR_TH_A   = 152 ,
        parameter CR_TL_A   = 130,//apple

        parameter Y_TH_B      = 97 ,
        parameter Y_TL_B      = 35  ,
        parameter CB_TH_B     = 119 ,
        parameter CB_TL_B     = 102,
        parameter CR_TH_B     = 144 ,
        parameter CR_TL_B     = 130,  //banna


//        parameter Y_TH_M      = 76,
//        parameter Y_TL_M      = 25  ,
//        parameter CB_TH_M     = 126 ,
//        parameter CB_TL_M     = 112,
//        parameter CR_TH_M     = 149 ,
//        parameter CR_TL_M     = 111 , //red mango
   
        parameter Y_TH_RM     = 64 ,
        parameter Y_TL_RM     = 21  ,
        parameter CB_TH_RM    = 131 ,
        parameter CB_TL_RM    = 118,
        parameter CR_TH_RM    = 127 ,
        parameter CR_TL_RM    = 107 ,//Red mangosteen

//        parameter Y_TH_M_1      =118 ,
//        parameter Y_TL_M_1      =20 ,
//        parameter CB_TH_M_1     = 125 ,
//        parameter CB_TL_M_1     = 104,
//        parameter CR_TH_M_1     = 151 ,
//        parameter CR_TL_M_1     = 131 ,               
//                                       //yellow mango
//
        parameter Y_TH_M_1      =182 ,
        parameter Y_TL_M_1      =46 ,
        parameter CB_TH_M_1     = 111 ,
        parameter CB_TL_M_1     = 74,
        parameter CR_TH_M_1     = 158 ,
        parameter CR_TL_M_1     = 129 ,               
                                       //yellow mango

        parameter Y_TH_M_2      = 77 ,
        parameter Y_TL_M_2      = 22 ,
        parameter CB_TH_M_2     = 126 ,
        parameter CB_TL_M_2     = 121,
        parameter CR_TH_M_2     = 124 ,
        parameter CR_TL_M_2     = 117 , //green mango

        parameter Y_TH_P      = 161 ,
        parameter Y_TL_P      = 55  ,
        parameter CB_TH_P     =113 ,
        parameter CB_TL_P     =80,
        parameter CR_TH_P     = 132,
        parameter CR_TL_P     = 122,   //Pear

        parameter Y_TH_P_1     = 174 ,
        parameter Y_TL_P_1     = 81  ,
        parameter CB_TH_P_1    = 94 ,
        parameter CB_TL_P_1    = 74,
        parameter CR_TH_P_1    = 128,
        parameter CR_TL_P_1    = 115,  //Milky Pear

//        parameter Y_TL_G3    = 43,
//        parameter Y_TH_G3    = 185,
//        parameter CB_TL_G3   = 65,
//        parameter CB_TH_G3   = 113,
//        parameter CR_TL_G3   = 74,
//        parameter CR_TH_G3   = 131,//Green apple  green pear  green mango


        parameter Y_TH_O     = 189 ,
        parameter Y_TL_O     = 31  ,
        parameter CB_TH_O    = 124 ,
        parameter CB_TL_O    = 94,
        parameter CR_TH_O    = 182 ,
        parameter CR_TL_O    = 143 ,//orange
//        parameter Y_TH_O     = 123 ,
//        parameter Y_TL_O     = 32  ,
//        parameter CB_TH_O    = 124 ,
//        parameter CB_TL_O    = 95  ,
//        parameter CR_TH_O    = 184 ,
//        parameter CR_TL_O    = 144 , 
 
        parameter Y_TH_G     = 75 ,
        parameter Y_TL_G     = 24  ,
        parameter CB_TH_G    = 127 ,
        parameter CB_TL_G    = 123,
        parameter CR_TH_G    = 142 ,
        parameter CR_TL_G    = 127 , //grape

//        parameter Y_TH_K     = 104  ,
//        parameter Y_TL_K     = 33   ,
//        parameter CB_TH_K    = 120  ,
//        parameter CB_TL_K    = 106   ,
//        parameter CR_TH_K    = 135 ,
//        parameter CR_TL_K    = 124,    //KKK


        parameter Y_TL_K     = 22,
        parameter Y_TH_K     = 51,
        parameter CB_TL_K    = 117,
        parameter CB_TH_K    = 130,
        parameter CR_TL_K    = 127,
        parameter CR_TH_K    = 138,//Fig

//        parameter Y_TL_Ma     = 23,
//        parameter Y_TH_Ma     = 89,
//        parameter CB_TL_Ma    = 101,
//        parameter CB_TH_Ma    = 132,
//        parameter CR_TL_Ma    = 92,
//        parameter CR_TH_Ma    = 128,//Red mangosteen

        parameter Y_TL_A1    = 43,
        parameter Y_TH_A1    = 185,
        parameter CB_TL_A1   = 65,
        parameter CB_TH_A1   = 113,
        parameter CR_TL_A1   = 74,
        parameter CR_TH_A1   = 131    //Green apple  green pear  green mango
//        parameter Y_TH_A1      = 70 ,
//        parameter Y_TL_A1      = 32 ,
//        parameter CB_TH_A1     = 123 ,
//        parameter CB_TL_A1     = 108,
//        parameter CR_TH_A1     = 121 ,
//        parameter CR_TL_A1     = 108 //green apple  


)(
        input                            pixelclk   ,
        input                            reset_n    ,
        input [DW-1:0]                   i_ycbcr    ,
        input [DW-1:0]                   i_rgb      ,
        input                            i_hsync    ,
        input                            i_vsync    ,
        input                            i_de       ,
   
        
        output [DW-1:0]                  o_binary   ,
        output [DW-1:0]                  o_rgb      ,
        output                           o_hsync    ,
        output                           o_vsync    , 
        output                           x0         ,
        output                           x1         ,
        output                           x2         ,
        output                           x3         ,
        output                           x4         ,
        output                           x5         ,
        output                           x6         ,
        output                           x7         ,
        output                           x8         ,
        output                           x9         ,
        output                           x10        ,
        output                           x11        ,
  


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
wire                    en0_a         ;
wire                    en1_a         ;
wire                    en2_a         ;
wire                    en0_a1         ;
wire                    en1_a1         ;
wire                    en2_a1         ;
wire                    en0_b         ;
wire                    en1_b         ;
wire                    en2_b         ;
wire                    en0_m         ;
wire                    en1_m         ;
wire                    en2_m         ;
wire                    en0_m_1       ;
wire                    en1_m_1       ;
wire                    en2_m_1       ;
wire                    en0_m_2       ;
wire                    en1_m_2       ;
wire                    en2_m_2       ;
wire                    en0_p         ;
wire                    en1_p         ;
wire                    en2_p         ;
wire                    en0_p_1       ;
wire                    en1_p_1       ;
wire                    en2_p_1       ;
wire                    en0_o         ;
wire                    en1_o         ;
wire                    en2_o         ;
wire                    en0_g         ;
wire                    en1_g         ;
wire                    en2_g         ;
wire                    en0_k         ;
wire                    en1_k         ;
wire                    en2_k         ;



assign o_binary = binary_r; 
assign o_rgb    = i_rgb_r;
assign o_hsync  = h_sync_r;
assign o_vsync  = v_sync_r;
assign o_de     = de_r;

////////////////////// threshold//////////////////////////////////////
assign en0        =i_ycbcr[23:16] >=Y_TL  && i_ycbcr[23:16] <= Y_TH;
assign en1        =i_ycbcr[15: 8] >=CB_TL && i_ycbcr[15: 8] <= CB_TH;
assign en2        =i_ycbcr[ 7: 0] >=CR_TL && i_ycbcr[ 7: 0] <= CR_TH;
assign en0_a      =i_ycbcr[23:16] >=Y_TL_A  && i_ycbcr[23:16] <= Y_TH_A;
assign en1_a      =i_ycbcr[15: 8] >=CB_TL_A && i_ycbcr[15: 8] <= CB_TH_A;
assign en2_a      =i_ycbcr[ 7: 0] >=CR_TL_A && i_ycbcr[ 7: 0] <= CR_TH_A;
assign en0_a1      =i_ycbcr[23:16] >=Y_TL_A1  && i_ycbcr[23:16] <= Y_TH_A1;
assign en1_a1      =i_ycbcr[15: 8] >=CB_TL_A1 && i_ycbcr[15: 8] <= CB_TH_A1;
assign en2_a1      =i_ycbcr[ 7: 0] >=CR_TL_A1 && i_ycbcr[ 7: 0] <= CR_TH_A1;
assign en0_b      =i_ycbcr[23:16] >=Y_TL_B && i_ycbcr[23:16] <= Y_TH_B  ;
assign en1_b      =i_ycbcr[15: 8] >=CB_TL_B && i_ycbcr[15: 8] <= CB_TH_B;
assign en2_b      =i_ycbcr[ 7: 0] >=CR_TL_B && i_ycbcr[ 7: 0] <= CR_TH_B;
assign en0_rm      =i_ycbcr[23:16] >=Y_TL_RM && i_ycbcr[23:16] <= Y_TH_RM  ;
assign en1_rm      =i_ycbcr[15: 8] >=CB_TL_RM && i_ycbcr[15: 8] <= CB_TH_RM;
assign en2_rm      =i_ycbcr[ 7: 0] >=CR_TL_RM && i_ycbcr[ 7: 0] <= CR_TH_RM;
assign en0_m_1    =i_ycbcr[23:16] >=Y_TL_M_1 && i_ycbcr[23:16] <= Y_TH_M_1  ;
assign en1_m_1    =i_ycbcr[15: 8] >=CB_TL_M_1 && i_ycbcr[15: 8] <= CB_TH_M_1;
assign en2_m_1    =i_ycbcr[ 7: 0] >=CR_TL_M_1 && i_ycbcr[ 7: 0] <= CR_TH_M_1;
assign en0_m_2    =i_ycbcr[23:16] >=Y_TL_M_2 && i_ycbcr[23:16] <= Y_TH_M_2  ;
assign en1_m_2    =i_ycbcr[15: 8] >=CB_TL_M_2 && i_ycbcr[15: 8] <= CB_TH_M_2;
assign en2_m_2    =i_ycbcr[ 7: 0] >=CR_TL_M_2 && i_ycbcr[ 7: 0] <= CR_TH_M_2;
assign en0_p      =i_ycbcr[23:16] >=Y_TL_P && i_ycbcr[23:16] <= Y_TH_P  ;
assign en1_p      =i_ycbcr[15: 8] >=CB_TL_P && i_ycbcr[15: 8] <= CB_TH_P;
assign en2_p      =i_ycbcr[ 7: 0] >=CR_TL_P && i_ycbcr[ 7: 0] <= CR_TH_P;
assign en0_p_1    =i_ycbcr[23:16] >=Y_TL_P_1 && i_ycbcr[23:16] <= Y_TH_P_1  ;
assign en1_p_1    =i_ycbcr[15: 8] >=CB_TL_P_1 && i_ycbcr[15: 8] <= CB_TH_P_1;
assign en2_p_1    =i_ycbcr[ 7: 0] >=CR_TL_P_1 && i_ycbcr[ 7: 0] <= CR_TH_P_1;
assign en0_o      =i_ycbcr[23:16] >=Y_TL_O && i_ycbcr[23:16] <= Y_TH_O  ;
assign en1_o      =i_ycbcr[15: 8] >=CB_TL_O && i_ycbcr[15: 8] <= CB_TH_O;
assign en2_o      =i_ycbcr[ 7: 0] >=CR_TL_O && i_ycbcr[ 7: 0] <= CR_TH_O;
assign en0_g      =i_ycbcr[23:16] >=Y_TL_G && i_ycbcr[23:16] <= Y_TH_G  ;
assign en1_g      =i_ycbcr[15: 8] >=CB_TL_G && i_ycbcr[15: 8] <= CB_TH_G;
assign en2_g      =i_ycbcr[ 7: 0] >=CR_TL_G && i_ycbcr[ 7: 0] <= CR_TH_G;
assign en0_k      =i_ycbcr[23:16] >=Y_TL_K && i_ycbcr[23:16] <= Y_TH_K  ;
assign en1_k      =i_ycbcr[15: 8] >=CB_TL_K && i_ycbcr[15: 8] <= CB_TH_K;
assign en2_k      =i_ycbcr[ 7: 0] >=CR_TL_K && i_ycbcr[ 7: 0] <= CR_TH_K;
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


	   
    end 
    else begin 
        if(en0==1'b1 && en1 ==1'b1 && en2==1'b1) begin 

          binary_r <= 24'h0;


        end 
		else if(en0_a==1'b1 && en1_a ==1'b1 && en2_a==1'b1)begin 

           binary_r <= 24'h1;       
		 	


		end 		 	            
		else if(en0_b==1'b1 && en1_b ==1'b1 && en2_b==1'b1)begin 

            binary_r <= 24'h2;       
		 	


		end 		 	
		else if(en0_rm==1'b1 && en1_rm ==1'b1 && en2_rm==1'b1)begin         
		 	
              binary_r <= 24'h3;


		end
      else if(en0_m_1==1'b1 && en1_m_1 ==1'b1 && en2_m_1==1'b1)begin         
		 	
              binary_r <= 24'h4;


		end
     else if(en0_m_2==1'b1 && en1_m_2 ==1'b1 && en2_m_2==1'b1)begin         
	  	
           binary_r <= 24'h5;


	 end
     else if(en0_p==1'b1 && en1_p ==1'b1 && en2_p==1'b1)begin         
	  	
           binary_r <= 24'h6;

	 end    
     else if(en0_p_1==1'b1 && en1_p_1 ==1'b1 && en2_p_1==1'b1)begin         
	  	
           binary_r <= 24'h7;

	 end  
     else if(en0_o==1'b1 && en1_o ==1'b1 && en2_o==1'b1)begin         
	  	
           binary_r <= 24'h8;


	 end  
     else if(en0_g==1'b1 && en1_g ==1'b1 && en2_g==1'b1)begin         
	  	
           binary_r <= 24'h9;

	 end  
     else if(en0_k==1'b1 && en1_k ==1'b1 && en2_k==1'b1)begin         
	  	
           binary_r <= 24'h10;

	 end
		else if(en0_a1==1'b1 && en1_a1 ==1'b1 && en2_a1==1'b1)begin 

           binary_r <= 24'h11;       
		 	

		end 
  
        else begin 

             binary_r<=24'h15;

 
           
        end 
    end  
end 
assign x0= (binary_r == 24'h0  )?1'b0:1'b1;
assign x1= (binary_r == 24'h1  )?1'b0:1'b1;
assign x2= (binary_r == 24'h2  )?1'b0:1'b1;
assign x3= (binary_r == 24'h3  )?1'b0:1'b1;
assign x4= (binary_r == 24'h4  )?1'b0:1'b1;
assign x5= (binary_r == 24'h5  )?1'b0:1'b1;
assign x6= (binary_r == 24'h6  )?1'b0:1'b1;
assign x7= (binary_r == 24'h7  )?1'b0:1'b1;
assign x8= (binary_r == 24'h8  )?1'b0:1'b1;
assign x9= (binary_r == 24'h9  )?1'b0:1'b1;
assign x10=(binary_r == 24'h10 )?1'b0:1'b1;
assign x11=(binary_r == 24'h11 )?1'b0:1'b1;

endmodule 