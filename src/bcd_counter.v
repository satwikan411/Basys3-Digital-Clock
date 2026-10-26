`timescale 1ns / 1ps

module BCDcounter(
    input clk1,
    input rst,
    output [3:0] count
    );
    wire clk;
    wire [3:0] qbar;
    clock_divider cl(.clk(clk1),.clkout(clk));
    JK_FF jk0(.J(1),.K(1),.clk(clk),.clr(rst || (count[3] && count[1])),.pst(0),.Q(count[0]),.Qbar(qbar[0]));
    JK_FF jk1(.J(1),.K(1),.clk(count[0]),.clr(rst || (count[3] && count[1])),.pst(0),.Q(count[1]),.Qbar(qbar[1]));
    JK_FF jk2(.J(1),.K(1),.clk(count[1]),.clr(rst || (count[3] && count[1])),.pst(0),.Q(count[2]),.Qbar(qbar[2]));
    JK_FF jk3(.J(1),.K(1),.clk(count[2]),.clr(rst || (count[3] && count[1])),.pst(0),.Q(count[3]),.Qbar(qbar[3]));

endmodule
