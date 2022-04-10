#! /bin/bash  
# Setup HUION WH1409, after bridged to wacom driver with Digimend Kernel module.  
# License: CC-0/Public-Domain license  
# author: deevad  

# Tablet definition  
tabletstylus="HID 256c:006e stylus"  
tabletpad="HID 256c:006e Pad pad"  
tabletpen="HID 256c:006e Touch Strip pad"
screen="eDP-1"
# Mapping  
# get maximum size geometry with:  
# xsetwacom --get "$tabletstylus" Area  
# 0 0 55200 34500  
tabletX=55200  
tabletY=34500  
# screen size:  
screenX=1920  
screenY=1080  

# Reset  
xsetwacom --set "$tabletstylus" ResetArea  
xsetwacom --set "$tabletstylus" RawSample 4  

# map to good screen (dual nvidia)  
xsetwacom --set "$tabletstylus" MapToOutput "$screen"  
# setup ratio :  
newtabletY=$(( $screenY * $tabletX / $screenX ))  
xsetwacom --set "$tabletstylus" Area 0 0 "$tabletX" "$newtabletY"  


# Buttons  
# =======  
xsetwacom --set "$tabletstylus" Button 2 2   
xsetwacom --set "$tabletstylus" Button 3 3  
# ---------  
# | 1 | 2 |  
# |---|---|  
# | 3 | 8 |  
# |=======|  
# | 9 |10 |  
# |---|---|  
# |11 |12 |  
# |=======|  
# |13 | ? |  
# |---|---|  
# | ? | ? |  
# |=======|  
xsetwacom --set "$tabletpad" Button 1 "key Control_L" # color picker on ring  
xsetwacom --set "$tabletpad" Button 2 "key Shift_L" # resize brush  
xsetwacom --set "$tabletpad" Button 3 "key KP_Divide" # switch /  
xsetwacom --set "$tabletpad" Button 8 "key e" # eraser  
xsetwacom --set "$tabletpad" Button 9 "key z"  # undo  
xsetwacom --set "$tabletpad" Button 10 "key y"  
xsetwacom --set "$tabletpad" Button 11 "key tab"  
xsetwacom --set "$tabletpad" Button 12 "key r"  
xsetwacom --set "$tabletpad" Button 13 "key m"  


# Xinput option  
# =============  
# for the list:  
# xinput --list  

xinput list-props "$tabletpen"
xinput set-prop "$tabletpen" "Evdev Middle Button Emulation" 0  
# alternate way to map to a single screen  
# execute "xrander" in a terminal to get the screen name ( DVI-D-0 in this example )  
# xinput set-prop 'TABLET Pen Tablet Pen stylus' DVI-D-0
