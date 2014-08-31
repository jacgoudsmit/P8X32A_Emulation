To compile the P8X32A hardware description and load it into the DE2-115:

1) Open Quartus II
2) File | Open Project...
3) Select 'P8X32A.qpf' file from the Altera directory (one level up from the Readme file)
4) Select the 'Revisions' tab from the Project Navigator window, and make sure the DE2-115 revision is highlighted. If not, double-click it to select it.
5) Press the 'play' button to start compilation (takes several minutes)

6) File | Convert Programming Files
7) Click 'Open Conversion Setup Data...'
8) Select 'DE2-115.cof' file from the Altera directory
9) Click 'Generate'

10) Tools | Programmer
11) Power up the DE2-115 board
12) Connect the upper left-most USB jack to your PC
13) Slide the lower-left switch down to the 'PROG' position
14) Click 'Hardware Setup...'
15) Select 'USB-Blaster', click 'Close'
16) Set 'Mode:' to 'Active Serial Programming'
17) Click 'Delete' to clear any files or devices
18) Click 'Add File'
19) Select 'DE2-115.pof' file from the Altera/output_files directory
20) Check 'Program/Configure' box
21) Click 'Start' to begin programming (takes a few minutes)

22) Slide the lower-left switch up to the 'RUN' position
23) Press red button twice to cycle power on DE2-115 (loads new configuration)
24) P8X32A should now be running on DE2-115, indicated by a single green LED (cog0)

25) Install your Propeller Plug into the GPIO header as shown in the .PNG file
26) You can now use the regular Propeller Tool software to talk to the P8X32A being emulated in the DE2-115

Have fun!

(PS: The 60050,60055-Setup-the-Propeller-1-Design-on-a-DE2-115-v1.0.pdf file in this directory is outdated with respect to this readme file, but it contains pictures that may be helpful).
