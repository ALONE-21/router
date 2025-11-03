`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 09.10.2025 16:06:43
// Design Name: 
// Module Name: tb_forward_south
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


module tb_forward_south;
    reg [15:0] packet_in;
    reg        valid_in;

    wire  [15:0] packet_south;
    wire         valid_south;

    wire  [15:0] packet_local;
    wire         valid_local;

forward_south dut (
    .packet_in(packet_in),
    .valid_in(valid_in),
    .packet_south(packet_south),
    .valid_south(valid_south),
    .packet_local(packet_local),
    .valid_local(valid_local)
);

initial begin
    $display("Starting forward_south testbench");

    // case 1: dy > 0 (dy = 3)
    // dy = packet_in[11:8] = 4'b0011
    packet_in = 16'b0000_0011_0000_0000;
    valid_in = 1;
    #10
    $display("case 1 dy = 3: packet_south = %b, valid_south = %b", packet_south, valid_south);

    // case 2: dy = 0
    packet_in = 16'b0000_0000_0000_0000;
    valid_in = 1;
    #10
    $display("case 2 dy = 0: packet_local = %b, valid_local = %b", packet_local, valid_local);

    $finish;
end
endmodule

