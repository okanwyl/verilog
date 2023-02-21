module ledclk(input clk);
reg led;

always @(posedge clk) begin
        led <= ~led;
end

output led;

endmodule