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


// Hub RAM
//
// This is instantiated 4 times to allow writing by byte, word or long

module              hub_ram
(
input               clk,
input               enable,
input               w,
input               wb,
input       [13:0]  a,
input        [7:0]  d8,

output       [7:0]  q8
);

// Size of RAM block in bytes.
parameter SIZE_BYTES;

reg [7:0] ram[SIZE_BYTES - 1:0];

always @(posedge clk)
begin
    if (enable && w && wb)
    begin
        ram[a] <= d8;
    end
    q8 <= ram[a];
end

endmodule


//-----------------------------------------------------------------------------
// Hub ROM
//
// The ROM size can be varied by overriding the parameter, but it's always
// mapped to the top of the hub space, regardless of whether the entire 32KB
// ROM is implemented or not.
// If the ROM size parameter is set to a value less than 8192 (32KB),
// the missing amount of ROM is mapped in front of the actual ROM.
// For example, if the ROM size is set to the minimum of 512 (4KB), the
// actual ROM starts at $F000 instead of $8000, and the macros declared
// below will insert 28KB of "missing ROM" in addresses $8000-$EFFF.
// A couple of macros are used to initialize the ROM and calculate addresses
// based on its size and/or the hub address where the image files need to
// be stored.

module hub_rom
(
input               clk,
input               enable,

input       [13:0]  a,
input       [31:0]  d,

output      [31:0]  q
);


// Size of hub ROM in longs
parameter SIZE_LONGS;

reg [31:0] rom [SIZE_LONGS - 1:0];

// Amount of missing ROM in longs
`define ROMMISSING (8192 - SIZE_LONGS)
// Calculate offset in ROM area ($8000-$FFFF) based on no missing ROM
`define ROMOFFSET(hubaddress) (((hubaddress) - 'h8000) >> 2)
// Init ROM from file unless the destination ROM is missing
`define ROMINIT(file, hubstart, hubend) \
    if (`ROMOFFSET(hubstart) >= `ROMMISSING) \
        $readmemh(file, rom, `ROMOFFSET(hubstart) - `ROMMISSING, `ROMOFFSET(hubend) - `ROMMISSING)

initial
begin
    `ROMINIT("rom_8000_bfff_font.hex",                      'h8000, 'hBFFF);
    `ROMINIT("rom_c000_cfff_log.hex",                       'hC000, 'hCFFF);
    `ROMINIT("rom_d000_dfff_antilog.hex",                   'hD000, 'hDFFF);
    `ROMINIT("rom_e000_f003_sine.hex",                      'hE000, 'hF003);
`ifdef ENABLE_UNSCRAMBLED_ROM
    `ROMINIT("rom_f004_f7a3_unscrambled_interpreter.hex",   'hF004, 'hF7A3);
    `ROMINIT("rom_f800_fb93_unscrambled_booter.hex",        'hF800, 'hFB93);
`else
    `ROMINIT("rom_f004_f7a3_scrambled_interpreter.hex",     'hF004, 'hF7A3);
    `ROMINIT("rom_f800_fb93_scrambled_booter.hex",          'hF800, 'hFB93);
`endif
    `ROMINIT("rom_ff00_ff5f_copyright.hex",                 'hFF00, 'hFF5F);
    `ROMINIT("rom_ff70_ffff_runner.hex",                    'hFF70, 'hFFFF);
end

always @(posedge clk)
begin
    q <= rom[a - `ROMMISSING];
end

endmodule


//-----------------------------------------------------------------------------
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


// RAM and ROM sizes in blocks.
// The standard Propeller has 32KB RAM, 32KB ROM
// RAM size should be 32KB, reduce at your own risk
// ROM should be between 512 and  8192 longs (4KB..32KB)
parameter HUB_RAM_SIZE_BYTES = 32768;
parameter HUB_ROM_SIZE_BYTES = 32768;

// Check if address is in RAM
// TODO: simplify with log2 combined with logical AND
wire in_ram = (a < HUB_RAM_SIZE_BYTES >> 2);

// Check if address is in ROM
// TODO: simplify with log2 combined with logical AND
wire in_rom = (a >= 16384 - (HUB_ROM_SIZE_BYTES >> 2));

// Instantiate 4 instances of RAM

reg [31:0] ram_q;

genvar i;
generate
    for (i = 0; i < 4; i = i + 1)
    begin : ramgen
        hub_ram 
            #(
                    .SIZE_BYTES (HUB_RAM_SIZE_BYTES >> 2)
            )
            ram_(
                    .clk        (clk_cog),
                    .enable     (ena_bus && in_ram),
                    .w          (w),
                    .wb         (wb[i]),
                    .a          (a),
                    .d8         (d[(i+1)*8-1:i*8]),
                    .q8         (ram_q[(i+1)*8-1:i*8])
            );
    end
endgenerate


// Instantiate ROM

reg [31:0] rom_q;

hub_rom 
    #(
                    .SIZE_LONGS (HUB_ROM_SIZE_BYTES >> 2)
    )
    rom_(
                    .clk        (clk_cog),
                    .enable     (ena_bus && in_rom),
                    .a          (a),
                    .d          (d),
                    .q          (rom_q)
    );

// memory output mux

reg mem;

always @(posedge clk_cog)
if (ena_bus)
    mem <= in_ram;

assign q = mem ? ram_q : rom_q;

endmodule
