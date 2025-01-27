module gcd_top (
    input clk,
    input rst,
    input go,
    input [31:0] a,
    input [31:0] b,
    output [31:0] GCD_OUT
);

    // Internal wires for control signals
    wire ld_a, ld_b, sub_a, sub_b;
    wire a_gt_b, b_gt_a, a_eq_b;

    // Instantiate gcd_data_path module
    gcd_data_path datapath (
        .clk(clk),
        .rst(rst),
        .ld_a(ld_a),
        .ld_b(ld_b),
        .sub_a(sub_a),
        .sub_b(sub_b),
        .a(a),
        .b(b),
        .a_gt_b(a_gt_b),
        .b_gt_a(b_gt_a),
        .a_eq_b(a_eq_b),
        .GCD_OUT(GCD_OUT)
    );

    // Instantiate gcd_controller module
    gcd_controller controller (
        .clk(clk),
        .rst(rst),
        .a_gt_b(a_gt_b),
        .b_gt_a(b_gt_a),
        .a_eq_b(a_eq_b),
        .go(go),
        .ld_a(ld_a),
        .ld_b(ld_b),
        .sub_a(sub_a),
        .sub_b(sub_b)
    );

endmodule
