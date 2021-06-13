# Transistors

From [here](https://www.instructables.com/id/BC547-Switch-Circuit/)

The transistor we are going to use has three terminals collector, emitter and base. 
Out of these the base is for controlling the input across collector and emitter. The transistor has three operating regions:

1)Saturation region (on)
2)Cut-off region (off)
3)Active region (amplifier)

http://electronicsbeliever.com/npn-transistor-principles-practical-uses/

Find below a summary of the behaviour of some transistors (BJT and mosfet) in the range of 3.3v to 5v.

## BC547

Price    : $
Package  : TO-92
Type     : BJT (bipolar junction transistor)
Sub-type : NPN
Ic       : 100ma
Hfe      : 110-800
ON / SAT characteristics
Vce sat  : 0.2-0.6v
Vbe sat  : 0.9v

## 2n5551

Price    : $
Package  : TO-92
Type     : BJT (bipolar junction transistor)
Sub-type : NPN
Ic       : 600ma
Hfe      :  80-250
ON / SAT characteristics
Vce sat  : 0.2v
Vbe sat  : 1.0v

## P2N2222A

Price    : $
Package  : TO-92
Type     : BJT (bipolar junction transistor)
Sub-type : NPN
Ic max   : 600ma
Hfe      : 40 (at Ic 500mA)
ON / SAT characteristics
Vce sat  : 1.0v (at Ic 500mA)
Vbe sat  : 2.0v (at Ic 500mA)


## TIP120

https://www.theengineeringprojects.com/2018/04/introduction-to-tip120.html

Price    : $$
Package  : TO-220 (1Ampere package)
Type     : BJT (bipolar junction transistor)
Sub-type : NPN
Ic       : 5A
Hfe      : 1000
ON / SAT characteristics
Vce sat  : 2.0-4.0v !!! (is more than 0.7v beause of Darlington)
Vbe sat  : 2.5v

## IRF3205 (my favorite)
```
  D
G    | current
  S  v
```

Price    : $ (~50 for 5e)
Package  : TO-220 (1Ampere package)
Type     : MOSFET
Sub-type : ?
Id       : 110A
ON / SAT characteristics
Vds sat  : 1mv
Vgs thres: min 2.0v

[Datasheet](https://pdf1.alldatasheet.com/datasheet-pdf/view/68131/IRF/IRF3205.html)

## IRLML6244 (my new favorite)

```
  D
G    | current
  S  v
```

Price    : $ (~100 for 5e)
Package  : SOT-23 
Type     : MOSFET
Sub-type : ?
Id       : 6.3A
ON / SAT characteristics
Vds sat  : ? (very very low)
Vgs thres: min 0.5v-1.1v

[Datasheet](https://pdf1.alldatasheet.com/datasheet-pdf/view/520588/IRF/IRLML6244.html)


