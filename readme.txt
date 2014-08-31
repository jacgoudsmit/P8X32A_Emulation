P8X32A Emulation
================


The following targets are currently supported by the maintainers of the
Github repository.
- Arrow BeMicro CV      (Altera Cyclone V;  see P8X32A_BeMicroCV/)
- Terasic DE0-Nano      (Altera Cyclone IV; see P8X32A_DE0_Nano/)
- Terasic DE2-115       (Altera Cyclone IV; see P8X32A_DE2_115/)
- Saanlima Pipistrello  (Xilinx Spartan-6;  see P8X32A_Pipistrello/)


Altera Targets
--------------
The Altera-based targets were originally release by Parallax as separate
directories with almost identical source files, but they were combined into
one Quartus-II project file (P8X32A.qpf in the Altera directory). Setting up
for a different Altera board is now as simple as switching the current
revision in the Revisions tab of the project navigator.

Note, even though the source files are now combined, the documentation
files are still in the original directories. Please see the readme files
in each directory for more information.


Pipistrello Target
------------------
(To be added here)


Additional Files
----------------
The ROM_Sources directory contains the original .src files which contain
the program code that exists in the P8X32A's ROM. You must rename them to
.spin files and put a 'PUB anyname' at their top before compiling them in
the Propeller Tool. They are not directly executable, but are provided to
show you what went into the ROM:

interpreter.src     begins at $F004
booter.src          begins at $F800
runner.src          butts up against $FFFF


Github Maintainers
------------------
The easiest way to make your own modifications to the source code is to use
Github, and use the Github tool to create a fork on your computer, then
create a Pull Request to get your change integrated (if you want, of course!
You're free to keep all your changes to yourself too). There are just a few
simple requirements that your code has to adhere to:

1. Source files should have NO TABS.

If you generated tabs in a source file, please use an editor like Notepad++
to properly replace the tabs by spaces (Quartus 14.0 has a menu option to do
it but it messes up the indentations). In Quartus, with a document open,
click Tools -> Options -> Text Editor, and set the tab size to 4 spaces, and
enable the "Insert spaces on Tab" option. You may also want to enable the
Show white space option, but that's a matter of taste.

2. By default, all targets must produce a standard Propeller.

As a rule, when someone downloads a "master branch" from any of the Github
repositories that are listed below, and builds any of the supported targets,
the result should be as close to the original Propeller P8X32A chip as
possible, from the viewpoint of the code that runs on the FPGA and on the
attached computer, as well as from the viewpoint of any attached devices.

Exception: the virtual Propeller may run slower or faster than the P8X32A
chip, and if the hardware doesn't support a full emulation, a partial 
emulation is acceptable. For example: the DE0-Nano doesn't have enough RAM
on board to do a full emulation, so it doesn't have the character generator
on board: it's disabled by a macro.

3. If possible, a single parameter override (preferred) or a single macro
should be enough to activate a feature.

In Quartus: Tools -> Settings -> Analysis & Synthesis Settings -> Default
Parameters can be used to override parameter definitions in Verilog and
AHDL. Because parameters are clearly declared in the source file, they are
the preferred method of implementing special features. For example, to
implement a feature to change the number of cogs, you can add a parameter
with a default value of 8, and you replace all values in all source files
that are related to the number of available cogs by an expression that uses
the parameter. Then whenever someone wants to change the numebr of cogs,
they can simply add the parameter to the settings menu, and recompile the
target.

Also in Quartus, you can use the Tools -> Settings -> Analysis & Synthesis
Settings -> Verilog HDL Input) to add a preprocessor macro that works the
same as a `define in the code. The DE0-Nano uses this to comment out the
line that maps the character generator into the hub, so the design fits
in the FPGA.


Here is a list of maintainers and the URLs of their repos.
- Heater:
  See https://github.com/ZiCog/P8X32A_Emulation
  * Created the repository from Chip Gracey's original source release.
- Rick Post (Mindrobots):
  See https://github.com/mindrobots/P8X32A_Emulation
  * Added BeMicroCV target
  * Maintenance
- Jac Goudsmit:
  https://github.com/jacgoudsmit/P8X32A_Emulation
  * Maintenance,
  * Combined the Altera targets
- Magnus Karlsson:
  https://github.com/magnuskarlsson/P8X32A_Emulation
  * Added Pipistrello target
