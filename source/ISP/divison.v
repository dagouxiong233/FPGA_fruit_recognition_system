module divison
#(

    parameter W = 48,  //扩展的位数

    parameter N = 24    //输入的除数和被除数的位数

)
(
input					pixelclk,
input                   rst_n,
input					i_hs,
input					i_vs,                                                                                                
input					i_de,
input         [N-1:0]   dividend,
input         [N-1:0]   divisor,


output   wire [N-1:0]   quotient,
output   wire [N-1:0]   remainder,

output                  o_hsync,
output                  o_vsync,
output                  o_de

   );
parameter idle        = 3'b001;
parameter shift       = 3'b010;
parameter done        = 3'b100;

wire[2:0] state;    
reg[2:0] state_next;
 
reg [W-1:0] data;
wire[W-1:0] data_next;
reg [W-1:0] data_next1;
reg [W-1:0] data_di;
reg  finish;
reg    hs_r;
reg    vs_r;
reg    de_r;

reg [5:0] n_reg;   //存储计算的次数



wire  TFT_VS_fall;

assign TFT_VS_fall = (!i_vs & (vs_r))?1'b1:1'b0;
//
//always @(posedge pixelclk )
//  begin
//  hs_r    <= i_hs;
//  vs_r    <= i_vs;
//  de_r    <= i_de;
//  end 


always@(posedge pixelclk or negedge rst_n) 
 begin
  if(!rst_n) 

        state_next<= idle;
 else begin
  case(state)

    idle: begin

        //if( TFT_VS_fall ) begin 

            data <= {24'h0,dividend};

            data_di<={divisor,24'h0};

            finish <= 0;

            state_next <= shift;

            n_reg <= 24;

        //end

    end

    shift: begin      

        n_reg <= n_reg-1'b1;

    if( data_next >= data_di) begin

         data_next1 = data_next-data_di+1'b1;

	     data={data_next1[46:0],1'b0};

        end
        else

   		  data={data_next[46:0],1'b0};
      
        if(n_reg==1)begin

          if( data_next >= data_di) begin

            data_next1= data_next-data_di+1'b1;
            
            data={data_next1[46:0],1'b0};
            
            state_next <= done;
                        
          end
          else begin

            data={data_next[46:0],1'b0};

            state_next <= done;

          end

    end                   

    end

    done:  begin
          if( data_next >= data_di) begin

          data_next1 = data_next-data_di+1'b1;

          data=data_next1;

      
        end 
        else

        data=data_next;

         finish <= 1;
        state_next <= idle;

    end

    endcase
end
end
assign  data_next =data;
assign  state  = state_next;
assign quotient  = finish?data [N-1:0] : quotient;

assign remainder = finish?data[W-1:N] : remainder;

endmodule  