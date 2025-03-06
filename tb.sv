module  Multiplier_tb();

    logic [3:0]in0;
    logic [3:0]in1;
    logic carry_in;

    logic carry_out;   
    logic [3:0]result;

    Kogge_Stone_4bit kogge_stone_4bit(
        .in0(in0),
        .in1(in1),
        .carry_in(carry_in),
        .carry_out(carry_out),
        .result(result)
    );

    initial begin
        in0 = 4'b0001;
        in1 = 4'b0010;
        carry_in = 1'b0;
        #10;
        $display("Result: %b", result);
        $display("Carry Out: %b", carry_out);
    end

    
endmodule