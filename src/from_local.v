`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 09/28/2025 02:22:12 AM
// Design Name: 
// Module Name: from_local
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


module from_local (
    input  wire [15:0] packet_in,
    input  wire        valid_in,

    output reg  [15:0] packet_east,
    output reg         valid_east,

    output reg  [15:0] packet_west,
    output reg         valid_west,

    // when dx == 0 we forward to local/vertical stack
    output reg  [15:0] packet_local,
    output reg         valid_local
);

// Extract dx as a signed 4-bit value
wire signed [3:0] dx;
assign dx = packet_in[15:12];

// temporary regs for safe signed arithmetic
reg signed [4:0] dx_ext;   // one extra bit for arithmetic
reg signed [3:0] dx_new;   // result fits back into 4 bits

always @* begin
    // defaults (prevent latches)
    packet_east  = 16'b0; valid_east  = 1'b0;
    packet_west  = 16'b0; valid_west  = 1'b0;
    packet_local = 16'b0; valid_local = 1'b0;

    // sign-extend dx into dx_ext (replicate sign bit)
    dx_ext = {dx[3], dx}; // now dx_ext is signed [4:0]

    if (valid_in) begin
        if (dx > 0) begin
            // move east: decrement dx by 1
            dx_new = dx_ext - 1;           // signed arithmetic
            packet_east = packet_in;       // copy whole packet
            packet_east[15:12] = dx_new[3:0]; // update dx field
            valid_east = 1'b1;
        end
        else if (dx < 0) begin
            // move west: increment dx by 1 (towards zero)
            dx_new = dx_ext + 1;
            packet_west = packet_in;
            packet_west[15:12] = dx_new[3:0];
            valid_west = 1'b1;
        end
        else begin
            // dx == 0 -> forward to vertical/local handling
            packet_local = packet_in;
            valid_local = 1'b1;
        end
    end
end

endmodule

