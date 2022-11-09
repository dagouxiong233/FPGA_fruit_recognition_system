module area_colour(
input					pixelclk,
input                   rst_n,
input                   en,
input                   i_binary,
input					i_hs,
input					i_vs,
input					i_de,



//output                  o_binary,
output    reg     [23:0]      s0


   );
reg            hs_r;
reg            vs_r;
reg            de_r;
reg   [23:0]   s1;
reg   [23:0]   s;
//reg   i_binary_r;
wire  TFT_VS_fall;
assign TFT_VS_fall = (!i_vs & (vs_r ))?1'b1:1'b0;
//assign o_binary=i_binary_r;

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
	
         if(i_binary==1'b0)
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


always @(posedge pixelclk)
  begin
  
  hs_r    <= i_hs;
  vs_r    <=i_vs;
  de_r    <= i_de;
//  i_binary_r<=i_binary;
  end 



 
endmodule