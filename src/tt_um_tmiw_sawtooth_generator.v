`default_nettype none

module tt_um_tmiw_sawtooth_generator (
    input  wire [7:0] ui_in,    // Dedicated inputs - connected to the input switches
    output wire [7:0] uo_out,   // Dedicated outputs - connected to the 7 segment display
    input  wire [7:0] uio_in,   // IOs: Bidirectional Input path
    output wire [7:0] uio_out,  // IOs: Bidirectional Output path
    output wire [7:0] uio_oe,   // IOs: Bidirectional Enable path (active high: 0=input, 1=output)
    input  wire       ena,      // will go high when the design is enabled
    input  wire       clk,      // clock
    input  wire       rst_n     // reset_n - low to reset
);

    wire reset = ! rst_n;

    assign uio_oe = 8'b11111111;

    wire [15:0] pcm;
    triangle tri_inst(clk, reset, ui_in[7:4], pcm);

    reg pdm_out;
    wire [15:0] pdm_err;

    pdm pdm_gen(clk, pcm, reset, pdm_out, pdm_err);

    assign uio_out = { pdm_out, pcm[15:9] };
    assign uo_out = { pdm_out, pcm[15:9] };

endmodule
