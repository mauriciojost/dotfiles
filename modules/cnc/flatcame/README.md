# README

Your CNC machine is a TopDirect CNC Router: https://www.amazon.de/-/en/Topdirect-Machine-Engraving-Acrylic-Engraver/dp/B01N6II80U
Version of GRBL = 0.9j
7000 RPM max

## GCODES

GCODES can be found here: http://www.linuxcnc.org/docs/2.4/html/gcode.html
Some GCODES:

```
G94 (Units per Minute Mode)
G21 (to use millimeters for lenght units)
G17 (use plane XY)
F40 (set rate to 40 mm per minute)
S100 (set spindle speed to 100, 1000 being the max 7000RPM in our router)
M3 (start spindle)
M5 (stop spindle)
G4 P3 (wait 3 seconds)
G0 X1 Y100 (rapid move to 1,100)
G1 X1 Y100 (rated move to 1,100)

```

Most used: 

```
G21 (to use millimeters for lenght units)
G17 (use plane XY)

F40 (set rate to 40 mm per minute)
G0 X1 Y100 (rapid move to 1,100)
G1 X1 Y100 (rated move to 1,100)

```
