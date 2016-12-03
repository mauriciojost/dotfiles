#!/usr/bin/gnuplot

#set terminal jpeg size 1600,600
set datafile separator "\t"
file="/home/mjost/.logs/followup-cut.tsv"

set xdata time
set timefmt "%s"
set format x "%m/%d/%Y %H:%M:%S"

plot 	file using 1:2 title 'BAT0' with linespoints, \
	file using 1:3 title 'BAT1' with linespoints, \
	file using 1:4 title 'BAKL' with linespoints, \
	file using 1:5 title 'TEMP' with linespoints
pause -1
