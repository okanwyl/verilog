module top_square #(parameter CORDW=10) (  
    input  wire logic clk_pix,             
    input  wire logic sim_rst,             
    output      logic [CORDW-1:0] sdl_sy,  
    output      logic sdl_de,              
    output      logic [7:0] sdl_r,         
    output      logic [7:0] sdl_g,         
    output      logic [7:0] sdl_b          
    );

    logic [CORDW-1:0] sx, sy;
    logic de;
    simple_480p display_inst (
        .clk_pix,
        .rst_pix(sim_rst),
        .sx,
        .sy,
        .hsync(),
        .vsync(),
        .de
    );

    logic square;
    always_comb begin
        square = (sx > 220 && sx < 420) && (sy > 140 && sy < 340);
    end

    logic [3:0] paint_r, paint_g, paint_b;
    always_comb begin
        paint_r = (square) ? 4'hF : 4'h1;
        paint_g = (square) ? 4'hF : 4'h3;
        paint_b = (square) ? 4'hF : 4'h7;
    end

    always_ff @(posedge clk_pix) begin
        sdl_sx <= sx;
        sdl_sy <= sy;
        sdl_de <= de;
        sdl_r <= {2{paint_r}};  
        sdl_g <= {2{paint_g}};
        sdl_b <= {2{paint_b}};
    end
endmodule