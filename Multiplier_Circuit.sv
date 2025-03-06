/*
module Multiplier32(
    input logic clk,
    input logic rst,

    input logic [31:0]in0,
    input logic [31:0]in1,

    input logic sign_en_in0,
    input logic sign_en_in1,

    output logic done,
    output logic [31:0]result
);


    
endmodule





module Multiplier4 #(
    parameter WIDTH = 4
    )(
    input logic clk,
    input logic rst,

    input logic [WIDTH-1:0]in0,
    input logic [WIDTH-1:0]in1,

    input logic sign_en_in0,
    input logic sign_en_in1,

    output logic done,
    output logic [7:0]result
);

    logic last_bit;
    logic [7:0]Holded;

    logic [3:0]and_phase[3:0];

    genvar i;
    genvar j;

    generate
        for(i = 0; i<4 ; i=i+1)
        begin
            for(j = 0 ; i<4 ; i=i+1)
            begin
                assign [i]and_phase[j] = in0[i] & in1[j];
            end
        end
    endgenerate


    
endmodule
*/  

module Kogge_Stone_4bit(
    input logic [3:0]in0,
    input logic [3:0]in1,

    input logic carry_in,

    output logic carry_out,
    output logic [3:0]result
    );

    genvar i;

    logic [8:0]propagate_bit;
    logic [8:0]generate_bit;

    logic [4:0]carry_bit;

    generate
        for(i = 0; i<4 ; i=i+1)
        begin
            assign propagate_bit[i] = in0[i] ^^ in1[i];
            assign generate_bit[i] = in0[i] && in1[i];
        end
    endgenerate

    //stage 1
    assign propagate_bit[4] = propagate_bit[1] ^^ propagate_bit[0];
    assign propagate_bit[5] = propagate_bit[2] ^^ propagate_bit[1];
    assign propagate_bit[6] = propagate_bit[3] ^^ propagate_bit[2];

    assign generate_bit[4] = generate_bit[1] || (propagate_bit[1] && generate_bit[0]);
    assign generate_bit[5] = generate_bit[2] || (propagate_bit[2] && generate_bit[1]);
    assign generate_bit[6] = generate_bit[3] || (propagate_bit[3] && generate_bit[2]);

    //stage 2
    assign propagate_bit[7] = propagate_bit[0] ^^ propagate_bit[5];
    assign propagate_bit[8] = propagate_bit[4] ^^ propagate_bit[6];

    assign generate_bit[7] = generate_bit[5] || (propagate_bit[5] && generate_bit[0]);
    assign generate_bit[8] = generate_bit[6] || (propagate_bit[6] && generate_bit[4]);

    //carry 
    assign carry_bit[0] = carry_in;
    assign carry_bit[1] = generate_bit[4] || (propagate_bit[4] && carry_in);
    assign carry_bit[2] = generate_bit[7] || (propagate_bit[7] && carry_in);
    assign carry_bit[3] = generate_bit[8] || (propagate_bit[8] && carry_in);

    //sum
    assign result[0] = propagate_bit[0] ^^ carry_bit[0];
    assign result[1] = propagate_bit[1] ^^ carry_bit[0];
    assign result[2] = propagate_bit[2] ^^ carry_bit[0];
    assign result[3] = propagate_bit[3] ^^ carry_bit[0];
    

endmodule