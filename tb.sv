`timescale 1ns/1ps

module Multiplier_32bit_tb;

    // Testbench signals
    logic clk;
    logic rst;
    logic [31:0] in0;    // multiplicand
    logic [31:0] in1;    // multiplier
    logic done;
    logic [63:0] result;

    // Instantiate the DUT (Device Under Test)
    Multiplier_32bit TB (
        .clk(clk),
        .rst(rst),
        .in0(in0),
        .in1(in1),
        .done(done),
        .result(result)
    );

    // Clock generation
    initial begin
        clk = 0;
        forever #5 clk = ~clk;  // 10ns period
    end


    // Test procedure
    initial begin
        // Initialize signals
        rst = 1;
        in0 = 0;
        in1 = 0;
        #1;  // Wait for initial stabilization
        rst = 0;
        #1;  // Wait for initial stabilization
        rst = 1;
        // Test cases
        // Test 1: 3 * 2 = 6
        #5;
        in0 = 32'd6;
        in1 = 32'd6;
        #10;

        in0 = 32'd5;
        in1 = 32'd3;
        #10;

        in0 = 32'd7;
        in1 = 32'd2;
        #30;

        in0 = 32'd4;
        in1 = 32'd4;
        #30;

        in0 = 32'd0;
        in1 = 32'd5;
        #30;

        in0 = 32'd15;
        in1 = 32'd1;
        #30;

        $finish;
    end

endmodule