`timescale 1ns / 1ps

module DSP48A1_tb;

    // Parameters
    parameter OPERATION = "ADD";

    // Inputs
    reg clk;
    reg rst_n;
    reg [17:0] A, B, D;
    reg [47:0] C;

    // Output
    wire [47:0] P;

    // Instantiate the Unit Under Test (UUT)
    DSP48A1 #(
        .OPERATION(OPERATION)
    ) uut (
        .clk(clk),
        .rst_n(rst_n),
        .A(A),
        .B(B),
        .D(D),
        .C(C),
        .P(P)
    );

    initial begin
        clk = 0;
        forever #5 clk = ~clk; 
    end

    initial begin
        $display("Starting testbench...");
        rst_n = 0;
        A = 0; B = 0; D = 0; C = 0;

        #12;
        rst_n = 1;

        // Test Vector 1: ADD: (D + B) = (3 + 2) = 5, A = 4 → 4×5 = 20, C = 10 → P = 20 + 10 = 30
        @(negedge clk); A = 18'd4; B = 18'd2; D = 18'd3; C = 48'd10;
        @(negedge clk);
        @(negedge clk);
        @(negedge clk);
        @(negedge clk);
        @(negedge clk); 
        $display("Test 1 - ADD: P = %d (Expected: 30)", P);

        // Test Vector 2: ADD: (7 + 1) = 8, A = 6 → 6×8 = 48, C = 12 → P = 60
        @(negedge clk); A = 18'd6; B = 18'd1; D = 18'd7; C = 48'd12;
        @(negedge clk);
        @(negedge clk);
        @(negedge clk);
        @(negedge clk);
        @(negedge clk);
        $display("Test 2 - ADD: P = %d (Expected: 60)", P);

        // Wait a bit then finish
        #50;
        $finish;
    end

endmodule
