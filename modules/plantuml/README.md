# README

First install `Graphviz`

```
$ sudo apt-get install graphviz plantuml
```

```
plantuml -help
plantuml -testdot
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
plantuml -tpng README.md
```

