module forward_west (
    input  wire [15:0] packet_in,
    input  wire        valid_in,

    output reg  [15:0] packet_west,
    output reg         valid_west,
 
    output reg  [15:0] packet_local,
    output reg         valid_local
);

wire signed [3:0] dx;
assign dx = packet_in[15:12];

reg signed [4:0] dx_ext;
reg signed [3:0] dx_new;

always @* begin
    // defaults
    packet_west  = 16'b0; valid_west  = 1'b0;
    packet_local = 16'b0; valid_local = 1'b0;

    dx_ext = {dx[3], dx}; // sign-extend

    if (valid_in) begin
        if (dx < 0) begin
            // still needs to move west
            dx_new = dx_ext + 1;
            packet_west = packet_in;
            packet_west[15:12] = dx_new[3:0];
            valid_west = 1'b1;
        end
        else if (dx == 0) begin
            // horizontal done, hand to vertical/local
            packet_local = packet_in;
            valid_local = 1'b1;
        end
        else begin
            // Illegal case: shouldn't happen
            $display("Error: forward_west received dx > 0");
        end
    end
end

endmodule
