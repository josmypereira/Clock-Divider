`timescale 1ns / 1ps  // Define the time unit and precision for simulation

// Clock Divider Module
// This module divides the frequency of an input clock signal based on a given ratio.
module clock_divider(
    input  clk_in,           // Input clock signal (high frequency)
    output reg clk_out,      // Output clock signal (divided frequency)
    input  reset,            // Active-low reset signal
    input  [31:0] ratio      // Division ratio (32-bit value)
    );

  reg [31:0] counter;        // 32-bit counter to track clock cycles

  // Always block triggered on the rising edge of clk_in or the falling edge of reset
  always @ (posedge clk_in, negedge reset) begin
    if (reset == 0) begin
      // When reset is active (low), reset the counter and clk_out
      counter <= 32'd0;     // Initialize counter to 0
      clk_out <= 0;         // Initialize output clock to 0
    end else begin
      if (counter == ratio - 1) begin
        // When counter reaches (ratio - 1), reset counter and clk_out
        $display("ratio-1 = counter: %d", counter); // Debugging display for simulation
        clk_out <= 0;       // Set output clock to 0
        counter <= 32'd0;   // Reset counter
      end else if (counter == (ratio / 2) - 1) begin
        // When counter reaches (ratio / 2 - 1), toggle clk_out to 1
        $display("ratio/2 -1 = counter: %d", counter); // Debugging display for simulation
        clk_out <= 1;       // Set output clock to 1
        counter <= counter + 1; // Increment counter
      end else begin
        // For all other counter values, increment the counter
        counter <= counter + 1;
      end
    end
  end
endmodule
