module Multiplier_Reg(
    input logic clk,
    input logic rst,  

    input logic [31:0]Holder_in,
    input logic [31:0]Holder_wire_in,

    input logic [31:0]add_en_in,
    input logic [31:0]sub_en_in,

    input logic [32:0]Q_in,
    input logic [64:0]phase_result_wire_in,
    input logic [64:0]phase_result_in,

    input logic done_in,

    output logic [31:0]Holder_out,
    output logic [31:0]Holder_wire_out,
    output logic [31:0]add_en_out,
    output logic [31:0]sub_en_out,

    output logic [32:0]Q_out,
    output logic [64:0]phase_result_wire_out,
    output logic [64:0]phase_result_out,

    output logic done_out
);

    always_ff @(posedge clk , negedge rst)

    begin
        if(~rst)
        begin
            Holder_out <= 32'd0;
            Holder_wire_out <= 32'd0;
            add_en_out <= 32'd0;
            sub_en_out <= 32'd0;
            Q_out <= 33'd0;
            phase_result_wire_out <= 65'd0;
            phase_result_out <= 65'd0;
            done_out <= 1'b0;
        end
        else
        begin
            Holder_out <= Holder_in;
            Holder_wire_out <= Holder_wire_in;
            add_en_out <= add_en_in;
            sub_en_out <= sub_en_in;
            Q_out <= Q_in;
            phase_result_wire_out <= phase_result_wire_in;
            phase_result_out <= phase_result_in;
            done_out <= done_in;
        end
    end
endmodule
