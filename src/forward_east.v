`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 09.10.2025 15:53:22
// Design Name: 
// Module Name: forward_east
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


module forward_east (
    input  wire [15:0] packet_in,
    input  wire        valid_in,

    output reg  [15:0] packet_east,
    output reg         valid_east,

    output reg  [15:0] packet_local,
    output reg         valid_local
);

wire signed [3:0] dx;
assign dx = packet_in[7:4]; // extract dx field

reg signed [4:0] dx_ext;
reg signed [3:0] dx_new;

always @* begin
    // defaults
    packet_east  = 16'b0; valid_east  = 1'b0;
    packet_local = 16'b0; valid_local = 1'b0;

    dx_ext = {dx[3], dx}; // sign extend to 5 bits

    if (valid_in) begin
        if (dx > 0) begin
            // keep going east
            dx_new = dx_ext - 1;
            packet_east = packet_in;
            packet_east[7:4] = dx_new[3:0];
            valid_east = 1'b1;
        end
        else if (dx == 0) begin
            // reached correct column
            packet_local = packet_in;
            valid_local = 1'b1;
        end
        else begin
            // illegal case
            $display("Error: forward_east received dx < 0");
        end
    end
end

endmodule

