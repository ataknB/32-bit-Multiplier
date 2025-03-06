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

    Multiplier_Reg Reg_1(
                .clk(clk),
                .rst(rst),
                
                // Girişler
                .Holder_in(phase_result[7][64:33]),        // Önceki aşamadan üst 32 bit
                .Holder_wire_in(Holder_wire[7]),           // Önceki Holder_wire
                .add_en_in(add_en[7]),                     // Önceki add_en
                .sub_en_in(sub_en[7]),                     // Önceki sub_en
                .Q_in(phase_result[7][32:0]),             // Önceki Q (alt 33 bit)
                .phase_result_wire_in(phase_result_wire[7]), // Önceki phase_result_wire
                .phase_result_in(phase_result[7]),         // Önceki phase_result

                // Çıkışlar
                .Holder_out(Holder[8]),
                .Holder_wire_out(Holder_wire[8]),
                .add_en_out(add_en[8]),
                .sub_en_out(sub_en[8]),
                .Q_out(Q[8]),
                .phase_result_wire_out(phase_result_wire[8]),
                .phase_result_out(phase_result[8])
            );

    generate 
        for(i=8 ; i<16 ; i=i+1)
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

    Multiplier_Reg Reg_2(
                .clk(clk),
                .rst(rst),
                
                // Girişler
                .Holder_in(phase_result[15][64:33]),        // Önceki aşamadan üst 32 bit
                .Holder_wire_in(Holder_wire[15]),           // Önceki Holder_wire
                .add_en_in(add_en[15]),                     // Önceki add_en
                .sub_en_in(sub_en[15]),                     // Önceki sub_en
                .Q_in(phase_result[15][32:0]),             // Önceki Q (alt 33 bit)
                .phase_result_wire_in(phase_result_wire[15]), // Önceki phase_result_wire
                .phase_result_in(phase_result[15]),         // Önceki phase_result

                // Çıkışlar
                .Holder_out(Holder[16]),
                .Holder_wire_out(Holder_wire[16]),
                .add_en_out(add_en[16]),
                .sub_en_out(sub_en[16]),
                .Q_out(Q[16]),
                .phase_result_wire_out(phase_result_wire[16]),
                .phase_result_out(phase_result[16])
            );

    generate 
        for(i=16 ; i<24 ; i=i+1)
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

    Multiplier_Reg Reg_3(
                .clk(clk),
                .rst(rst),
                
                // Girişler
                .Holder_in(phase_result[23][64:33]),        // Önceki aşamadan üst 32 bit
                .Holder_wire_in(Holder_wire[23]),           // Önceki Holder_wire
                .add_en_in(add_en[23]),                     // Önceki add_en
                .sub_en_in(sub_en[23]),                     // Önceki sub_en
                .Q_in(phase_result[23][32:0]),             // Önceki Q (alt 33 bit)
                .phase_result_wire_in(phase_result_wire[23]), // Önceki phase_result_wire
                .phase_result_in(phase_result[23]),         // Önceki phase_result

                // Çıkışlar
                .Holder_out(Holder[24]),
                .Holder_wire_out(Holder_wire[24]),
                .add_en_out(add_en[24]),
                .sub_en_out(sub_en[24]),
                .Q_out(Q[24]),
                .phase_result_wire_out(phase_result_wire[24]),
                .phase_result_out(phase_result[24])
            );

    generate 
        for(i=24 ; i<32 ; i=i+1)
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
    assign done = 1'b1; // Combinational, so always done

endmodule


