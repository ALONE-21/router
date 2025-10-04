module forward_north (
    input  wire [15:0] packet_in,
    input  wire        valid_in,

    output reg  [15:0] packet_north,
    output reg         valid_north,

    output reg  [15:0] packet_local,
    output reg         valid_local
);

wire signed [3:0] dy;
assign dy = packet_in[11:8]; // extract dy field

reg signed [4:0] dy_ext;
reg signed [3:0] dy_new;

always @* begin
    // defaults
    packet_north = 16'b0; valid_north = 1'b0;
    packet_local = 16'b0; valid_local = 1'b0;

    dy_ext = {dy[3], dy}; // sign extend to 5 bits

    if (valid_in) begin
        if (dy > 0) begin
            // keep going north
            dy_new = dy_ext - 1;
            packet_north = packet_in;
            packet_north[11:8] = dy_new[3:0];
            valid_north = 1'b1;
        end
        else if (dy == 0) begin
            // reached correct row
            packet_local = packet_in;
            valid_local = 1'b1;
        end
        else begin
            // illegal case
            $display("Error: forward_north received dy < 0");
        end
    end
end

endmodule
