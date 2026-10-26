`timescale 1ns / 1ps

module seg_decoder(
    input clk100,
    input reset,
    input [3:0] H2,
    input [3:0] H1,
    input [3:0] M2,
    input [3:0] M1,
    input [3:0] S2,
    input [3:0] S1,
    output reg [0:6] seg,
    output reg [3:0] digit
    );
    
    // 7-segment patterns for Basys 3 (Active Low: 0 turns the segment ON)
    parameter ZERO   = 7'b000_0001;
    parameter ONE    = 7'b100_1111;
    parameter TWO    = 7'b001_0010;
    parameter THREE  = 7'b000_0110;
    parameter FOUR   = 7'b100_1100;
    parameter FIVE   = 7'b010_0100;
    parameter SIX    = 7'b010_0000;
    parameter SEVEN  = 7'b000_1111;
    parameter EIGHT  = 7'b000_0000;
    parameter NINE   = 7'b000_0100;
    parameter BLANK  = 7'b111_1111;
    
    reg [1:0] digit_select;
    reg [16:0] digit_timer;
    reg [3:0] current_digit;
    
    // Clock divider for display multiplexing (approx 1kHz refresh rate)
    always @(posedge clk100 or posedge reset)
    begin
        if(reset) begin
            digit_select <= 0;
            digit_timer <= 0;
        end
        else if(digit_timer == 99_999) begin
            digit_timer <= 0;
            digit_select <= digit_select + 1;
        end
        else begin
            digit_timer <= digit_timer + 1; // FIXED: Non-blocking assignment
        end
    end
    
    // Multiplexer: Select which digit to show on the 4 displays
    always @(*) begin
        case(digit_select)
            2'b00: begin digit = 4'b1110; current_digit = S1; end // Rightmost: Seconds
            2'b01: begin digit = 4'b1101; current_digit = S2; end 
            2'b10: begin digit = 4'b1011; current_digit = M1; end 
            2'b11: begin digit = 4'b0111; current_digit = M2; end // Leftmost: Minutes
        endcase
    end
    
    // 7-Segment Decoder
    always @(*) begin
        case(current_digit)
            4'd0: seg = ZERO;
            4'd1: seg = ONE;
            4'd2: seg = TWO;
            4'd3: seg = THREE;
            4'd4: seg = FOUR;
            4'd5: seg = FIVE;
            4'd6: seg = SIX;
            2'd7: seg = SEVEN;
            2'd8: seg = EIGHT;
            2'd9: seg = NINE;
            default: seg = BLANK;
        endcase    
    end    
endmodule
