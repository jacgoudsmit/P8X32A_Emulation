To compile the P8X32A hardware description and load it into the DE0-Nano:

1) Open Quartus II
2) File | Open Project...
3) Select 'P8X32A.qpf' file from the Altera directory (one level up from the Readme file)
4) Select the 'Revisions' tab from the Project Navigator window, and make sure the DE0-Nano revision is highlighted. If not, double-click it to select it.
5) Press the 'play' button to start compilation (takes several minutes)

6) File | Convert Programming Files
7) Click 'Open Conversion Setup Data...'
8) Select 'DE0-Nano.cof' file from the Altera directory
9) Click 'Generate'

10) Tools | Programmer
11) Connect the DE0-Nano to your PC via USB cable
12) Click 'Hardware Setup...'
13) Select 'USB-Blaster', click 'Close'
14) Set 'Mode:' to 'JTAG'
15) Click 'Delete' to clear any files or devices
16) Click 'Add File'
17) Select 'DE0-Nano.jic' file from the Altera/output_files directory
18) Check 'Program/Configure' box
19) Click 'Start' to begin programming (takes a few minutes)

20) Unplug and replug the USB cable to cycle power (loads new configuration)
21) P8X32A should now be running on DE0-Nano, indicated by a single green LED (cog0)

22) Install your Propeller Plug into the GPIO header as shown in the .PNG file in this directory

23) You can now use the regular Propeller Tool software to talk to the P8X32A being emulated in the DE0-Nano

Note: In order for the P8X32A design to fit into the DE0-Nano, the character ROM ($8000..$BFFF)
was excluded by an `ifndef in hub_mem.v. The upper ROM ($C000..$FFFF) now appears
twice at $8000 and $C000.

Have fun!

(PS: The 60056-Setup-the-Propeller-1-Design-on-a-DE0-Nano-v1.0_0.pdf file in this directory is outdated with respect to this readme file, but it contains pictures that may be helpful).
