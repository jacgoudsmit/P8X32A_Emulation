// hub_mem

/*
-------------------------------------------------------------------------------
Copyright 2014 Parallax Inc.

This file is part of the hardware description for the Propeller 1 Design.

The Propeller 1 Design is free software: you can redistribute it and/or modify
it under the terms of the GNU General Public License as published by the
Free Software Foundation, either version 3 of the License, or (at your option)
any later version.

The Propeller 1 Design is distributed in the hope that it will be useful,
but WITHOUT ANY WARRANTY; without even the implied warranty of MERCHANTABILITY
or FITNESS FOR A PARTICULAR PURPOSE.  See the GNU General Public License for
more details.

You should have received a copy of the GNU General Public License along with
the Propeller 1 Design.  If not, see <http://www.gnu.org/licenses/>.
-------------------------------------------------------------------------------
*/


// Submodule for one 8-bit block of RAM
// This is instantiated 4 times to allow writing by byte, word or long

module              byte_ram
(
input               clk_cog,
input               enable,
input               w,
input               wb,
input       [13:0]  a,
input        [7:0]  d8,

output       [7:0]  q8
);

parameter HUB_RAM_SIZE_LONGS = 8192;

reg [7:0] ram[HUB_RAM_SIZE_LONGS - 1:0];

always @(posedge clk_cog)
begin
    if (enable)
    begin
        if (w && wb)
            ram[a] <= d8;
        q8 <= ram[a[12:0]];
    end
end

endmodule


// Hub memory

module              hub_mem
(
input               clk_cog,
input               ena_bus,
input               nres,

input               w,
input        [3:0]  wb,
input       [13:0]  a,
input       [31:0]  d,

output      [31:0]  q
);


reg [31:0] ram_q;

genvar i;
generate
    for (i = 0; i < 4; i = i + 1)
    begin : ramgen
        byte_ram ram_(  .clk_cog    (clk_cog),
                        .enable     (ena_bus),
                        .w          (w),
                        .wb         (wb[i]),
                        .a          (a),
                        .d8         (d[(i+1)*8-1:i*8]),
                        .q8         (ram_q[(i+1)*8-1:i*8])
                      );
    end
endgenerate


// 4096 x 32 rom containing character definitions ($8000..$BFFF)

(* ram_init_file = "hub_rom_low.hex" *)     reg [31:0] rom_low [4095:0];

reg [31:0] rom_low_q;

always @(posedge clk_cog)
if (ena_bus && a[13:12] == 2'b10)
    rom_low_q <= rom_low[a[11:0]];


// 4096 x 32 rom containing sin table, log table, booter, and interpreter ($C000..$FFFF)

(* ram_init_file = "hub_rom_high.hex" *)    reg [31:0] rom_high [4095:0];

reg [31:0] rom_high_q;

always @(posedge clk_cog)
if (ena_bus && a[13:12] == 2'b11)
    rom_high_q <= rom_high[a[11:0]];


// memory output mux

reg [1:0] mem;

always @(posedge clk_cog)
if (ena_bus)
    mem <= a[13:12];

assign q            = !mem[1]   ? ram_q
`ifndef DISABLE_CHARACTER_ROM
                    : !mem[0]   ? rom_low_q
`endif
                                : rom_high_q;

endmodule
