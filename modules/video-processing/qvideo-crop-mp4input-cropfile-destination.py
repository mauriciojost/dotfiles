#!/usr/bin/python
# Usage:
#   python update-config-js.py srcfile cropfile dstdir 

import os
import sys
import glob
import json
import shutil
import random
import subprocess
from os.path import basename

srcfile = sys.argv[1]
cropfile = sys.argv[2]
dstdir = sys.argv[3]

print "Source file  : " + srcfile
print "Crop file  : " + cropfile
print "Destination directory: " + dstdir

cf = open(cropfile, "r")

devnull = open('/dev/null', 'w')

processes = []

for line in cf:
    words = line.split();
    if len(words) > 0 :
        sm = words[0]
        ss = words[1]
        fm = words[2]
        fs = words[3]
        begin = sm + ":" + ss 
        to = fm + ":" + fs
        rnd1 = random.randrange(0,100000)
        rnd2 = random.randrange(0,100000)
        dstfile = dstdir + "/" + "qvideo" + str(rnd1) + "-" + str(rnd2) + ".mp4"

        print "Cropping: " + srcfile + " from "  + begin + " to " + to + " and writting to " + dstfile
        p = subprocess.Popen(["ffmpeg", "-i", srcfile, "-vf", "scale=iw:ih" , "-acodec", "mp2", "-ss", begin, "-to", to, dstfile], stdout=devnull, stderr=devnull)
        processes.append(p)


for proc in processes:
    errcode = proc.wait()
    if errcode != 0 :
        print "Something went wrong with one of the processes."


devnull.close()
cf.close()

print "Done."

