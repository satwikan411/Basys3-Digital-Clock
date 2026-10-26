`timescale 1ns / 1ps

module dig_clk (
    input clk,          // 100MHz clock from Basys 3
    input reset,        // Reset button
    output reg [3:0] h1, // tens of hours
    output reg [3:0] h0, // ones of hours
    output reg [3:0] m1, // tens of minutes
    output reg [3:0] m0, // ones of minutes
    output reg [3:0] s1, // tens of seconds
    output reg [3:0] s0  // ones of seconds
);

reg [26:0] count = 0; // 27-bit register (needs to count up to 100,000,000)

always @(posedge clk or posedge reset) begin
    if (reset) begin
        count <= 0;
        h1 <= 0; h0 <= 0; m1 <= 0; m0 <= 0; s1 <= 0; s0 <= 0;
    end else begin
        count <= count + 1; 
        
        // 100MHz clock -> 1 second is 100,000,000 cycles
        if (count == 100_000_000) begin
            count <= 0;
            
            // Seconds ones (0-9)
            if (s0 == 9) begin
                s0 <= 0;
                
                // Seconds tens (0-5)
                if (s1 == 5) begin
                    s1 <= 0;
                    
                    // Minutes ones (0-9)
                    if (m0 == 9) begin
                        m0 <= 0;
                        
                        // Minutes tens (0-5)
                        if (m1 == 5) begin
                            m1 <= 0;
                            
                            // Hours ones (0-9)
                            if (h0 == 9) begin
                                h0 <= 0;
                                h1 <= h1 + 1; // Increment tens of hours
                            end 
                            // Handle 24-hour roll-over (23:59:59 -> 00:00:00)
                            else if (h1 == 2 && h0 == 3) begin
                                h1 <= 0;
                                h0 <= 0;
                            end
                            else begin
                                h0 <= h0 + 1;
                            end
                            
                        end else begin
                            m1 <= m1 + 1;
                        end
                    end else begin
                        m0 <= m0 + 1;
                    end
                end else begin
                    s1 <= s1 + 1;
                end
            end else begin
                s0 <= s0 + 1;
            end
        end
    end
end
endmodule
