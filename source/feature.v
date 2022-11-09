module feature(
input				   pixelclk,
input                  rst_n,
input       		   post01_img_Bit,	
input					 i_hs,
input					 i_vs,
input					 i_de,
input     [11:0]        hcount_l,
input     [11:0]        hcount_r,
input     [11:0]        vcount_l,
input     [11:0]        vcount_r,

output  reg     [22:0]       s0,
output          [15:0]       a2,
output          [7:0]        f1,
output          [7:0]        than

   );

reg    [15:0]              t11;
reg    [23:0]              t0;
wire   [15:0]              a;
wire   [15:0]              a_r;
reg    [15:0]              a1;
wire   [15:0]              b;
reg    [15:0]              b1;
wire   [23:0]              s01;
wire   [23:0]              s10;

reg           hs_r;
reg           vs_r;
reg           de_r;
reg           [23:0]       s1;
reg           [23:0]       s;
//reg           [23:0]       s0;
reg           [23:0]       t2;
wire          [7:0]        t3;

wire  TFT_VS_fall;
assign TFT_VS_fall = (!i_vs & (vs_r))?1'b1:1'b0;

always @(posedge pixelclk )

 begin

  hs_r    <= i_hs;
  vs_r    <= i_vs;
  de_r    <= i_de;

  
   end  

always @(posedge pixelclk or negedge rst_n)   
begin if(!rst_n) begin 
    
     a1<=1'b0;	 


	 end 
	 else begin 

	 a1<=hcount_r-hcount_l;	  

	 end
end

always @(posedge pixelclk or negedge rst_n)   
begin if(!rst_n) begin 
     
	 b1<=1'b0;

	 end 
	 else begin 

	 b1<=vcount_r-vcount_l;
	 end
end

assign a=(a1>b1)?a1:b1;
assign b=(a1>b1)?b1:a1;
assign a2=a;
assign a_r=a<<4;
assign f1=a_r/b;
assign s01=a*b;
assign than=t11[7:0]; 
assign s10=s01<<4;

always @(posedge pixelclk or negedge rst_n)     
begin
	if(!rst_n) begin 

     t11<=16'h8;

	 end 
     else if(s0>0)

       t11<=s10/s0;

     else t11<=t11;

   end

always @(posedge pixelclk or negedge rst_n)   
begin
	if(!rst_n) begin 
      s1<=1'b0;	 
	  s<=1'b0;
      s0<=1'b0;
	 end 
    else  if( TFT_VS_fall)begin 

        s0<=s1;

	    s<=1'b0;

		  end 
      else if(i_hs)  begin
        if(post01_img_Bit==1'b1)
         begin
            s <= s + 1'b1 ;
            s1 <= s ;
          end  
           else
            s <= s ;
        end 
         else  
             s<=s;

end



 
endmodule