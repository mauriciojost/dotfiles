G92 E60             ; set the extruded length (by force) to X
G1 F200 E0          ; expel (at 100 speed) Xmm of feed stock
G4 P3000            ; wait 3s
G92 E0              ; zero the extruded length (by force) to 0
M117 READY5         ; print message
G1 F200 E60         ; extrude (at 100 speed) 90mm of feed stock
M117 READY          ; print message
