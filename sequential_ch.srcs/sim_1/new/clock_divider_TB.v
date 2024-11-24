`timescale 1ns / 1ps  // Define the time unit and precision for simulation

// Testbench module for the clock divider
module clock_divider_TB();
  reg clk_fast, reset;       // Declare the fast clock and reset signals
  wire clk_slow;             // Wire for the slower divided clock output
  
  // Generate the fast clock signal with a period of 10ns (100 MHz frequency)
  always #5 clk_fast = ~clk_fast;

  // Instantiate the clock divider module (Device Under Test - DUT)
  clock_divider DUT_divider(
    .clk_in(clk_fast),       // Connect the fast clock to the divider
    .clk_out(clk_slow),      // Connect the output from the divider to clk_slow
    .reset(reset),           // Connect the reset signal
    .ratio(32'd100_000)      // Set the division ratio (100,000 for 1 kHz output)
  );

  // Initial block to provide stimulus to the DUT
  initial begin
    clk_fast = 0;            // Initialize fast clock to 0
    reset = 0;               // Hold reset active (low)
    #999_996;                // Wait for a specific duration (999,996 ns)
    reset = 1;               // Release the reset (set to high)
    #10_000_000;             // Run the simulation for 10,000,000 ns
    $stop;                   // Stop the simulation
  end
endmodule
