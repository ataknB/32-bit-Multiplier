module Multiplier_32bit(
    input logic clk,
    input logic rst,
    input logic [31:0] in0, // multiplicand
    input logic [31:0] in1, // multiplier
    output logic done,
    output logic [63:0] result
);
    genvar i;

    logic [31:0]Holder[31:0];
    logic [31:0]Holder_wire[31:0];

    logic [31:0]add_en;
    logic [31:0]sub_en;

    logic [32:0]Q[31:0];
    logic [64:0]phase_result_wire[31:0];
    logic [64:0]phase_result[31:0];

    

    always_comb begin
        Q[0] = {in1, 1'b0};    // Initial Q with extra bit
        Holder[0] = 32'd0;     // Initial accumulator

        case({Q[0][1], Q[0][0]})
            2'b00: begin sub_en[0] = 0; add_en[0] = 0; end
            2'b01: begin sub_en[0] = 0; add_en[0]  = 1; end
            2'b10: begin sub_en[0] = 1; add_en[0]  = 0; end
            default: begin sub_en[0] = 0; add_en[0]  = 0; end
        endcase

        if(add_en[0]) begin
            Holder_wire[0] = Holder[0] + in0;
        end
        else if(sub_en[0]) begin
            Holder_wire[0] = Holder[0] - in0;
        end
        else begin
            Holder_wire[0] = Holder[0];
        end

        phase_result_wire[0] = {Holder_wire[0], Q[0]};
        phase_result[0] = {phase_result_wire[0][64] , phase_result_wire[0][64:1]};
        

    end

    generate 
        for(i=1 ; i<8 ; i=i+1)
        begin
            always_comb begin
            Q[i] = phase_result[i-1][32:0];    // Initial Q with extra bit
            Holder[i] = phase_result[i-1][64:33];     // Initial accumulator

            case({Q[i][1], Q[i][0]})
                2'b00: begin sub_en[i] = 0; add_en[i] = 0; end
                2'b01: begin sub_en[i] = 0; add_en[i]  = 1; end
                2'b10: begin sub_en[i] = 1; add_en[i]  = 0; end
                default: begin sub_en[i] = 0; add_en[i]  = 0; end
            endcase

            if(add_en[i]) begin
                Holder_wire[i] = Holder[i] + in0;
            end
            else if(sub_en[i]) begin
                Holder_wire[i] = Holder[i] - in0;
            end
            else begin
                Holder_wire[i] = phase_result[i-1][64:33];
            end

            phase_result_wire[i] = {Holder_wire[i], Q[i]};
            phase_result[i] = {phase_result_wire[i][64] , phase_result_wire[i][64:1]};

            end
        end
    endgenerate

    logic [64:0]phase_wire_1;

    Multiplier_Reg Reg_1(
                .clk(clk),
                .rst(rst),
 
                .phase_result_in(phase_result[7]),     

                .phase_result_out(phase_wire_1)
            );

    

     always_comb begin
            Q[8] = phase_wire_1[32:0];    // Initial Q with extra bit
            Holder[8] = phase_wire_1[64:33];     // Initial accumulator

            case({Q[8][1], Q[8][0]})
                2'b00: begin sub_en[8] = 0; add_en[8] = 0; end
                2'b01: begin sub_en[8] = 0; add_en[8]  = 1; end
                2'b10: begin sub_en[8] = 1; add_en[8]  = 0; end
                default: begin sub_en[8] = 0; add_en[8]  = 0; end
            endcase

            if(add_en[8]) begin
                Holder_wire[8] = Holder[8] + in0;
            end
            else if(sub_en[8]) begin
                Holder_wire[8] = Holder[8] - in0;
            end
            else begin
                Holder_wire[8] = phase_wire_1[64:33];
            end

            phase_result_wire[8] = {Holder_wire[8], Q[8]};
            phase_result[8] = {phase_result_wire[8][64] , phase_result_wire[8][64:1]};

            end

    generate 
        for(i=9 ; i<16 ; i=i+1)
        begin
            always_comb begin
            Q[i] = phase_result[i-1][32:0];    // Initial Q with extra bit
            Holder[i] = phase_result[i-1][64:33];     // Initial accumulator

            case({Q[i][1], Q[i][0]})
                2'b00: begin sub_en[i] = 0; add_en[i] = 0; end
                2'b01: begin sub_en[i] = 0; add_en[i]  = 1; end
                2'b10: begin sub_en[i] = 1; add_en[i]  = 0; end
                default: begin sub_en[i] = 0; add_en[i]  = 0; end
            endcase

            if(add_en[i]) begin
                Holder_wire[i] = Holder[i] + in0;
            end
            else if(sub_en[i]) begin
                Holder_wire[i] = Holder[i] - in0;
            end
            else begin
                Holder_wire[i] = phase_result[i-1][64:33];
            end

            phase_result_wire[i] = {Holder_wire[i], Q[i]};
            phase_result[i] = {phase_result_wire[i][64] , phase_result_wire[i][64:1]};

            end
        end
    endgenerate

    logic [64:0]phase_wire_2;

    Multiplier_Reg Reg_2(
                .clk(clk),
                .rst(rst),
                
                .phase_result_in(phase_result[15]),         // Önceki phase_result

                .phase_result_out(phase_wire_2)
            );

    always_comb begin
            Q[16] = phase_wire_2[32:0];    // Initial Q with extra bit
            Holder[16] = phase_wire_2[64:33];    // Initial accumulator

            case({Q[16][1], Q[16][0]})
                2'b00: begin sub_en[16] = 0; add_en[16] = 0; end
                2'b01: begin sub_en[16] = 0; add_en[16]  = 1; end
                2'b10: begin sub_en[16] = 1; add_en[16]  = 0; end
                default: begin sub_en[16] = 0; add_en[16]  = 0; end
            endcase

            if(add_en[16]) begin
                Holder_wire[16] = Holder[16] + in0;
            end
            else if(sub_en[16]) begin
                Holder_wire[16] = Holder[16] - in0;
            end
            else begin
                Holder_wire[16] = phase_wire_2[64:33];
            end

            phase_result_wire[16] = {Holder_wire[16], Q[16]};
            phase_result[16] = {phase_result_wire[16][64] , phase_result_wire[16][64:1]};

            end

    generate 
        for(i=17 ; i<24 ; i=i+1)
        begin
            always_comb begin
            Q[i] = phase_result[i-1][32:0];    // Initial Q with extra bit
            Holder[i] = phase_result[i-1][64:33];    // Initial accumulator

            case({Q[i][1], Q[i][0]})
                2'b00: begin sub_en[i] = 0; add_en[i] = 0; end
                2'b01: begin sub_en[i] = 0; add_en[i]  = 1; end
                2'b10: begin sub_en[i] = 1; add_en[i]  = 0; end
                default: begin sub_en[i] = 0; add_en[i]  = 0; end
            endcase

            if(add_en[i]) begin
                Holder_wire[i] = Holder[i] + in0;
            end
            else if(sub_en[i]) begin
                Holder_wire[i] = Holder[i] - in0;
            end
            else begin
                Holder_wire[i] = phase_result[i-1][64:33];
            end

            phase_result_wire[i] = {Holder_wire[i], Q[i]};
            phase_result[i] = {phase_result_wire[i][64] , phase_result_wire[i][64:1]};

            end
        end
    endgenerate

    logic [64:0]phase_wire_3;

    Multiplier_Reg Reg_3(
                .clk(clk),
                .rst(rst),

                .phase_result_in(phase_result[23]),         // Önceki phase_result
                .phase_result_out(phase_wire_3)
            );

    always_comb begin
            Q[24] = phase_wire_3[32:0];    // Initial Q with extra bit
            Holder[24] = phase_wire_3[64:33];     // Initial accumulator

            case({Q[24][1], Q[24][0]})
                2'b00: begin sub_en[24] = 0; add_en[24] = 0; end
                2'b01: begin sub_en[24] = 0; add_en[24]  = 1; end
                2'b10: begin sub_en[24] = 1; add_en[24]  = 0; end
                default: begin sub_en[24] = 0; add_en[24]  = 0; end
            endcase

            if(add_en[24]) begin
                Holder_wire[24] = Holder[24] + in0;
            end
            else if(sub_en[24]) begin
                Holder_wire[24] = Holder[24] - in0;
            end
            else begin
                Holder_wire[24] = phase_wire_3[64:33];
            end

            phase_result_wire[24] = {Holder_wire[24], Q[24]};
            phase_result[24] = {phase_result_wire[24][64] , phase_result_wire[24][64:1]};

            end

    generate 
        for(i=25 ; i<32 ; i=i+1)
        begin
            always_comb begin
            Q[i] = phase_result[i-1][32:0];    // Initial Q with extra bit
            Holder[i] = phase_result[i-1][64:33];     // Initial accumulator

            case({Q[i][1], Q[i][0]})
                2'b00: begin sub_en[i] = 0; add_en[i] = 0; end
                2'b01: begin sub_en[i] = 0; add_en[i]  = 1; end
                2'b10: begin sub_en[i] = 1; add_en[i]  = 0; end
                default: begin sub_en[i] = 0; add_en[i]  = 0; end
            endcase

            if(add_en[i]) begin
                Holder_wire[i] = Holder[i] + in0;
            end
            else if(sub_en[i]) begin
                Holder_wire[i] = Holder[i] - in0;
            end
            else begin
                Holder_wire[i] = phase_result[i-1][64:33];
            end

            phase_result_wire[i] = {Holder_wire[i], Q[i]};
            phase_result[i] = {phase_result_wire[i][64] , phase_result_wire[i][64:1]};

            end
        end
    endgenerate

    assign result = phase_result[31][63:1]; // Take upper 8 bits
   // assign done = done[3]; // Combinational, so always done

endmodule


