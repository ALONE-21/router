`timescale 1ns/1ps

module tb_from_local;

  // Inputs
  reg  [15:0] packet_in;
  reg         valid_in;

  // Outputs
  wire [15:0] packet_east;
  wire        valid_east;

  wire [15:0] packet_west;
  wire        valid_west;

  wire [15:0] packet_local;
  wire        valid_local;

  // Instantiate the DUT (Device Under Test)
  from_local dut (
    .packet_in(packet_in),
    .valid_in(valid_in),
    .packet_east(packet_east),
    .valid_east(valid_east),
    .packet_west(packet_west),
    .valid_west(valid_west),
    .packet_local(packet_local),
    .valid_local(valid_local)
  );

  initial begin
    $display("=== Starting from_local testbench ===");

    // Case 1: dx > 0 (dx=3)
    packet_in = 16'b0011_0000_0000_0000; // dx=3, rest = 0
    valid_in  = 1;
    #10;
    $display("Case dx=3: packet_east=%b, valid_east=%b", packet_east, valid_east);

    // Case 2: dx < 0 (dx=-2)
    packet_in = 16'b1110_0000_0000_0000; // dx=-2 (1110 in signed 4-bit)
    valid_in  = 1;
    #10;
    $display("Case dx=-2: packet_west=%b, valid_west=%b", packet_west, valid_west);

    // Case 3: dx == 0
    packet_in = 16'b0000_0000_0000_0000; // dx=0
    valid_in  = 1;
    #10;
    $display("Case dx=0: packet_local=%b, valid_local=%b", packet_local, valid_local);

    // Finish
    $finish;
  end

endmodule
