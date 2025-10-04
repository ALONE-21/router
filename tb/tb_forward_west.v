`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 10/04/2025 01:19:28 AM
// Design Name: 
// Module Name: tb_forward_west
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


module tb_forward_west;
    reg [15:0] packet_in;
    reg        valid_in;

    wire  [15:0] packet_west;
    wire         valid_west;

    wire [15:0] packet_local;
    wire        valid_local;
forward_west dut(
    .packet_in(packet_in),
    .valid_in(valid_in),
    .packet_west(packet_west),
    .valid_west(valid_west),
    .packet_local(packet_local),
    .valid_local(valid_local)
);

initial begin
    $display("starting of local testbench");
    //case 1 dx < 0 (dx = -2)
    packet_in = 16'b1110_0000_0000_0000;
    valid_in = 1;
    #10
    $display("Case dx=-2: packet_west=%b, valid_west=%b", packet_west, valid_west);
    //case2 dx = 0 
    packet_in = 16'b0000_0000_0000_0000;
    valid_in = 1;
    #10
    $display("Case dx=0: packet_local=%b, valid_local=%b", packet_local, valid_local);
    $finish;
end    
endmodule
