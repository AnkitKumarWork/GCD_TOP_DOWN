module gcd_data_path(
    input clk,
    input rst,
    input ld_a, ld_b, sub_a, sub_b,
    input [31:0] a,
    input [31:0] b,
    output wire a_gt_b, b_gt_a, a_eq_b,
    output reg [31:0] GCD_OUT
);

    reg [31:0] temp_a;
    reg [31:0] temp_b;

    assign a_eq_b = (temp_a == temp_b);
    assign a_gt_b = (temp_a > temp_b);
    assign b_gt_a = (temp_b > temp_a);

    always @(posedge clk or posedge rst) begin
        if (rst) begin
            temp_a <= 0;
            temp_b <= 0;
        end else if (ld_a && ld_b) begin
            temp_a <= a;
            temp_b <= b;
        end else if (sub_a) begin
            temp_a <= temp_a - temp_b;
        end else if (sub_b) begin
            temp_b <= temp_b - temp_a;
        end
    end

    always @(posedge clk or posedge rst) begin
        if (rst) begin
            GCD_OUT <= 0;
        end else if (a_eq_b) begin
            GCD_OUT <= temp_a;
            end
            /*else 
            GCD_OUT <= temp_b;*/
        end

endmodule