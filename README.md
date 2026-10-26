# Basys 3 FPGA Digital Clock

## Project Overview
This project is a fully functional digital clock implemented on the Digilent Basys 3 FPGA board (Artix-7) using Verilog HDL. It displays hours, minutes, and seconds (MM:SS format) on the onboard 4-digit 7-segment display.

This project demonstrates **hardware-software co-design**, **clock domain management**, and **digital logic design** using a modular architecture.

## Hardware & Tools
*   **Board:** Digilent Basys 3 (Artix-7 XC7A35T)
*   **Language:** Verilog HDL
*   **Software:** Xilinx Vivado
*   **Peripherals:** 100MHz onboard oscillator, 4-digit 7-segment display, push buttons.

## Architecture & Technical Implementation
The design is highly modular. The top-level module **(`dig_clk.v`)** instantiates and connects the following sub-modules:

1.  **Clock Divider (`clock_divider.v`):** Divides the 100MHz system clock down to a 1Hz signal to drive the real-time seconds counter.
2.  **BCD Counters (`BCDcounter.v` & `JK_FF.v`):** Implements cascaded Binary Coded Decimal counters using JK Flip-Flops to handle the seconds (00-59) and minutes (00-59) logic.
3.  **7-Segment Multiplexer & Decoder (`seg_decoder.v`):** Uses a high-speed internal timer to rapidly switch between the four display digits (anodes) while decoding the BCD values to the correct LED segments (cathodes). This persistence of vision creates the illusion that all four digits are continuously illuminated.
4.  **Pin Constraints (`Basys3.xdc`):** Maps the Verilog top-level I/O ports to the physical FPGA pins (clock, anodes, cathodes, and reset button).

## How to Run
1. Open Xilinx Vivado and create a new project targeting the **Basys 3** board.
2. Add all `.v` files from this repository as **Design Sources**.
3. Add the `Basys3.xdc` file as a **Constraints Source**.
4. Run **Synthesis**, **Implementation**, and **Generate Bitstream**.
5. Connect the Basys 3 board via USB, open the Hardware Manager, and program the device.

## Result
*The clock successfully counts seconds and minutes, displaying the time on the 7-segment display. The center button on the Basys 3 board acts as an asynchronous reset.*
