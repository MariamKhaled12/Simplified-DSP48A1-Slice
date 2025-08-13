module DSP48A1 #(
    parameter OPERATION = "ADD"  // "ADD" or "SUBTRACT"
)(
    input clk, rst_n,
    input [17:0] A, B, D,
    input [47:0] C,
    output reg [47:0] P
);
    reg [17:0] A_ff, B_ff, D_ff, A_ff2;
    reg [17:0] addsub_out;
    reg [35:0] mult_out;
    reg [47:0] C_ff;
    reg [47:0] addsub_mult_out;

    always @(posedge clk or negedge rst_n) begin
        if (!rst_n) begin
            A_ff <= 18'd0;
            B_ff <= 18'd0;
            D_ff <= 18'd0;
            addsub_out <= 18'd0;
            mult_out <= 36'd0;
            C_ff <= 48'd0;
            A_ff2 <= 18'd0;
            addsub_mult_out <= 48'd0;
            P <= 48'd0;
        end else begin
            A_ff <= A;
            B_ff <= B;
            D_ff <= D;
            C_ff <= C;

            if (OPERATION == "ADD")
                addsub_out <= D_ff + B_ff;
            else
                addsub_out <= D_ff - B_ff;

            A_ff2<= A_ff;

            mult_out <= A_ff2 * addsub_out;

            if (OPERATION == "ADD")
                P <= {{12{mult_out[35]}}, mult_out} + C_ff; 
            else
                P <= {{12{mult_out[35]}}, mult_out} - C_ff;

            //P <= addsub_mult_out;
            //P<= P_ff;
        end
    end
endmodule
