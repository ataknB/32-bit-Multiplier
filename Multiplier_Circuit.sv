module Multiplier_4bit #(
    parameter WIDTH = 4
    )(
    //input logic clk,
    //input logic rst,
    input logic [WIDTH-1:0] in0, // multiplicand
    input logic [WIDTH-1:0] in1, // multiplier
    output logic done,
    output logic [7:0] result
);

    // Phase registers
    logic [3:0]Holder_0;

    logic add_en_1;
    logic sub_en_1;
    logic [4:0]Q_1;
    
    logic [8:0]phase_result_1;
    logic [8:0]phase_result_1_wire;
    logic [3:0]Holder_1_wire;
    logic [3:0]Holder_1;

    logic add_en_2;
    logic sub_en_2;
    logic [4:0] Q_2;
    
    logic [8:0] phase_result_2;
    logic [8:0]phase_result_2_wire;
    logic [3:0]Holder_2_wire;
    logic [3:0] Holder_2;

    logic add_en_3;
    logic sub_en_3;
    logic [4:0] Q_3;
    
    logic [8:0] phase_result_3;
    logic [8:0]phase_result_3_wire;
    logic [3:0] Holder_3_wire;
    logic [3:0] Holder_3;
    
    logic add_en_4;
    logic sub_en_4;
    logic [4:0] Q_4;
    logic [8:0] phase_result_4;
    logic [8:0]phase_result_4_wire;
    logic [3:0] Holder_4_wire;
    logic [3:0] Holder_4;
    

    /*
    logic [4:0] Q_1, Q_2, Q_3, Q_4;
    logic [3:0] Holder_0, Holder_1, Holder_2, Holder_3, Holder_4;
    
    // Control signals
    logic add_en_1, add_en_2, add_en_3, add_en_4;
    logic sub_en_1, sub_en_2, sub_en_3, sub_en_4;
    
    // Intermediate results
    logic [8:0] phase_result_1, phase_result_2, phase_result_3, phase_result_4;
    */

    // Phase 1
    always_comb begin
        Q_1 = {in1, 1'b0};    // Initial Q with extra bit
        Holder_0 = 4'd0;     // Initial accumulator

        case({Q_1[1], Q_1[0]})
            2'b00: begin sub_en_1 = 0; add_en_1 = 0; end
            2'b01: begin sub_en_1 = 0; add_en_1 = 1; end
            2'b10: begin sub_en_1 = 1; add_en_1 = 0; end
            2'b11: begin sub_en_1 = 0; add_en_1 = 0; end
        endcase

        if(add_en_1) begin
            Holder_1_wire = Holder_0 + in0;
        end
        else if(sub_en_1) begin
            Holder_1_wire = Holder_0 - in0;
        end
        else begin
            Holder_1_wire = Holder_0;
        end

        phase_result_1_wire = {Holder_1_wire, Q_1};
        phase_result_1 = {phase_result_1_wire[8] , phase_result_1_wire[8:1]};

    end

    // Phase 2
    always_comb begin
        Q_2 = {phase_result_1[4:0]};    // Initial Q with extra bit
        Holder_1 = phase_result_1[8:5];     // Initial accumulator

        case({Q_2[1], Q_2[0]})
            2'b00: begin sub_en_2 = 0; add_en_2 = 0; end
            2'b01: begin sub_en_2 = 0; add_en_2 = 1; end
            2'b10: begin sub_en_2 = 1; add_en_2 = 0; end
            2'b11: begin sub_en_2 = 0; add_en_2 = 0; end
        endcase

        if(add_en_2) begin
            Holder_2_wire = Holder_1 + in0;
        end
        else if(sub_en_2) begin
            Holder_2_wire = Holder_1 - in0;
        end
        else begin
            Holder_2_wire = phase_result_1[8:5];
        end

        phase_result_2_wire = {Holder_2_wire, Q_2};
        phase_result_2 = {phase_result_2_wire[8] , phase_result_2_wire[8:1]};

    end

    // Phase 3
    always_comb begin
        Q_3 = {phase_result_2[4:0]};    // Initial Q with extra bit
        Holder_2 = phase_result_2[8:5];     // Initial accumulator

        case({Q_3[1], Q_3[0]})
            2'b00: begin sub_en_3 = 0; add_en_3 = 0; end
            2'b01: begin sub_en_3 = 0; add_en_3 = 1; end
            2'b10: begin sub_en_3 = 1; add_en_3 = 0; end
            2'b11: begin sub_en_3 = 0; add_en_3 = 0; end
        endcase

        if(add_en_3) begin
            Holder_3_wire = Holder_2 + in0;
        end
        else if(sub_en_3) begin
            Holder_3_wire = Holder_2 - in0;
        end
        else begin
            Holder_3_wire = phase_result_2[8:5];
        end

        phase_result_3_wire = {Holder_3_wire, Q_3};
        phase_result_3 = {phase_result_3_wire[8] , phase_result_3_wire[8:1]};

    end

    // Phase 4
    always_comb begin
        Q_4 = {phase_result_3[4:0]};    // Initial Q with extra bit
        Holder_3 = phase_result_3[8:5];     // Initial accumulator

        case({Q_4[1], Q_4[0]})
            2'b00: begin sub_en_4 = 0; add_en_4 = 0; end
            2'b01: begin sub_en_4 = 0; add_en_4 = 1; end
            2'b10: begin sub_en_4 = 1; add_en_4 = 0; end
            2'b11: begin sub_en_4 = 0; add_en_4 = 0; end
        endcase

        if(add_en_4) begin
            Holder_4_wire = Holder_3 + in0;
        end
        else if(sub_en_4) begin
            Holder_4_wire = Holder_3 - in0;
        end
        else begin
            Holder_4_wire = phase_result_3[8:5];
        end

        phase_result_4_wire = {Holder_4_wire, Q_4};
        phase_result_4 = {phase_result_4_wire[8] , phase_result_4_wire[8:1]};

    end

    // Output assignment
    assign result = phase_result_4[8:1]; // Take upper 8 bits
    assign done = 1'b1; // Combinational, so always done

endmodule




module Ripple_Carry_Adder(

    input logic in0,
    input logic in1,

    input logic carry_in,
    output logic carry_out,
    output logic result

    );
    
    logic wire_bit;

    assign wire_bit = in0 ^ in1;

    assign result = wire_bit ^ carry_in;
    assign carry_out = (wire_bit & carry_in) | (in0 & in1);

endmodule


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
