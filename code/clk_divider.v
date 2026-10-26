`timescale 1ns / 1ps

module clock_divider(
    input clk,
    output reg clkout
    );
    
    reg [25:0] count = 0; // FIXED: Initialize count
    initial clkout = 0;   // FIXED: Initialize output
    
    always@(negedge clk)
    begin
        count <= count + 1;
        if(count >= 50000000) // FIXED: Changed == to >= to be safe
        begin
            clkout <= ~clkout;
            count <= 0;
        end
    end
endmodule
