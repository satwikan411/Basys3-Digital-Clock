`timescale 1ns / 1ps

module JK_FF(
    input J,
    input K,
    input clk,
    input clr,  // Clear (Active High)
    input pst,  // Preset (Active High)
    output reg Q,
    output Qbar
    );
    
    assign Qbar = ~Q; // Qbar is always the inverse of Q
    
    always @(posedge clk or posedge clr or posedge pst)
    begin
        if (clr)
            Q <= 1'b0;
        else if (pst)
            Q <= 1'b1;
        else begin
            case ({J, K})
                2'b00: Q <= Q;      // Hold
                2'b01: Q <= 1'b0;   // Reset
                2'b10: Q <= 1'b1;   // Set
                2'b11: Q <= ~Q;     // Toggle
            endcase
        end
    end
endmodule
