module uart_test(
input                           sys_clk,
input                           rst_n,
input                           uart_rx,
input     [7:0]                 rx_data1,
input     [7:0]                 rx_data2,
input     [7:0]                 rx_data3,
input     [3:0]                 sort1,
input     [3:0]                 sort2,
input     [3:0]                 sort3,

output                          uart_tx
);

parameter                      CLK_FRE = 50;//Mhz
localparam                       IDLE =  0;
localparam                       SEND =  1;   //send HELLO ALINX\r\n
localparam                       WAIT =  2;   //wait 1 second and send uart received data
//reg [2:0]                        number1;
//reg [2:0]                        number2;
//reg [2:0]                        number3;
reg[7:0]                         tx_data;
reg[7:0]                         tx_str/*synthesis syn_keep=1*/;
reg                              tx_data_valid;
wire                             tx_data_ready;
reg[7:0]                         tx_cnt;
reg[4:0]                         tx_cnt1;
reg[4:0]                         tx_cnt2;  
reg[4:0]                         tx_cnt3;
reg[4:0]                         tx_cnt4;
reg[4:0]                         tx_cnt5;
reg[4:0]                         tx_cnt6; 

wire                             rx_data_valid;
wire                             rx_data_ready;
reg[31:0]                        wait_cnt;
reg[3:0]                         state;

assign rx_data_ready = 1'b1;//always can receive data,
							//if HELLO ALINX\r\n is being sent, the received data is discarded

always@(posedge sys_clk or negedge rst_n)
begin
	if(rst_n == 1'b0)
	begin
		wait_cnt <= 32'd0;
		tx_data <= 8'd0;
		state <= IDLE;
		tx_cnt <= 8'd0;
		tx_data_valid <= 1'b0;
	end
	else
	case(state)
		IDLE:
			state <= SEND;
		SEND:
		begin
			wait_cnt <= 32'd0;
			tx_data <= tx_str;
			if(tx_data_valid == 1'b1 && tx_data_ready == 1'b1 && tx_cnt < 8'd76)//Send 12 bytes data
			begin
  
                 if(tx_cnt1<5'd2) begin

                    tx_cnt1<=tx_cnt1+1'b1;

                   end
                 else  if(tx_cnt1==5'd2&&tx_cnt2<5'd23) begin

                    tx_cnt2<=tx_cnt2+1'b1;

                   end
                 else if(tx_cnt2==5'd23&&tx_cnt3<5'd3) begin

                    tx_cnt3<=tx_cnt3+1'b1;

                   end
                 else if(tx_cnt3==5'd3&&tx_cnt4<5'd23) begin

                    tx_cnt4<=tx_cnt4+1'b1;

                   end
                 else if(tx_cnt4==5'd23&&tx_cnt5<5'd3) begin

                    tx_cnt5<=tx_cnt5+1'b1;

                   end
                 else if(5'd3==tx_cnt5&&tx_cnt6<5'd23) begin

                    tx_cnt6<=tx_cnt6+1'b1;

                   end
				tx_cnt <= tx_cnt + 8'd1; //Send data counter
			end
			else if(tx_data_valid && tx_data_ready)//last byte sent is complete
			begin
				tx_cnt <=8'd0;
                tx_cnt1<=5'd0;
                tx_cnt2<=5'd0;  
                tx_cnt3<=5'd0;
                tx_cnt4<=5'd0;
                tx_cnt5<=5'd0;
                tx_cnt6<=5'd0; 
				tx_data_valid <= 1'b0;
				state <= WAIT;
			end
			else if(~tx_data_valid)
			begin
				tx_data_valid <= 1'b1;
			end
		end
		WAIT:
		begin

	    wait_cnt <= wait_cnt + 32'd1;

        if(wait_cnt >= CLK_FRE * 1250000) // wait for 1.0 second
				begin
                state <= SEND;

               end
           end
		default:
			state <= IDLE;
	endcase
end


//always@(*)
//begin 
//  if(tx_cnt1<5'd3) 
//    
//	 case(tx_cnt1)
//
//		5'd0 : tx_str <=rx_data1;
//
//		default:tx_str <= 8'd0;
//        endcase
// end

always@(*)
begin 
  if(tx_cnt1<5'd2) 
    
	 case(tx_cnt1)

		5'd0 : tx_str <=rx_data1;
	    5'd1:  tx_str <= " ";
		5'd2:  tx_str <= " ";
		default:tx_str <= 8'd0;
        endcase
     
else 
   if(tx_cnt1==5'd2&&tx_cnt2<5'd23)
    begin
     if(sort1==4'd1)begin  
	  case(tx_cnt2)

		5'd0 :  tx_str <= "r";
		5'd1 :  tx_str <= "e";
		5'd2 :  tx_str <= "d";
		5'd3 :  tx_str <= " ";
		5'd4 :  tx_str <= "a";
		5'd5 :  tx_str <= "p";
		5'd6 :  tx_str <= "p";
		5'd7 :  tx_str <= "l";
		5'd8 :  tx_str <= "e";
		5'd9 :  tx_str <= " ";
		5'd10:  tx_str <= " ";
		5'd11:  tx_str <= " ";
		5'd12:  tx_str <= " ";
	    5'd13:  tx_str <= " ";
		5'd14:  tx_str <= " ";
		5'd15 :  tx_str <= " ";
		5'd16 :  tx_str <= " ";
		5'd17 :  tx_str <= " ";
		5'd18 :  tx_str <= " ";
		5'd19 :  tx_str <= " ";
		5'd20 :  tx_str <= " ";
	    5'd21:  tx_str <=  "\r";
		5'd22:  tx_str <=  "\n";
		5'd23 :  tx_str <= " ";
		default:tx_str <= 8'd0;
        endcase
       end
      if(sort1==4'd2)begin
       case(tx_cnt2)
		5'd0 :  tx_str <= "r";
		5'd1 :  tx_str <= "e";
		5'd2 :  tx_str <= "d";
		5'd3 :  tx_str <= " ";
		5'd4 :  tx_str <= " ";
		5'd5 :  tx_str <= " ";
		5'd6 :  tx_str <= " ";
		5'd7 :  tx_str <= "o";
		5'd8 :  tx_str <= "r";
		5'd9 :  tx_str <= "a";
		5'd10:  tx_str <= "n";
	    5'd11:  tx_str <= "g";
		5'd12:  tx_str <= "e";
	    5'd13:  tx_str <= " ";
		5'd14:  tx_str <= " ";
		5'd15 :  tx_str <= " ";
		5'd16 :  tx_str <= " ";
		5'd17 :  tx_str <= " ";
		5'd18 :  tx_str <= " ";
		5'd19 :  tx_str <= " ";
		5'd20 :  tx_str <= " ";
	    5'd21:  tx_str <=  "\r";
		5'd22:  tx_str <=  "\n";
		5'd23 :  tx_str <= " ";
		default:tx_str <= 8'd0;
	    endcase
        end
      if(sort1==4'd3)begin
       case(tx_cnt2)
		5'd0 :  tx_str <= "y";
		5'd1 :  tx_str <= "e";
		5'd2 :  tx_str <= "l";
		5'd3 :  tx_str <= "l";
		5'd4 :  tx_str <= "o";
		5'd5 :  tx_str <= "w";
		5'd6 :  tx_str <= " ";
		5'd7 :  tx_str <= "p";
		5'd8 :  tx_str <= "e";
		5'd9 :  tx_str <= "a";
		5'd10:  tx_str <= "r";
	    5'd11:  tx_str <= " ";
		5'd12:  tx_str <= " ";
	    5'd13:  tx_str <= " ";
		5'd14:  tx_str <= " ";
		5'd15 :  tx_str <= " ";
		5'd16 :  tx_str <= " ";
		5'd17 :  tx_str <= " ";
		5'd18 :  tx_str <= " ";
		5'd19 :  tx_str <= " ";
		5'd20 :  tx_str <= " ";
	    5'd21:  tx_str <=  "\r";
		5'd22:  tx_str <=  "\n";
		5'd23 :  tx_str <= " ";
		default:tx_str <= 8'd0;
	    endcase
        end
      if(sort1==4'd4)begin
       case(tx_cnt2)
		5'd0 :  tx_str <= " ";
		5'd1 :  tx_str <= "r";
		5'd2 :  tx_str <= "e";
		5'd3 :  tx_str <= "d";
		5'd4 :  tx_str <= " ";
		5'd5 :  tx_str <= " ";
		5'd6 :  tx_str <= " ";
		5'd7 :  tx_str <= "p";
		5'd8 :  tx_str <= "i";
		5'd9 :  tx_str <= "t";
		5'd10:  tx_str <= "a";
	    5'd11:  tx_str <= "y";
		5'd12:  tx_str <= "a";
	    5'd13:  tx_str <= " ";
		5'd14:  tx_str <= " ";
		5'd15 :  tx_str <= " ";
		5'd16 :  tx_str <= " ";
		5'd17 :  tx_str <= " ";
		5'd18 :  tx_str <= " ";
		5'd19 :  tx_str <= " ";
		5'd20 :  tx_str <= " ";
	    5'd21:  tx_str <=  "\r";
		5'd22:  tx_str <=  "\n";
		5'd23 :  tx_str <= " ";
		default:tx_str <= 8'd0;
	    endcase
        end
      if(sort1==4'd5)begin
       case(tx_cnt2)
		5'd0 :  tx_str <= "y";
		5'd1 :  tx_str <= "e";
		5'd2 :  tx_str <= "l";
		5'd3 :  tx_str <= "l";
		5'd4 :  tx_str <= "o";
		5'd5 :  tx_str <= "w";
		5'd6 :  tx_str <= " ";
		5'd7 :  tx_str <= " ";
		5'd8 :  tx_str <= "b";
		5'd9 :  tx_str <= "a";
		5'd10:  tx_str <= "n";
	    5'd11:  tx_str <= "n";
		5'd12:  tx_str <= "a";
	    5'd13:  tx_str <= " ";
		5'd14:  tx_str <= " ";
		5'd15 :  tx_str <= " ";
		5'd16 :  tx_str <= " ";
		5'd17 :  tx_str <= " ";
		5'd18 :  tx_str <= " ";
		5'd19 :  tx_str <= " ";
		5'd20 :  tx_str <= " ";
	    5'd21:  tx_str <=  "\r";
		5'd22:  tx_str <=  "\n";
		5'd23 :  tx_str <= " ";
		default:tx_str <= 8'd0;
	    endcase
        end
      if(sort1==4'd6)begin
       case(tx_cnt2)
		5'd0 :  tx_str <= "p";
		5'd1 :  tx_str <= "u";
		5'd2 :  tx_str <= "r";
		5'd3 :  tx_str <= "p";
		5'd4 :  tx_str <= "l";
		5'd5 :  tx_str <= "e";
		5'd6 :  tx_str <= " ";
		5'd7 :  tx_str <= " ";
		5'd8 :  tx_str <= "g";
		5'd9 :  tx_str <= "r";
		5'd10:  tx_str <= "a";
	    5'd11:  tx_str <= "p";
		5'd12:  tx_str <= "e";
	    5'd13:  tx_str <= " ";
		5'd14:  tx_str <= " ";
		5'd15 :  tx_str <= " ";
		5'd16 :  tx_str <= " ";
		5'd17 :  tx_str <= " ";
		5'd18 :  tx_str <= " ";
		5'd19 :  tx_str <= " ";
		5'd20 :  tx_str <= " ";
	    5'd21:  tx_str <=  "\r";
		5'd22:  tx_str <=  "\n";
		5'd23 :  tx_str <= " ";
		default:tx_str <= 8'd0;
	    endcase
        end
      if(sort1==4'd7)begin
       case(tx_cnt2)
		5'd0 :  tx_str <= "y";
		5'd1 :  tx_str <= "e";
		5'd2 :  tx_str <= "l";
		5'd3 :  tx_str <= "l";
		5'd4 :  tx_str <= "o";
		5'd5 :  tx_str <= "w";
		5'd6 :  tx_str <= " ";
		5'd7 :  tx_str <= " ";
		5'd8 :  tx_str <= "m";
		5'd9 :  tx_str <= "a";
		5'd10:  tx_str <= "n";
	    5'd11:  tx_str <= "g";
		5'd12:  tx_str <= "o";
	    5'd13:  tx_str <= " ";
		5'd14:  tx_str <= " ";
		5'd15 :  tx_str <= " ";
		5'd16 :  tx_str <= " ";
		5'd17 :  tx_str <= " ";
		5'd18 :  tx_str <= " ";
		5'd19 :  tx_str <= " ";
		5'd20 :  tx_str <= " ";
	    5'd21:  tx_str <=  "\r";
		5'd22:  tx_str <=  "\n";
		5'd23 :  tx_str <= " ";
		default:tx_str <= 8'd0;
	    endcase
        end
      if(sort1==4'd8)begin
       case(tx_cnt2)
		5'd0 :  tx_str <= " ";
		5'd1 :  tx_str <= "g";
		5'd2 :  tx_str <= "r";
		5'd3 :  tx_str <= "e";
		5'd4 :  tx_str <= "e";
		5'd5 :  tx_str <= "n";
		5'd6 :  tx_str <= " ";
		5'd7 :  tx_str <= " ";
		5'd8 :  tx_str <= "m";
		5'd9 :  tx_str <= "a";
		5'd10:  tx_str <= "n";
	    5'd11:  tx_str <= "g";
		5'd12:  tx_str <= "o";
	    5'd13:  tx_str <= " ";
		5'd14:  tx_str <= " ";
		5'd15 :  tx_str <= " ";
		5'd16 :  tx_str <= " ";
		5'd17 :  tx_str <= " ";
		5'd18 :  tx_str <= " ";
		5'd19 :  tx_str <= " ";
		5'd20 :  tx_str <= " ";
	    5'd21:  tx_str <=  "\r";
		5'd22:  tx_str <=  "\n";
		5'd23 :  tx_str <= " ";
		default:tx_str <= 8'd0;
	    endcase
        end
      if(sort1==4'd9)begin
       case(tx_cnt2)
		5'd0 :  tx_str <= "b";
		5'd1 :  tx_str <= "r";
		5'd2 :  tx_str <= "o";
		5'd3 :  tx_str <= "w";
		5'd4 :  tx_str <= "n";
		5'd5 :  tx_str <= " ";
		5'd6 :  tx_str <= " ";
		5'd7 :  tx_str <= " ";
		5'd8 :  tx_str <= "k";
		5'd9 :  tx_str <= "i";
		5'd10:  tx_str <= "w";
	    5'd11:  tx_str <= "i";
		5'd12:  tx_str <= " ";
		5'd13 :  tx_str <= " ";
		5'd14 :  tx_str <= " ";
		5'd15 :  tx_str <= "f";
		5'd16 :  tx_str <= "r";
		5'd17 :  tx_str <= "u";
		5'd18 :  tx_str <= "i";
		5'd19 :  tx_str <= "t";
		5'd20 :  tx_str <= " ";
	    5'd21:  tx_str <= "\r";
		5'd22:  tx_str <= "\n";
		5'd23 :  tx_str <= " ";
		default:tx_str <= 8'd0;
	    endcase
        end
      if(sort1==4'd10)begin
       case(tx_cnt2)
		5'd0 :  tx_str <= " ";
		5'd1 :  tx_str <= "g";
		5'd2 :  tx_str <= "r";
		5'd3 :  tx_str <= "e";
		5'd4 :  tx_str <= "e";
		5'd5 :  tx_str <= "n";
		5'd6 :  tx_str <= " ";
		5'd7 :  tx_str <= "a";
		5'd8 :  tx_str <= "p";
		5'd9 :  tx_str <= "p";
		5'd10:  tx_str <= "l";
	    5'd11:  tx_str <= "e";
		5'd12:  tx_str <= " ";
	    5'd13:  tx_str <= " ";
		5'd14:  tx_str <= " ";
		5'd15 :  tx_str <= " ";
		5'd16 :  tx_str <= " ";
		5'd17 :  tx_str <= " ";
		5'd18 :  tx_str <= " ";
		5'd19 :  tx_str <= " ";
		5'd20 :  tx_str <= " ";
	    5'd21:  tx_str <=  "\r";
		5'd22:  tx_str <=  "\n";
		5'd23 :  tx_str <= " ";
		default:tx_str <= 8'd0;
	    endcase
        end
      if(sort1==4'd11)begin
       case(tx_cnt2)
		5'd0 :  tx_str <= "r";
		5'd1 :  tx_str <= "e";
		5'd2 :  tx_str <= "d";
		5'd3 :  tx_str <= " ";
		5'd4 :  tx_str <= "m";
		5'd5 :  tx_str <= "a";
		5'd6 :  tx_str <= "n";
		5'd7 :  tx_str <= "g";
		5'd8 :  tx_str <= "o";
		5'd9 :  tx_str <= "s";
		5'd10:  tx_str <= "t";
	    5'd11:  tx_str <= "e";
		5'd12:  tx_str <= "e";
	    5'd13:  tx_str <= "n";
		5'd14:  tx_str <= " ";
		5'd15 :  tx_str <=" ";
		5'd16 :  tx_str <= " ";
		5'd17 :  tx_str <= " ";
		5'd18 :  tx_str <= " ";
		5'd19 :  tx_str <= " ";
		5'd20 :  tx_str <= " ";
	    5'd21:  tx_str <=  "\r";
		5'd22:  tx_str <=  "\n";
		5'd23 :  tx_str <= " ";
		default:tx_str <= 8'd0;
	    endcase
        end
      if(sort1==4'd12)begin
       case(tx_cnt2)
		5'd0 :  tx_str <= "g";
		5'd1 :  tx_str <= "r";
		5'd2 :  tx_str <= "e";
		5'd3 :  tx_str <= "e";
		5'd4 :  tx_str <= "n";
		5'd5 :  tx_str <= " ";
		5'd6 :  tx_str <= " ";
		5'd7 :  tx_str <= "p";
		5'd8 :  tx_str <= "e";
		5'd9 :  tx_str <= "a";
		5'd10:  tx_str <= "r";
	    5'd11:  tx_str <= " ";
		5'd12:  tx_str <= " ";
	    5'd13:  tx_str <= " ";
		5'd14:  tx_str <= " ";
		5'd15 :  tx_str <= " ";
		5'd16 :  tx_str <= " ";
		5'd17 :  tx_str <= " ";
		5'd18 :  tx_str <= " ";
		5'd19 :  tx_str <= " ";
		5'd20 :  tx_str <= " ";
	    5'd21:  tx_str <=  "\r";
		5'd22:  tx_str <=  "\n";
		5'd23 :  tx_str <= " ";
		default:tx_str <= 8'd0;
	    endcase
        end
      if(sort1==4'd13)begin
       case(tx_cnt2)
		5'd0 :  tx_str <= "m";
		5'd1 :  tx_str <= "a";
		5'd2 :  tx_str <= "r";
		5'd3 :  tx_str <= "o";
		5'd4 :  tx_str <= "o";
		5'd5 :  tx_str <= "n";
		5'd6 :  tx_str <= " ";
		5'd7 :  tx_str <= " ";
		5'd8 :  tx_str <= "f";
		5'd9 :  tx_str <= "i";
		5'd10:  tx_str <= "g";
	    5'd11:  tx_str <= " ";
		5'd12:  tx_str <= " ";
	    5'd13:  tx_str <= " ";
		5'd14:  tx_str <= " ";
		5'd15 :  tx_str <= " ";
		5'd16 :  tx_str <= " ";
		5'd17 :  tx_str <= " ";
		5'd18 :  tx_str <= " ";
		5'd19 :  tx_str <= " ";
		5'd20 :  tx_str <= " ";
	    5'd21:  tx_str <=  "\r";
		5'd22:  tx_str <=  "\n";
		5'd23 :  tx_str <= " ";
		default:tx_str <= 8'd0;
	    endcase
        end
     end
 else if(tx_cnt2==5'd23&&tx_cnt3<5'd3)  

	 case(tx_cnt3)

		5'd0 : tx_str <=rx_data2;
	    5'd1:  tx_str <= " ";
		5'd2:  tx_str <= " ";
		default:tx_str <= 8'd0;
        endcase

             
else if(tx_cnt3==5'd3&&tx_cnt4<5'd23)
    begin
     if(sort2==4'd0)begin  
	  case(tx_cnt4)

		5'd0 :  tx_str <= " ";
		5'd1 :  tx_str <= " ";
		5'd2 :  tx_str <= " ";
		5'd3 :  tx_str <= " ";
		5'd4 :  tx_str <= " ";
		5'd5 :  tx_str <= " ";
		5'd6 :  tx_str <= " ";
		5'd7 :  tx_str <= " ";
		5'd8 :  tx_str <= " ";
		5'd9 :  tx_str <= " ";
		5'd10:  tx_str <= " ";
		5'd11:  tx_str <= " ";
		5'd12:  tx_str <= " ";
	    5'd13:  tx_str <= " ";
		5'd14:  tx_str <= " ";
		5'd15 :  tx_str <= " ";
		5'd16 :  tx_str <= " ";
		5'd17 :  tx_str <= " ";
		5'd18 :  tx_str <= " ";
		5'd19 :  tx_str <= " ";
		5'd20 :  tx_str <= " ";
	    5'd21:  tx_str <=  "\r";
		5'd22:  tx_str <=  "\n";
		5'd23 :  tx_str <= " ";
		default:tx_str <= 8'd0;
        endcase
       end
     if(sort2==4'd1)begin  
	  case(tx_cnt4)

		5'd0 :  tx_str <= "r";
		5'd1 :  tx_str <= "e";
		5'd2 :  tx_str <= "d";
		5'd3 :  tx_str <= " ";
		5'd4 :  tx_str <= "a";
		5'd5 :  tx_str <= "p";
		5'd6 :  tx_str <= "p";
		5'd7 :  tx_str <= "l";
		5'd8 :  tx_str <= "e";
		5'd9 :  tx_str <= " ";
		5'd10:  tx_str <= " ";
		5'd11:  tx_str <= " ";
		5'd12:  tx_str <= " ";
	    5'd13:  tx_str <= " ";
		5'd14:  tx_str <= " ";
		5'd15 :  tx_str <= " ";
		5'd16 :  tx_str <= " ";
		5'd17 :  tx_str <= " ";
		5'd18 :  tx_str <= " ";
		5'd19 :  tx_str <= " ";
		5'd20 :  tx_str <= " ";
	    5'd21:  tx_str <=  "\r";
		5'd22:  tx_str <=  "\n";
		5'd23 :  tx_str <= " ";
		default:tx_str <= 8'd0;
        endcase
       end
      if(sort2==4'd2)begin
       case(tx_cnt4)
		5'd0 :  tx_str <= "r";
		5'd1 :  tx_str <= "e";
		5'd2 :  tx_str <= "d";
		5'd3 :  tx_str <= " ";
		5'd4 :  tx_str <= " ";
		5'd5 :  tx_str <= " ";
		5'd6 :  tx_str <= " ";
		5'd7 :  tx_str <= "o";
		5'd8 :  tx_str <= "r";
		5'd9 :  tx_str <= "a";
		5'd10:  tx_str <= "n";
	    5'd11:  tx_str <= "g";
		5'd12:  tx_str <= "e";
	    5'd13:  tx_str <= " ";
		5'd14:  tx_str <= " ";
		5'd15 :  tx_str <= " ";
		5'd16 :  tx_str <= " ";
		5'd17 :  tx_str <= " ";
		5'd18 :  tx_str <= " ";
		5'd19 :  tx_str <= " ";
		5'd20 :  tx_str <= " ";
	    5'd21:  tx_str <=  "\r";
		5'd22:  tx_str <=  "\n";
		5'd23 :  tx_str <= " ";
		default:tx_str <= 8'd0;
	    endcase
        end
      if(sort2==4'd3)begin
       case(tx_cnt4)
		5'd0 :  tx_str <= "y";
		5'd1 :  tx_str <= "e";
		5'd2 :  tx_str <= "l";
		5'd3 :  tx_str <= "l";
		5'd4 :  tx_str <= "o";
		5'd5 :  tx_str <= "w";
		5'd6 :  tx_str <= " ";
		5'd7 :  tx_str <= "p";
		5'd8 :  tx_str <= "e";
		5'd9 :  tx_str <= "a";
		5'd10:  tx_str <= "r";
	    5'd11:  tx_str <= " ";
		5'd12:  tx_str <= " ";
	    5'd13:  tx_str <= " ";
		5'd14:  tx_str <= " ";
		5'd15 :  tx_str <= " ";
		5'd16 :  tx_str <= " ";
		5'd17 :  tx_str <= " ";
		5'd18 :  tx_str <= " ";
		5'd19 :  tx_str <= " ";
		5'd20 :  tx_str <= " ";
	    5'd21:  tx_str <=  "\r";
		5'd22:  tx_str <=  "\n";
		5'd23 :  tx_str <= " ";
		default:tx_str <= 8'd0;
	    endcase
        end
      if(sort2==4'd4)begin
       case(tx_cnt4)
		5'd0 :  tx_str <= " ";
		5'd1 :  tx_str <= "r";
		5'd2 :  tx_str <= "e";
		5'd3 :  tx_str <= "d";
		5'd4 :  tx_str <= " ";
		5'd5 :  tx_str <= " ";
		5'd6 :  tx_str <= " ";
		5'd7 :  tx_str <= "p";
		5'd8 :  tx_str <= "i";
		5'd9 :  tx_str <= "t";
		5'd10:  tx_str <= "a";
	    5'd11:  tx_str <= "y";
		5'd12:  tx_str <= "a";
	    5'd13:  tx_str <= " ";
		5'd14:  tx_str <= " ";
		5'd15 :  tx_str <= " ";
		5'd16 :  tx_str <= " ";
		5'd17 :  tx_str <= " ";
		5'd18 :  tx_str <= " ";
		5'd19 :  tx_str <= " ";
		5'd20 :  tx_str <= " ";
	    5'd21:  tx_str <=  "\r";
		5'd22:  tx_str <=  "\n";
		5'd23 :  tx_str <= " ";
		default:tx_str <= 8'd0;
	    endcase
        end
      if(sort2==4'd5)begin
       case(tx_cnt4)
		5'd0 :  tx_str <= "y";
		5'd1 :  tx_str <= "e";
		5'd2 :  tx_str <= "l";
		5'd3 :  tx_str <= "l";
		5'd4 :  tx_str <= "o";
		5'd5 :  tx_str <= "w";
		5'd6 :  tx_str <= " ";
		5'd7 :  tx_str <= " ";
		5'd8 :  tx_str <= "b";
		5'd9 :  tx_str <= "a";
		5'd10:  tx_str <= "n";
	    5'd11:  tx_str <= "n";
		5'd12:  tx_str <= "a";
	    5'd13:  tx_str <= " ";
		5'd14:  tx_str <= " ";
		5'd15 :  tx_str <= " ";
		5'd16 :  tx_str <= " ";
		5'd17 :  tx_str <= " ";
		5'd18 :  tx_str <= " ";
		5'd19 :  tx_str <= " ";
		5'd20 :  tx_str <= " ";
	    5'd21:  tx_str <=  "\r";
		5'd22:  tx_str <=  "\n";
		5'd23 :  tx_str <= " ";
		default:tx_str <= 8'd0;
	    endcase
        end
      if(sort2==4'd6)begin
       case(tx_cnt4)
		5'd0 :  tx_str <= "p";
		5'd1 :  tx_str <= "u";
		5'd2 :  tx_str <= "r";
		5'd3 :  tx_str <= "p";
		5'd4 :  tx_str <= "l";
		5'd5 :  tx_str <= "e";
		5'd6 :  tx_str <= " ";
		5'd7 :  tx_str <= " ";
		5'd8 :  tx_str <= "g";
		5'd9 :  tx_str <= "r";
		5'd10:  tx_str <= "a";
	    5'd11:  tx_str <= "p";
		5'd12:  tx_str <= "e";
	    5'd13:  tx_str <= " ";
		5'd14:  tx_str <= " ";
		5'd15 :  tx_str <= " ";
		5'd16 :  tx_str <= " ";
		5'd17 :  tx_str <= " ";
		5'd18 :  tx_str <= " ";
		5'd19 :  tx_str <= " ";
		5'd20 :  tx_str <= " ";
	    5'd21:  tx_str <=  "\r";
		5'd22:  tx_str <=  "\n";
		5'd23 :  tx_str <= " ";
		default:tx_str <= 8'd0;
	    endcase
        end
      if(sort2==4'd7)begin
       case(tx_cnt4)
		5'd0 :  tx_str <= "y";
		5'd1 :  tx_str <= "e";
		5'd2 :  tx_str <= "l";
		5'd3 :  tx_str <= "l";
		5'd4 :  tx_str <= "o";
		5'd5 :  tx_str <= "w";
		5'd6 :  tx_str <= " ";
		5'd7 :  tx_str <= " ";
		5'd8 :  tx_str <= "m";
		5'd9 :  tx_str <= "a";
		5'd10:  tx_str <= "n";
	    5'd11:  tx_str <= "g";
		5'd12:  tx_str <= "o";
	    5'd13:  tx_str <= " ";
		5'd14:  tx_str <= " ";
		5'd15 :  tx_str <= " ";
		5'd16 :  tx_str <= " ";
		5'd17 :  tx_str <= " ";
		5'd18 :  tx_str <= " ";
		5'd19 :  tx_str <= " ";
		5'd20 :  tx_str <= " ";
	    5'd21:  tx_str <=  "\r";
		5'd22:  tx_str <=  "\n";
		5'd23 :  tx_str <= " ";
		default:tx_str <= 8'd0;
	    endcase
        end
      if(sort2==4'd8)begin
       case(tx_cnt4)
		5'd0 :  tx_str <= "g";
		5'd1 :  tx_str <= "r";
		5'd2 :  tx_str <= "e";
		5'd3 :  tx_str <= "e";
		5'd4 :  tx_str <= "n";
		5'd5 :  tx_str <= " ";
		5'd6 :  tx_str <= " ";
		5'd7 :  tx_str <= " ";
		5'd8 :  tx_str <= "m";
		5'd9 :  tx_str <= "a";
		5'd10:  tx_str <= "n";
	    5'd11:  tx_str <= "g";
		5'd12:  tx_str <= "o";
	    5'd13:  tx_str <= " ";
		5'd14:  tx_str <= " ";
		5'd15 :  tx_str <= " ";
		5'd16 :  tx_str <= " ";
		5'd17 :  tx_str <= " ";
		5'd18 :  tx_str <= " ";
		5'd19 :  tx_str <= " ";
		5'd20 :  tx_str <= " ";
	    5'd21:  tx_str <=  "\r";
		5'd22:  tx_str <=  "\n";
		5'd23 :  tx_str <= " ";
		default:tx_str <= 8'd0;
	    endcase
        end
      if(sort2==4'd9)begin
       case(tx_cnt4)
		5'd0 :  tx_str <= "b";
		5'd1 :  tx_str <= "r";
		5'd2 :  tx_str <= "o";
		5'd3 :  tx_str <= "w";
		5'd4 :  tx_str <= "n";
		5'd5 :  tx_str <= " ";
		5'd6 :  tx_str <= " ";
		5'd7 :  tx_str <= " ";
		5'd8 :  tx_str <= "k";
		5'd9 :  tx_str <= "i";
		5'd10:  tx_str <= "w";
	    5'd11:  tx_str <= "i";
		5'd12:  tx_str <= " ";
		5'd13 :  tx_str <= " ";
		5'd14 :  tx_str <= " ";
		5'd15 :  tx_str <= "f";
		5'd16 :  tx_str <= "r";
		5'd17 :  tx_str <= "u";
		5'd18 :  tx_str <= "i";
		5'd19 :  tx_str <= "t";
		5'd20 :  tx_str <= " ";
	    5'd21:  tx_str <= "\r";
		5'd22:  tx_str <= "\n";
		5'd23 :  tx_str <= " ";
		default:tx_str <= 8'd0;
	    endcase
        end
      if(sort2==4'd10)begin
       case(tx_cnt4)
		5'd0 :  tx_str <= "g";
		5'd1 :  tx_str <= "r";
		5'd2 :  tx_str <= "e";
		5'd3 :  tx_str <= "e";
		5'd4 :  tx_str <= "n";
		5'd5 :  tx_str <= " ";
		5'd6 :  tx_str <= " ";
		5'd7 :  tx_str <= "a";
		5'd8 :  tx_str <= "p";
		5'd9 :  tx_str <= "p";
		5'd10:  tx_str <= "l";
	    5'd11:  tx_str <= "e";
		5'd12:  tx_str <= " ";
	    5'd13:  tx_str <= " ";
		5'd14:  tx_str <= " ";
		5'd15 :  tx_str <= " ";
		5'd16 :  tx_str <= " ";
		5'd17 :  tx_str <= " ";
		5'd18 :  tx_str <= " ";
		5'd19 :  tx_str <= " ";
		5'd20 :  tx_str <= " ";
	    5'd21:  tx_str <=  "\r";
		5'd22:  tx_str <=  "\n";
		5'd23 :  tx_str <= " ";
		default:tx_str <= 8'd0;
	    endcase
        end
      if(sort2==4'd11)begin
       case(tx_cnt4)
		5'd0 :  tx_str <= "r";
		5'd1 :  tx_str <= "e";
		5'd2 :  tx_str <= "d";
		5'd3 :  tx_str <= " ";
		5'd4 :  tx_str <= "m";
		5'd5 :  tx_str <= "a";
		5'd6 :  tx_str <= "n";
		5'd7 :  tx_str <= "g";
		5'd8 :  tx_str <= "o";
		5'd9 :  tx_str <= "s";
		5'd10:  tx_str <= "t";
	    5'd11:  tx_str <= "e";
		5'd12:  tx_str <= "e";
	    5'd13:  tx_str <= "n";
		5'd14:  tx_str <= " ";
		5'd15 :  tx_str <=" ";
		5'd16 :  tx_str <= " ";
		5'd17 :  tx_str <= " ";
		5'd18 :  tx_str <= " ";
		5'd19 :  tx_str <= " ";
		5'd20 :  tx_str <= " ";
	    5'd21:  tx_str <=  "\r";
		5'd22:  tx_str <=  "\n";
		5'd23 :  tx_str <= " ";
		default:tx_str <= 8'd0;
	    endcase
        end
      if(sort2==4'd12)begin
       case(tx_cnt4)
		5'd0 :  tx_str <= "g";
		5'd1 :  tx_str <= "r";
		5'd2 :  tx_str <= "e";
		5'd3 :  tx_str <= "e";
		5'd4 :  tx_str <= "n";
		5'd5 :  tx_str <= " ";
		5'd6 :  tx_str <= " ";
		5'd7 :  tx_str <= "p";
		5'd8 :  tx_str <= "e";
		5'd9 :  tx_str <= "a";
		5'd10:  tx_str <= "r";
	    5'd11:  tx_str <= " ";
		5'd12:  tx_str <= " ";
	    5'd13:  tx_str <= " ";
		5'd14:  tx_str <= " ";
		5'd15 :  tx_str <= " ";
		5'd16 :  tx_str <= " ";
		5'd17 :  tx_str <= " ";
		5'd18 :  tx_str <= " ";
		5'd19 :  tx_str <= " ";
		5'd20 :  tx_str <= " ";
	    5'd21:  tx_str <=  "\r";
		5'd22:  tx_str <=  "\n";
		5'd23 :  tx_str <= " ";
		default:tx_str <= 8'd0;
	    endcase
        end
      if(sort2==4'd13)begin
       case(tx_cnt4)
		5'd0 :  tx_str <= "m";
		5'd1 :  tx_str <= "a";
		5'd2 :  tx_str <= "r";
		5'd3 :  tx_str <= "o";
		5'd4 :  tx_str <= "o";
		5'd5 :  tx_str <= "n";
		5'd6 :  tx_str <= " ";
		5'd7 :  tx_str <= " ";
		5'd8 :  tx_str <= "f";
		5'd9 :  tx_str <= "i";
		5'd10:  tx_str <= "g";
	    5'd11:  tx_str <= " ";
		5'd12:  tx_str <= " ";
	    5'd13:  tx_str <= " ";
		5'd14:  tx_str <= " ";
		5'd15 :  tx_str <= " ";
		5'd16 :  tx_str <= " ";
		5'd17 :  tx_str <= " ";
		5'd18 :  tx_str <= " ";
		5'd19 :  tx_str <= " ";
		5'd20 :  tx_str <= " ";
	    5'd21:  tx_str <=  "\r";
		5'd22:  tx_str <=  "\n";
		5'd23 :  tx_str <= " ";
		default:tx_str <= 8'd0;
	    endcase
        end
		end
     
 else if(tx_cnt4==5'd23&&tx_cnt5<5'd3)
   
	case(tx_cnt5)

		5'd0 : tx_str <=rx_data3;
	    5'd1:  tx_str <= " ";
		5'd2:  tx_str <= " ";
		default:tx_str <= 8'd0;
        endcase

      
 
else  if(tx_cnt5==5'd3&&tx_cnt6<5'd23)  begin
     if(sort2==4'd0)begin  
	  case(tx_cnt6)

		5'd0 :  tx_str <= " ";
		5'd1 :  tx_str <= " ";
		5'd2 :  tx_str <= " ";
		5'd3 :  tx_str <= " ";
		5'd4 :  tx_str <= " ";
		5'd5 :  tx_str <= " ";
		5'd6 :  tx_str <= " ";
		5'd7 :  tx_str <= " ";
		5'd8 :  tx_str <= " ";
		5'd9 :  tx_str <= " ";
		5'd10:  tx_str <= " ";
		5'd11:  tx_str <= " ";
		5'd12:  tx_str <= " ";
	    5'd13:  tx_str <= " ";
		5'd14:  tx_str <= " ";
		5'd15 :  tx_str <= " ";
		5'd16 :  tx_str <= " ";
		5'd17 :  tx_str <= " ";
		5'd18 :  tx_str <= " ";
		5'd19 :  tx_str <= " ";
		5'd20 :  tx_str <= " ";
	    5'd21:  tx_str <=  "\r";
		5'd22:  tx_str <=  "\n";
		5'd23 :  tx_str <= " ";
		default:tx_str <= 8'd0;
        endcase
       end
     if(sort3==4'd1)begin  
	  case(tx_cnt6)

		5'd0 :  tx_str <= "r";
		5'd1 :  tx_str <= "e";
		5'd2 :  tx_str <= "d";
		5'd3 :  tx_str <= " ";
		5'd4 :  tx_str <= "a";
		5'd5 :  tx_str <= "p";
		5'd6 :  tx_str <= "p";
		5'd7 :  tx_str <= "l";
		5'd8 :  tx_str <= "e";
		5'd9 :  tx_str <= " ";
		5'd10:  tx_str <= " ";
		5'd11:  tx_str <= " ";
		5'd12:  tx_str <= " ";
	    5'd13:  tx_str <= " ";
		5'd14:  tx_str <= " ";
		5'd15 :  tx_str <= " ";
		5'd16 :  tx_str <= " ";
		5'd17 :  tx_str <= " ";
		5'd18 :  tx_str <= " ";
		5'd19 :  tx_str <= " ";
		5'd20 :  tx_str <= " ";
	    5'd21:  tx_str <=  "\r";
		5'd22:  tx_str <=  "\n";
		5'd23 :  tx_str <= " ";
		default:tx_str <= 8'd0;
        endcase
       end
      if(sort3==4'd2)begin
       case(tx_cnt6)
		5'd0 :  tx_str <= "r";
		5'd1 :  tx_str <= "e";
		5'd2 :  tx_str <= "d";
		5'd3 :  tx_str <= " ";
		5'd4 :  tx_str <= " ";
		5'd5 :  tx_str <= " ";
		5'd6 :  tx_str <= " ";
		5'd7 :  tx_str <= "o";
		5'd8 :  tx_str <= "r";
		5'd9 :  tx_str <= "a";
		5'd10:  tx_str <= "n";
	    5'd11:  tx_str <= "g";
		5'd12:  tx_str <= "e";
	    5'd13:  tx_str <= " ";
		5'd14:  tx_str <= " ";
		5'd15 :  tx_str <= " ";
		5'd16 :  tx_str <= " ";
		5'd17 :  tx_str <= " ";
		5'd18 :  tx_str <= " ";
		5'd19 :  tx_str <= " ";
		5'd20 :  tx_str <= " ";
	    5'd21:  tx_str <=  "\r";
		5'd22:  tx_str <=  "\n";
		5'd23 :  tx_str <= " ";
		default:tx_str <= 8'd0;
	    endcase
        end
      if(sort3==4'd3)begin
       case(tx_cnt6)
		5'd0 :  tx_str <= "y";
		5'd1 :  tx_str <= "e";
		5'd2 :  tx_str <= "l";
		5'd3 :  tx_str <= "l";
		5'd4 :  tx_str <= "o";
		5'd5 :  tx_str <= "w";
		5'd6 :  tx_str <= " ";
		5'd7 :  tx_str <= "p";
		5'd8 :  tx_str <= "e";
		5'd9 :  tx_str <= "a";
		5'd10:  tx_str <= "r";
	    5'd11:  tx_str <= " ";
		5'd12:  tx_str <= " ";
	    5'd13:  tx_str <= " ";
		5'd14:  tx_str <= " ";
		5'd15 :  tx_str <= " ";
		5'd16 :  tx_str <= " ";
		5'd17 :  tx_str <= " ";
		5'd18 :  tx_str <= " ";
		5'd19 :  tx_str <= " ";
		5'd20 :  tx_str <= " ";
	    5'd21:  tx_str <=  "\r";
		5'd22:  tx_str <=  "\n";
		5'd23 :  tx_str <= " ";
		default:tx_str <= 8'd0;
	    endcase
        end
      if(sort3==4'd4)begin
       case(tx_cnt6)
		5'd0 :  tx_str <= " ";
		5'd1 :  tx_str <= "r";
		5'd2 :  tx_str <= "e";
		5'd3 :  tx_str <= "d";
		5'd4 :  tx_str <= " ";
		5'd5 :  tx_str <= " ";
		5'd6 :  tx_str <= " ";
		5'd7 :  tx_str <= "p";
		5'd8 :  tx_str <= "i";
		5'd9 :  tx_str <= "t";
		5'd10:  tx_str <= "a";
	    5'd11:  tx_str <= "y";
		5'd12:  tx_str <= "a";
	    5'd13:  tx_str <= " ";
		5'd14:  tx_str <= " ";
		5'd15 :  tx_str <= " ";
		5'd16 :  tx_str <= " ";
		5'd17 :  tx_str <= " ";
		5'd18 :  tx_str <= " ";
		5'd19 :  tx_str <= " ";
		5'd20 :  tx_str <= " ";
	    5'd21:  tx_str <=  "\r";
		5'd22:  tx_str <=  "\n";
		5'd23 :  tx_str <= " ";
		default:tx_str <= 8'd0;
	    endcase
        end
      if(sort3==4'd5)begin
       case(tx_cnt6)
		5'd0 :  tx_str <= "y";
		5'd1 :  tx_str <= "e";
		5'd2 :  tx_str <= "l";
		5'd3 :  tx_str <= "l";
		5'd4 :  tx_str <= "o";
		5'd5 :  tx_str <= "w";
		5'd6 :  tx_str <= " ";
		5'd7 :  tx_str <= " ";
		5'd8 :  tx_str <= "b";
		5'd9 :  tx_str <= "a";
		5'd10:  tx_str <= "n";
	    5'd11:  tx_str <= "n";
		5'd12:  tx_str <= "a";
	    5'd13:  tx_str <= " ";
		5'd14:  tx_str <= " ";
		5'd15 :  tx_str <= " ";
		5'd16 :  tx_str <= " ";
		5'd17 :  tx_str <= " ";
		5'd18 :  tx_str <= " ";
		5'd19 :  tx_str <= " ";
		5'd20 :  tx_str <= " ";
	    5'd21:  tx_str <=  "\r";
		5'd22:  tx_str <=  "\n";
		5'd23 :  tx_str <= " ";
		default:tx_str <= 8'd0;
	    endcase
        end
      if(sort3==4'd6)begin
       case(tx_cnt6)
		5'd0 :  tx_str <= "p";
		5'd1 :  tx_str <= "u";
		5'd2 :  tx_str <= "r";
		5'd3 :  tx_str <= "p";
		5'd4 :  tx_str <= "l";
		5'd5 :  tx_str <= "e";
		5'd6 :  tx_str <= " ";
		5'd7 :  tx_str <= " ";
		5'd8 :  tx_str <= "g";
		5'd9 :  tx_str <= "r";
		5'd10:  tx_str <= "a";
	    5'd11:  tx_str <= "p";
		5'd12:  tx_str <= "e";
	    5'd13:  tx_str <= " ";
		5'd14:  tx_str <= " ";
		5'd15 :  tx_str <= " ";
		5'd16 :  tx_str <= " ";
		5'd17 :  tx_str <= " ";
		5'd18 :  tx_str <= " ";
		5'd19 :  tx_str <= " ";
		5'd20 :  tx_str <= " ";
	    5'd21:  tx_str <=  "\r";
		5'd22:  tx_str <=  "\n";
		5'd23 :  tx_str <= " ";
		default:tx_str <= 8'd0;
	    endcase
        end
      if(sort3==4'd7)begin
       case(tx_cnt6)
		5'd0 :  tx_str <= "y";
		5'd1 :  tx_str <= "e";
		5'd2 :  tx_str <= "l";
		5'd3 :  tx_str <= "l";
		5'd4 :  tx_str <= "o";
		5'd5 :  tx_str <= "w";
		5'd6 :  tx_str <= " ";
		5'd7 :  tx_str <= " ";
		5'd8 :  tx_str <= "m";
		5'd9 :  tx_str <= "a";
		5'd10:  tx_str <= "n";
	    5'd11:  tx_str <= "g";
		5'd12:  tx_str <= "o";
	    5'd13:  tx_str <= " ";
		5'd14:  tx_str <= " ";
		5'd15 :  tx_str <= " ";
		5'd16 :  tx_str <= " ";
		5'd17 :  tx_str <= " ";
		5'd18 :  tx_str <= " ";
		5'd19 :  tx_str <= " ";
		5'd20 :  tx_str <= " ";
	    5'd21:  tx_str <=  "\r";
		5'd22:  tx_str <=  "\n";
		5'd23 :  tx_str <= " ";
		default:tx_str <= 8'd0;
	    endcase
        end
      if(sort3==4'd8)begin
       case(tx_cnt6)
		5'd0 :  tx_str <= "g";
		5'd1 :  tx_str <= "r";
		5'd2 :  tx_str <= "e";
		5'd3 :  tx_str <= "e";
		5'd4 :  tx_str <= "n";
		5'd5 :  tx_str <= " ";
		5'd6 :  tx_str <= " ";
		5'd7 :  tx_str <= " ";
		5'd8 :  tx_str <= "m";
		5'd9 :  tx_str <= "a";
		5'd10:  tx_str <= "n";
	    5'd11:  tx_str <= "g";
		5'd12:  tx_str <= "o";
	    5'd13:  tx_str <= " ";
		5'd14:  tx_str <= " ";
		5'd15 :  tx_str <= " ";
		5'd16 :  tx_str <= " ";
		5'd17 :  tx_str <= " ";
		5'd18 :  tx_str <= " ";
		5'd19 :  tx_str <= " ";
		5'd20 :  tx_str <= " ";
	    5'd21:  tx_str <=  "\r";
		5'd22:  tx_str <=  "\n";
		5'd23 :  tx_str <= " ";
		default:tx_str <= 8'd0;
	    endcase
        end
      if(sort3==4'd9)begin
       case(tx_cnt6)
		5'd0 :  tx_str <= "b";
		5'd1 :  tx_str <= "r";
		5'd2 :  tx_str <= "o";
		5'd3 :  tx_str <= "w";
		5'd4 :  tx_str <= "n";
		5'd5 :  tx_str <= " ";
		5'd6 :  tx_str <= " ";
		5'd7 :  tx_str <= " ";
		5'd8 :  tx_str <= "k";
		5'd9 :  tx_str <= "i";
		5'd10:  tx_str <= "w";
	    5'd11:  tx_str <= "i";
		5'd12:  tx_str <= " ";
		5'd13 :  tx_str <= " ";
		5'd14 :  tx_str <= " ";
		5'd15 :  tx_str <= "f";
		5'd16 :  tx_str <= "r";
		5'd17 :  tx_str <= "u";
		5'd18 :  tx_str <= "i";
		5'd19 :  tx_str <= "t";
		5'd20 :  tx_str <= " ";
	    5'd21:  tx_str <= " ";
		5'd22:  tx_str <= " ";
		5'd15 :  tx_str <= " ";
		5'd16 :  tx_str <= " ";
		5'd17 :  tx_str <= " ";
		5'd18 :  tx_str <= " ";
		5'd19 :  tx_str <= " ";
		5'd20 :  tx_str <= " ";
	    5'd21:  tx_str <=  "\r";
		5'd22:  tx_str <=  "\n";
		5'd23 :  tx_str <= " ";
		default:tx_str <= 8'd0;
	    endcase
        end
      if(sort3==4'd10)begin
       case(tx_cnt6)
		5'd0 :  tx_str <= "g";
		5'd1 :  tx_str <= "r";
		5'd2 :  tx_str <= "e";
		5'd3 :  tx_str <= "e";
		5'd4 :  tx_str <= "n";
		5'd5 :  tx_str <= " ";
		5'd6 :  tx_str <= " ";
		5'd7 :  tx_str <= "a";
		5'd8 :  tx_str <= "p";
		5'd9 :  tx_str <= "p";
		5'd10:  tx_str <= "l";
	    5'd11:  tx_str <= "e";
		5'd12:  tx_str <= " ";
	    5'd13:  tx_str <= " ";
		5'd14:  tx_str <= " ";
		5'd15 :  tx_str <= " ";
		5'd16 :  tx_str <= " ";
		5'd17 :  tx_str <= " ";
		5'd18 :  tx_str <= " ";
		5'd19 :  tx_str <= " ";
		5'd20 :  tx_str <= " ";
	    5'd21:  tx_str <=  "\r";
		5'd22:  tx_str <=  "\n";
		5'd23 :  tx_str <= " ";
		default:tx_str <= 8'd0;
	    endcase
        end
      if(sort3==4'd11)begin
       case(tx_cnt6)
		5'd0 :  tx_str <= "r";
		5'd1 :  tx_str <= "e";
		5'd2 :  tx_str <= "d";
		5'd3 :  tx_str <= " ";
		5'd4 :  tx_str <= "m";
		5'd5 :  tx_str <= "a";
		5'd6 :  tx_str <= "n";
		5'd7 :  tx_str <= "g";
		5'd8 :  tx_str <= "o";
		5'd9 :  tx_str <= "s";
		5'd10:  tx_str <= "t";
	    5'd11:  tx_str <= "e";
		5'd12:  tx_str <= "e";
	    5'd13:  tx_str <= "n";
		5'd14:  tx_str <= " ";
		5'd15 :  tx_str <= " ";
		5'd16 :  tx_str <= " ";
		5'd17 :  tx_str <= " ";
		5'd18 :  tx_str <= " ";
		5'd19 :  tx_str <= " ";
		5'd20 :  tx_str <= " ";
	    5'd21:  tx_str <=  "\r";
		5'd22:  tx_str <=  "\n";
		5'd23 :  tx_str <= " ";
		default:tx_str <= 8'd0;
	    endcase
        end
      if(sort3==4'd12)begin
       case(tx_cnt6)
		5'd0 :  tx_str <= "g";
		5'd1 :  tx_str <= "r";
		5'd2 :  tx_str <= "e";
		5'd3 :  tx_str <= "e";
		5'd4 :  tx_str <= "n";
		5'd5 :  tx_str <= " ";
		5'd6 :  tx_str <= " ";
		5'd7 :  tx_str <= "p";
		5'd8 :  tx_str <= "e";
		5'd9 :  tx_str <= "a";
		5'd10:  tx_str <= "r";
	    5'd11:  tx_str <= " ";
		5'd12:  tx_str <= " ";
	    5'd13:  tx_str <= " ";
		5'd14:  tx_str <= " ";
		5'd15 :  tx_str <= " ";
		5'd16 :  tx_str <= " ";
		5'd17 :  tx_str <= " ";
		5'd18 :  tx_str <= " ";
		5'd19 :  tx_str <= " ";
		5'd20 :  tx_str <= " ";
	    5'd21:  tx_str <=  "\r";
		5'd22:  tx_str <=  "\n";
		5'd23 :  tx_str <= " ";
		default:tx_str <= 8'd0;
	    endcase
        end
      if(sort3==4'd13)begin
       case(tx_cnt6)
		5'd0 :  tx_str <= "m";
		5'd1 :  tx_str <= "a";
		5'd2 :  tx_str <= "r";
		5'd3 :  tx_str <= "o";
		5'd4 :  tx_str <= "o";
		5'd5 :  tx_str <= "n";
		5'd6 :  tx_str <= " ";
		5'd7 :  tx_str <= " ";
		5'd8 :  tx_str <= "f";
		5'd9 :  tx_str <= "i";
		5'd10:  tx_str <= "g";
	    5'd11:  tx_str <= " ";
		5'd12:  tx_str <= " ";
	    5'd13:  tx_str <= " ";
		5'd14:  tx_str <= " ";
		5'd15 :  tx_str <= " ";
		5'd16 :  tx_str <= " ";
		5'd17 :  tx_str <= " ";
		5'd18 :  tx_str <= " ";
		5'd19 :  tx_str <= " ";
		5'd20 :  tx_str <= " ";
	    5'd21:  tx_str <=  "\r";
		5'd22:  tx_str <=  "\n";
		5'd23 :  tx_str <= " ";
		default:tx_str <= 8'd0;
	    endcase
        end
     end
   end

uart_tx#
(
	.CLK_FRE(CLK_FRE),
	.BAUD_RATE(115200)
) uart_tx_inst
(
	.clk                        (sys_clk                  ),
	.rst_n                      (rst_n                    ),
	.tx_data                    (tx_data                  ),
	.tx_data_valid              (tx_data_valid            ),
	.tx_data_ready              (tx_data_ready            ),
	.tx_pin                     (uart_tx                  )
);
endmodule