G21                 ; metric values
M82                 ; set extruder to absolute mode
;G28                 ; auto home
;G1 Z+40 X0 Y0 F9000 ; put endpoint somewhere nice
M117 TEMP           ; print message
M109 T0 R210        ; set temperature of T0 to 210C
M300 P20            ; beep ms
G4 P40              ; wait ms
M300 P20            ; beep ms
G4 P40              ; wait ms
M300 P20            ; beep ms
