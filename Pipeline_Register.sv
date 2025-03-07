module Multiplier_Reg(
    input logic clk,
    input logic rst,  


    input logic [64:0]phase_result_in,

    input logic done_in,

    output logic [64:0]phase_result_out,

    output logic done_out
);

    always_ff @(posedge clk , negedge rst)

    begin
        if(~rst)
        begin
            phase_result_out <= 65'd0;
            done_out <= 1'b0;
        end
        else
        begin
            phase_result_out <= phase_result_in;
            done_out <= done_in;
        end
    end
endmodule
