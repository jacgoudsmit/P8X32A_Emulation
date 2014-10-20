{{

An example on how to blink a LED with a P8X32A using the Cog's Counter Module.

LED is on pin 0. Blink frequency is 2 Hz.

Released for use under GPLv3 or later.

2014-10-20 Wilfried Klaebe <w+propeller@chaos.in-kiel.de>

}}

CON _clkmode = xtal1 + pll16x
    _xinfreq = 5_000_000

PUB main
  blink

CON
  ctrmode = %00100
  plldiv = %000
  bpin = 0
  apin = 0

PRI blink
  ctra := 0
  ctrb := 0
  dirb[0] := %1
  outb[0] := %0

  frqa := (1 << 31) / clkfreq
  phsa := 0
  ctra := (ctrmode << 26) | (plldiv << 23) | (bpin << 9) | (apin << 0)

  repeat
