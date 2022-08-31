; OPEN CURA AND GO TO MONITOR, ENTER THE COMMANDS ONE BY ONE IN SEND G-CODE BLOCK

; PREPARE FOR TEST
G21 ; set metric values
G90 ; use absolute positioning
M82 ; set extruder to absolute mode
M107; start with the fan off

; set temperatures
M140 S80  ; heat bed to 80
M109 S210 ; heat end to 210 (and wait)
M190 S80  ; heat bed to 80 (and wait)

; ITERATE HERE
G28         ; auto home
G1 Z0 F1200 ; descend to position Z=0
; Nozzle should be in a "sheet" position (far enough a sheet of paper can roughly pass through)
; if noozle too high/far from the bed: substract a positive value to the offset (Configuration -> Probe Z Offset)
; if noozle too close to the bed: add to the offset a positive value (Configuration -> Probe Z Offset)

; IF ALL IS GOOD, PROCEED TO NEXT TEST, ACTUALLY PRINTING

G28 ; auto home
G29 ; bed leveling

G1 X20 Y20 F2400 ; move to at speed of mm/min
G1 Z0 F1200      ; move to the Z=0 position on the bed at a speed of X mm/min
;G91             ; relative positioning
G1 X30 E10 F1800 ; push 10mm of filament into the nozzle while moving to the X=30 position at the same time

When OK, save (Configuration -> Store Settings)
