#!/usr/bin/env python

from math import log, trunc

from math import ceil, log

def log2(val):
    return ceil(log(val, 2))

"""
        RAMBASE  = $0000                        ' RAM               $0000..7FFF  
        ROMBASE  = $8000                        ' ROM               $8000..FFFF
        RAMSIZE  = 8192 'longs                  ' RAM:              $0000..7FFF                       
        FONTSIZE = 4096 'longs                  ' ROM: FONT         $8000..BFFF                       
        LOGSIZE  = 1024 'longs                  ' ROM: LOG          $C000..CFFF 2048 words            
        ALOGSIZE = 1024 'longs                  ' ROM: ANTILOG      $D000..DFFF 2048 words            
        SINESIZE = 1025 'longs                  ' ROM: SINE         $E000..F002 2049 words + 1 filler 
        INTERPSZ =                              ' ROM: Interpreter  $F004..F7A3  488 longs  (scrambled)           
        BOOTERSZ =                              ' ROM: Booter       $F800..FB93  229 longs  (scrambled)           
        RUNNERSZ =                              ' ROM: Runner       $FF70..FFFF   36 longs      
"""

memoryBuffer = []

def installFont(addr):
	print "Install Font."
	
def installLogTable(addr):
	print "Install Logarithmic Table."
	for i in range(0, 0x7FF):
		f = round(log2(1 + i / 0x800) * 0x10000)
		s = trunc(f)
		print s

"""
def installAntilogTable(addr):

def installSinTable(addr):

def installInterpreter(addr):

def installBooter(addr):

def installRunner():
"""

installLogTable(42)


