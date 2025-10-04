`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 10/04/2025 02:03:18 AM
// Design Name: 
// Module Name: tb_forward_north
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


module tb_forward_north;
    reg [15:0] packet_in;
    reg        valid_in;

    wire  [15:0] packet_north;
    wire        valid_north;

    wire  [15:0] packet_local;
    wire         valid_local;

forward_north dut (
    .packet_in(packet_in),
    .valid_in(valid_in),
    .packet_north(packet_north),
    .valid_north(valid_north),
    .packet_local(packet_local),
    .valid_local(valid_local)
);

initial begin
    $display("starting of local testbench");
    //case 1 dy >0  dy = packet_in[11:8]
    packet_in = 16'b0000_0010_0000_0000;
    valid_in = 1;
    #10
    $display("case 1 dy = 2: packet_north = %b, valid_north = %b",packet_north,valid_north);
    
    //case 2 dy = 0  dy = packet_in[11:8]
    packet_in = 16'b0000_0000_0000_0000;
    valid_in = 1;
    $display("case 1 dy = 0: packet_local = %b, valid_local = %b",packet_local,valid_local); 
    $finish;
   end
endmodule
