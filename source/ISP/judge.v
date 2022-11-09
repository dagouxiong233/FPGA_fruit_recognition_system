module judge(
      input						           pixelclk,
	  input                                rstin,
	  input         [3:0]                  sort,
	  input         [3:0]                  sort1,
	  input         [3:0]                  sort2,
	  input         [3:0]                  sort3,
         
      output        reg        [7:0]                 number1,
      output        reg        [7:0]                 number2,
      output        reg        [7:0]                 number3,
      output        reg        [3:0]                 ca1,
      output        reg        [3:0]                 ca2,
      output        reg        [3:0]                 ca3


);
 					 
						 
always @(posedge pixelclk or negedge rstin)	
begin
	if(!rstin) begin 
   number1<=" ";
   number2<=" ";
   number3<=" ";
   ca1<=4'd0;
   ca2<=4'd0;
   ca3<=4'd0;
 end     
else if(sort>0&&sort1>0&&sort2>0&&sort3>0)
   begin
  if(sort==sort1&&sort==sort2&&sort==sort3) begin
   number1<="4";
   ca1<=sort;
   number2<=" ";
   ca2<=4'd0;
   number3<=" ";
   ca3<=4'd0;
  end
  else if(sort1==sort2&&sort1==sort3) begin
   number1<="3";
   ca1<=sort1;
   number2<="1";
   ca2<=sort;
   number3<=" ";
   ca3<=4'd0;
  end
 else if(sort==sort1&&sort==sort2) begin
   number1<= "3";
   ca1<=sort;
   number2<="1";
   ca2<=sort3;
   number3<=" ";
   ca3<=4'd0;
  end
 else if(sort==sort1&&sort==sort3) begin
   number1<="3";
   ca1<=sort;
   number2<="1";
   ca2<=sort2;
   number3<=" ";
   ca3<=4'd0;
  end
 else if(sort==sort2&&sort==sort3) begin
   number1<="3";
   ca1<=sort;
   number2<="1";
   ca2<=sort1;
   number3<=" ";
   ca3<=4'd0;
  end
 else if(sort==sort1&&sort2==sort3) begin
   number1<="2";
   ca1<=sort;
   number2<="2";
   ca2<=sort2;
   number3<=" ";
   ca3<=4'd0;
  end

 else if((sort==sort3&&sort1==sort2)||(sort==sort2&&sort1==sort3)) begin
   number1<="2";
   ca1<=sort;
   number2<="2";
   ca2<=sort1;
   number3<=" ";
   ca3<=4'd0;
  end

 else if(sort==sort2) begin
   number1<="2";
   ca1<=sort;
   number2<="1";
   ca2<=sort1;
   number3<="1";
   ca3<=sort3;
  end
 else if(sort==sort1) begin
   number1<="2";
   ca1<=sort;
   number2<="1";
   ca2<=sort2;
   number3<="1";
   ca3<=sort3;
  end
 else if(sort==sort3) begin
   number1<="2";
   ca1<=sort;
   number2<="1";
   ca2<=sort1;
   number3<="1";
   ca3<=sort2;
  end  
 else if(sort1==sort3) begin
   number1<="1";
   ca1<=sort;
   number2<="2";
   ca2<=sort1;
   number3<="1";
   ca3<=sort2;
  end    
 else if(sort1==sort2) begin
   number1<="1";
   ca1<=sort;
   number2<="2";
   ca2<=sort1;
   number3<="1";
   ca3<=sort3;
  end
  
 else if(sort2==sort3) begin
   number1<="1";
   ca1<=sort;
   number2<="1";
   ca2<=sort1;
   number3<="2";
   ca3<=sort2;
  end
 end 
else if(sort>0&&sort1>0&&sort2>0)begin
  if((sort!=sort1)&&(sort!=sort2)&&(sort1!=sort2))
  begin
   number1<="1";
   ca1<=sort;
   number2<="1";
   ca2<=sort1;
   number3<="1";
   ca3<=sort2;
  end
 else begin
 if((sort==sort1)&&(sort1==sort2)) begin
   number1<="3";
   ca1<=sort;
   number2<=" ";
   ca2<=4'd0;
 end
  else if(sort==sort2) begin
   number1<="2";
   ca1<=sort;
   number2<="1";
   ca2<=sort1;

  end
  else if(sort==sort1)begin
   number1<="2";
   ca1<=sort;
   number2<="1";
   ca2<=sort2;

  end
  else if(sort1==sort2) begin
   number1<="1";
   ca1<=sort;
   number2<="2";
   ca2<=sort1;

  end

   number3<=" ";
   ca3<=4'd0;  
end
 end
else if(sort>0&&sort1>0) begin
 if(sort==sort1) begin
   number1<="2";
   ca1<=sort;
   number2<=" ";
   ca2<=4'd0;

  end
  else 
    begin
     number1<="1";
     ca1<=sort;
     number2<="1";
     ca2<=sort1;
   end
     number3<=" ";
     ca3<=4'd0;
end
 else if(sort>0) begin
   number1<="1";
   ca1<=sort;
   number2<=" ";
   ca2<=4'd0;
   number3<=" ";
   ca3<=4'd0;
  end
 else begin
   number1<=number1;
   number2<=number2;
   number3<=number3;
   ca1<=ca1;
   ca2<=ca2;
   ca3<=ca3;
   end
end


endmodule