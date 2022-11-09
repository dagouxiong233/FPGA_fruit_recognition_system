module feature_1(
input				   pixelclk,
input                  rst_n,
input					 i_hs,
input					 i_vs,
input					 i_de,
input     [11:0]        hcount_l,
input     [11:0]        hcount_r,
input     [11:0]        vcount_l,
input     [11:0]        vcount_r,


output          [15:0]       a2,
output          [7:0]        f1
// output          [7:0]        than

   );

wire   [15:0]              a;
wire   [15:0]              a_r;
reg    [11:0]              a1;
wire   [11:0]              b;
reg    [11:0]              b1;
//wire   [23:0]              s01;



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
//assign s01=a*b;


 
endmodule