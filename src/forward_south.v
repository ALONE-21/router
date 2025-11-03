`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 09.10.2025 16:02:13
// Design Name: 
// Module Name: forward_south
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


module forward_south (
    input  wire [15:0] packet_in,
    input  wire        valid_in,

    output reg  [15:0] packet_south,
    output reg         valid_south,

    output reg  [15:0] packet_local,
    output reg         valid_local
);

wire signed [3:0] dy;
assign dy = packet_in[11:8]; // extract dy field

reg signed [4:0] dy_ext;
reg signed [3:0] dy_new;

always @* begin
    // defaults
    packet_south = 16'b0; valid_south = 1'b0;
    packet_local = 16'b0; valid_local = 1'b0;

    dy_ext = {dy[3], dy}; // sign extend to 5 bits

    if (valid_in) begin
        if (dy > 0) begin
            // move south (increment dy)
            dy_new = dy_ext - 1;
            packet_south = packet_in;
            packet_south[11:8] = dy_new[3:0];
            valid_south = 1'b1;
        end
        else if (dy == 0) begin
            // reached correct row
            packet_local = packet_in;
            valid_local = 1'b1;
        end
        else begin
            // illegal case
            $display("Error: forward_south received dy < 0");
        end
    end
end

endmodule

