# README

First install `Graphviz`

```
$ sudo apt-get install graphviz
```

Then download plantuml.jar from [here](http://plantuml.sourceforge.net/download.html). Store it in this directory.

```
$ java -jar plantuml.jar -testdot
```

Should see something like 

```
Installation seems OK. File generation OK
```

A valid example of a diagram: 
```
@startuml
Bob->Alice : hello
@enduml
```

To create a `.png` image from this file, execute: 

```
qplantuml -tpng README.md
```

