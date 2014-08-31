To compile the P8X32A hardware description and load it into the BeMicroCV:

1) Open Quartus II
2) File | Open Project...
3) Select 'P8X32A.qpf' file from the Altera directory (one level up from the Readme file)
4) Select the 'Revisions' tab from the Project Navigator window, and make sure the BeMicroCV revision is highlighted. If not, double-click it to select it.
5) Press the 'play' button to start compilation (takes several minutes)

6) File | Convert Programming Files
7) Click 'Open Conversion Setup Data...'
8) Select 'BeMicroCV.cof' file from the Altera directory
9) Click 'Generate'

10) Tools | Programmer
11) Connect the DE0-Nano to your PC via USB cable
12) Click 'Hardware Setup...'
13) Select 'USB-Blaster', click 'Close'
14) Set 'Mode:' to 'JTAG'
15) Click 'Delete' to clear any files or devices
16) Click 'Add File'
17) Select 'BeMicroCV.jic' file from the Altera/output_files directory
18) Check 'Program/Configure' box
19) Click 'Start' to begin programming (takes a few minutes)

20) Unplug and replug the USB cable to cycle power (loads new configuration)
21) P8X32A should now be running on BeMicroCV, indicated by a single green LED (cog0)

22) Install your Propeller Plug into the GPIO header as shown in the .PNG file in this directory

23) You can now use the regular Propeller Tool software to talk to the P8X32A being emulated in the BeMicroCV

Have fun!
