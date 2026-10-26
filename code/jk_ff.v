`timescale 1ns / 1ps

module JK_FF(
    input J,
    input K,
    input pst,
    input clr,
    input clk,
    output reg Q,
    output Qbar
    );
    
    assign Qbar = ~Q; // Automatically inverse, prevents glitches
    
    always @(negedge clk or posedge clr or posedge pst)
    begin
        if(clr==1) begin
            Q <= 0;
        end
        else if(pst==1) begin
            Q <= 1;
        end
        else if(J==0 && K==0) begin
            Q <= Q;
        end
        else if(J==1 && K==1) begin
            Q <= ~Q;
        end
        else if(J != K) begin // FIXED: Replaced J == -K with J != K
            Q <= J;
        end
    end    
endmodule
