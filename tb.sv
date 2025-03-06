`timescale 1ns/1ps

module Multiplier_4bit_tb;

    // Testbench signals
    //logic clk;
    //logic rst;
    logic [3:0] in0;    // multiplicand
    logic [3:0] in1;    // multiplier
    logic done;
    logic [7:0] result;

    // Instantiate the DUT (Device Under Test)
    Multiplier_4bit #(
        .WIDTH(4)
    ) dut (
        //.clk(clk),
        //.rst(rst),
        .in0(in0),
        .in1(in1),
        .done(done),
        .result(result)
    );

    /*
    // Clock generation
    initial begin
        clk = 0;
        forever #5 clk = ~clk;  // 10ns period
    end
    */

    // Test procedure
    initial begin
        /*
        // Initialize signals
        rst = 1;
        in0 = 0;
        in1 = 0;
        
        #20;  // Wait for initial stabilization
        rst = 0;
        */
        // Test cases
        // Test 1: 3 * 2 = 6
        //#10;
        in0 = 4'd2;
        in1 = 4'd3;
        #20;

        in0 = 4'd5;
        in1 = 4'd3;
        #20;

        in0 = 4'd7;
        in1 = 4'd2;
        #20;

        in0 = 4'd4;
        in1 = 4'd4;
        #20;

        in0 = 4'd0;
        in1 = 4'd5;
        #20;

        in0 = 4'd15;
        in1 = 4'd1;
        #20;

        $finish;
    end

endmodule