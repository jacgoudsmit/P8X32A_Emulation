// features

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


//-----------------------------------------------------------------------------
// Invert Cog LED outputs
//
// Define this macro in your project to invert the cog LEDs, for hardware that
// turns the LEDs on when the outputs are low instead of high.
`ifdef INVERT_COG_LEDS
defparam core.INVERT_COG_LEDS = `INVERT_COG_LEDS;
`endif


//-----------------------------------------------------------------------------
// Unscrambled ROM
//
// If this is defined, the unscrambled version of the interpreter and boot
// loader are used, instead of the usual scrambled version as found on the
// Propeller chip.
// The Propeller chip has some circuitry that swaps the bits of some areas
// of the ROM if you try to read them directly from a program, because when
// the chip was originally designed, there was some concern that others might
// make counterfit Propellers. Later on, Parallax decided to open-source the
// original source code for the binary code that's on-board the chip.
// The scrambling circuitry is no longer necessary, and it saves some space if
// the chip doesn't have it, but strictly speaking, it makes the ROM content
// different from the original, so this option is off by default.
//
//`define ENABLE_UNSCRAMBLED_ROM


//-----------------------------------------------------------------------------
// Hub ROM size
//
// Define this to override the ROM size used. Not all hardware can support the
// entire ROM. For example, on the DE0-Nano, the font doesn't fit so its .qsf
// file has an override for this macro.
// The default ROM size is 32768 bytes, which is also the maximum.
// The minimum ROM size is 4092 bytes, otherwise the system won't boot.
// Depending on the ROM size, the following features will be available:
//
// Required     ROM starts  Data
// ROM Size:    at Address:
// ------------------------------------
// 32768        $8000       Font
// 16384        $C000       Logarithmic table
// 12288        $D000       Anti-logarithmic table
// 8192         $E000       Sine table
// 4092         $F004       Spin interpreter
// (*)          $F800       Boot loader
// (*)          $FF00       Copyright message
// (*)          $FF70       Runner
//
// (*) Do not set the ROM size to a value below the minimum, or the system
// won't boot. The interpreter, boot loader and runner are all needed.
`ifdef HUB_ROM_SIZE_BYTES
defparam core.hub_.hub_mem_.HUB_ROM_SIZE_BYTES = `HUB_ROM_SIZE_BYTES;
`endif


//-----------------------------------------------------------------------------
// Hub RAM size
//
// Define this to change the size of the hub RAM. The default size is 32768.
// Note: when the chip loads a program from EEPROM or serial port, it still
// loads 32KB regardless of this setting.
// If you set the RAM to be larger, you can store more data but you won't be
// able to access the ROM that would normally be in that place.
// If you set the RAM size to more than 60KB, the system won't boot because
// the top 4KB of the hub are needed to start up.
`ifdef HUB_RAM_SIZE_BYTES
defparam core.hub_.hub_mem_.HUB_RAM_SIZE_BYTES = `HUB_RAM_SIZE_BYTES;
`endif
