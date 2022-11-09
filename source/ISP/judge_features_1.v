
module judge_features_1(
        
       input						        pixelclk,
	   input                                reset_n,
  	   input          [23:0]                i_rgb,
	   input						        i_hsync,
	   input							    i_vsync,
	   input							    i_de,

       input       [15:0]                   a2,	               
       input       [7:0]                    f1,
       input       [23:0]                   s1,
       input       [23:0]                   s2,
       input       [23:0]                   s3,
       input       [23:0]                   s4,
       input       [23:0]                   s5,
       input       [23:0]                   s6,
       input       [23:0]                   s7,
       input       [23:0]                   s8,
       input       [23:0]                   s9,
       input       [23:0]                   s10,
       input       [23:0]                   s11,
                   
       output      [3:0]                    sort,
       output      [23:0]                   o_rgb,
	   output							    o_hsync,
	   output							    o_vsync,                                                                                                  
	   output						        o_de




 );

reg[23:0]                 i_rgb_r;
	
reg                       hsync_r;
reg                       vsync_r;
reg                       de_r;
reg [3:0]                 sort1;
       
always @(posedge pixelclk) begin
  hsync_r <= i_hsync;
  vsync_r <= i_vsync;
  de_r    <= i_de;
  i_rgb_r <=i_rgb;

end

assign o_hsync = hsync_r;
assign o_vsync = vsync_r;
assign o_de    = de_r;
assign o_rgb   = i_rgb_r; 
assign sort=sort1;



always @(posedge pixelclk or negedge reset_n)

 begin

      if(!reset_n)
      
        sort1<=4'd0;
      else if(a2[7:0]<=8'h20) 

                      sort1<= 'd0;
        	
      
       else if(a2[15:8]==0&&a2[7:0]<=8'h88)  
     
       	         sort1<=4'd6;
                        
			   else begin
                     if(f1==8'h10||f1==8'h11||f1==8'h12||f1==8'h16)  begin

                        if(s1>s3&&s1>s6&&s1>s7&&s1>s8&&s1>s11) 

                          begin  
					    
                           sort1<=4'd1;

                           end
                        else  if(s3>s6&&s3>s7&&s3>s1&&s3>s8&&s3>s11)  
                        
  					       sort1<=4'd11;	
				       
                        else if(s8>s6&&s8>s3&&s8>s7&&s8>s1&&s8>s11) 
                          
					      sort1<=4'd2;
                       
                        else if(s11>s6&&s11>s7&&s11>s1&&s11>s1&&s11>s3) 

                          begin  
                       
                          sort1<=4'd10;
						  
                          end              
                        else  
                          
					      sort1<=4'd3;
                        end 
                  else if( 8'h19 <= f1 && f1 <=8'h20)  begin
				  
                       if(s4>s1&&s4>s11)  
                       
					   sort1<=4'd7;
                     
                      else if(s11>s4&&s11>s1)
                       
					   sort1<=4'd8;
                      
                      else 
                       
					   sort1<=4'd4; //3 6 7
                                   
                   end

		         else if(8'h13 <= f1 &&f1<=8'h15)  begin

                           sort1<=4'd9;


	                   end
					   
		        else  if( 8'h21 <= f1)  
                    
					sort1<=4'd5;
             			       			  
			 else  sort1 <= sort1 ;
        end
      
      end 


endmodule