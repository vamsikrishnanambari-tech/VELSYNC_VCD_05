module matrix_multiplier_lp (
    input  wire        clk,
    input  wire        rst,
    input  wire        enable,        // Clock-gating enable
    input  wire [127:0] A_flat,        // 16 × 8-bit
    input  wire [127:0] B_flat,        // 16 × 8-bit
    output reg  [255:0] C_flat,        // 16 × 16-bit
    output reg         done
);

    // ------------------------------
    // Internal storage
    // ------------------------------
    reg [7:0]  A [0:3][0:3];
    reg [7:0]  B [0:3][0:3];
    reg [15:0] C [0:3][0:3];

    reg [15:0] acc;     // accumulator
    reg [1:0]  i, j, k; // indices

    // ------------------------------
    // Clock gating (safe RTL style)
    // ------------------------------
    wire gclk = clk & enable;

    // ------------------------------
    // Unpack input matrices
    // ------------------------------
    integer x, y;
    always @(*) begin
        for (x = 0; x < 4; x = x + 1)
            for (y = 0; y < 4; y = y + 1) begin
                A[x][y] = A_flat[(x*4 + y)*8 +: 8];
                B[x][y] = B_flat[(x*4 + y)*8 +: 8];
            end
    end

    // ------------------------------
    // Sequential computation
    // Resource sharing: 1 multiplier + 1 adder
    // ------------------------------
    always @(posedge gclk or posedge rst) begin
        if (rst) begin
            i    <= 0;
            j    <= 0;
            k    <= 0;
            acc  <= 0;
            done <= 0;
        end else begin
            acc <= acc + (A[i][k] * B[k][j]);

            if (k == 3) begin
                C[i][j] <= acc + (A[i][k] * B[k][j]);
                acc <= 0;
                k <= 0;

                if (j == 3) begin
                    j <= 0;
                    if (i == 3) begin
                        done <= 1;   // Computation complete
                        i <= 0;
                    end else begin
                        i <= i + 1;
                    end
                end else begin
                    j <= j + 1;
                end
            end else begin
                k <= k + 1;
            end
        end
    end

    // ------------------------------
    // Pack output matrix
    // ------------------------------
    always @(*) begin
        for (x = 0; x < 4; x = x + 1)
            for (y = 0; y < 4; y = y + 1)
                C_flat[(x*4 + y)*16 +: 16] = C[x][y];
    end

endmodule
