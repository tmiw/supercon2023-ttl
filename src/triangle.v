module triangle(input wire clk, input wire reset, input wire [3:0] shift_by, output reg [15:0] out);

reg [25:0] ctr;
reg [25:0] dir;

always @(posedge clk)
begin
    if (reset)
    begin
        ctr <= 0;
        dir <= 4 << shift_by;
    end

    if (ctr >= 24000000 && dir > 0)
        dir <= (-4) << shift_by;
    else if (ctr == 0 && dir < 0)
        dir <= 4 << shift_by;

    ctr <= ctr + dir;
    out <= ctr[24:9];
end

endmodule
