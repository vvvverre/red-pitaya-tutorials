`timescale 1ns / 1ps
`default_nettype none

module blink #
(
    // Width of data bus in bits
    parameter COUNTER_WIDTH = 26
)
(
    input  wire         clk,
    input  wire         rstn,

    output wire         led
);

    reg [COUNTER_WIDTH-1:0] counter = 0;

    assign led = counter[COUNTER_WIDTH-1];

    always @(clk)
        if (!rstn)
            counter <= 0;
        else
            counter <= counter + 1;

endmodule

`default_nettype wire

