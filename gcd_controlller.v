module gcd_controller (
    input clk,
    input rst,
    input a_gt_b, b_gt_a, a_eq_b,
    input go,
    output reg ld_a, ld_b, sub_a, sub_b
);

    reg [1:0] ps, ns;

    parameter IDLE = 2'b00,
              LOAD = 2'b01,
              COMPARE = 2'b10,
              FINISH = 2'b11;

    always @(posedge clk or posedge rst) begin
        if (rst) begin
            ps <= IDLE;
        end else begin
            ps <= ns;
        end
    end

    always @(*) begin
        ld_a = 0;
        ld_b = 0;
        sub_a = 0;
        sub_b = 0;
        case (ps)
            IDLE: ns = (go) ? LOAD : IDLE;
            LOAD: begin
                ns = COMPARE;
                ld_a = 1;
                ld_b = 1;
            end
            COMPARE: begin
                if (a_gt_b) begin
                    ns = COMPARE;
                    sub_a = 1;
                end else if (b_gt_a) begin
                    ns = COMPARE;
                    sub_b = 1;
                end else if(a_eq_b) begin
                    ns = FINISH;
                end
            end
            FINISH: ns = IDLE;
            default: ns = IDLE;
        endcase
    end

endmodule
