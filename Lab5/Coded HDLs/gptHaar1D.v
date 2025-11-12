// -----------------------------------------------------------------------------
// haar_dwt_1d_stream.v
// Streaming 1-D Haar DWT (single level), pairwise average/difference.
// - Signed fixed-point friendly
// - No multiplies: add/sub + arithmetic shift
// Interface:
//   - Present in_valid + in_sample; pairs are consumed internally.
//   - For each pair, out_valid asserts for one cycle with low_out/high_out.
// -----------------------------------------------------------------------------
module haar_dwt_1d_stream #(
    parameter integer WIDTH = 16,        // sample bit-width (signed)
    parameter integer SCALE_SHIFT = 1    // 1 => divide by 2; 0 => no scale
)(
    input  wire                         clk,
    input  wire                         rst,        // sync reset, active-high
    input  wire                         in_valid,
    input  wire signed [WIDTH-1:0]      in_sample,

    output reg                          out_valid,
    output reg  signed [WIDTH-1:0]      low_out,    // approximation (L)
    output reg  signed [WIDTH-1:0]      high_out    // detail (H)
);

    reg         have_prev;
    reg signed [WIDTH-1:0] x0;

    // Pairwise processing: yL = (x0 + x1) >>> SCALE_SHIFT
    //                      yH = (x1 - x0) >>> SCALE_SHIFT
    always @(posedge clk) begin
        if (rst) begin
            have_prev <= 1'b0;
            out_valid <= 1'b0;
            x0        <= '0;
            low_out   <= '0;
            high_out  <= '0;
        end else begin
            out_valid <= 1'b0;

            if (in_valid) begin
                if (!have_prev) begin
                    x0        <= in_sample;
                    have_prev <= 1'b1;
                end else begin
                    // Second of the pair arrived
                    // Use wider temps to avoid intermediate overflow before shift
                    // (final assign truncates back to WIDTH)
                    // Note: arithmetic >>> keeps sign for negative values
                    low_out   <= ( ( $signed({{1{in_sample[WIDTH-1]}}, in_sample}) 
                                    + $signed({{1{x0[WIDTH-1]}}, x0}) ) >>> SCALE_SHIFT );
                    high_out  <= ( ( $signed({{1{in_sample[WIDTH-1]}}, in_sample}) 
                                    - $signed({{1{x0[WIDTH-1]}}, x0}) ) >>> SCALE_SHIFT );
                    out_valid <= 1'b1;
                    have_prev <= 1'b0;
                end
            end
        end
    end
endmodule
