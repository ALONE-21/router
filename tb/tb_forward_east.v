`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 09.10.2025 16:05:41
// Design Name: 
// Module Name: tb_forward_east
// Project Name: 
// Target Devices: 
// Tool Versions: 
// Description: 
// 
// Dependencies: 
// 
// Revision:
// Revision 0.01 - File Created
// Additional Comments:
// 
//////////////////////////////////////////////////////////////////////////////////


module tb_forward_east;
    reg [15:0] packet_in;
    reg        valid_in;

    wire  [15:0] packet_east;
    wire         valid_east;

    wire  [15:0] packet_local;
    wire         valid_local;

forward_east dut (
    .packet_in(packet_in),
    .valid_in(valid_in),
    .packet_east(packet_east),
    .valid_east(valid_east),
    .packet_local(packet_local),
    .valid_local(valid_local)
);

initial begin
    $display("Starting forward_east testbench");

    // case 1: dx > 0 (dx = 2)
    // dx = packet_in[7:4] = 4'b0010
    packet_in = 16'b0000_0000_0010_0000;
    valid_in = 1;
    #10
    $display("case 1 dx = 2: packet_east = %b, valid_east = %b", packet_east, valid_east);

    // case 2: dx = 0
    packet_in = 16'b0000_0000_0000_0000;
    valid_in = 1;
    #10
    $display("case 2 dx = 0: packet_local = %b, valid_local = %b", packet_local, valid_local);

    $finish;
end
endmodule
