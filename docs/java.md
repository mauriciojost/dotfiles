 # JAVA
  
## JVM Memory analysis (local)

Put in `Main.scala` the following:

```

package com.amadeus.ti

import java.util.UUID.randomUUID

object Main {

  case class Myuids(ui: String)

  def main(args: Array[String]): Unit = {

    val u = (1 to args(0).toInt).map(_ => Myuids(randomUUID().toString))

    java.lang.Thread.sleep(3600 * 1000)

    u.foreach(println)

  }

}

```

Then launch:

```
scalac Main.scala
scala com.amadeus.ti.Main 1500000

```


Then do:

0. Download the standalone Eclipse Memory Analyser (EMA, or `mat` as they call it).
1. Open `mat`
2. If you don't already have the memory dump (with

```
jmap -dump:format=b,file=heap.hprof <pid>
```

) you can acquire it from `mat` itself (or target the file .hprof you already have).
3. Choose the component report
4. Point to the right package you're monitoring (in a regex), for instance `com\.peperoni\..*`
5. Now you must see a pie chart.
6. Click on Top Consumers, see their size in MB.

You can (apparently) also open it with `jhat`.

That is all.


## JVM Memory analysis (remote)

1. Add the following settings to your JVM:

```
-XX:+PrintGCDetails -XX:+PrintGCTimeStamps -XX:+StartAttachListener -XX:+UnlockCommercialFeatures -XX:+FlightRecorder -XX:FlightRecorderOptio  ns=defaultrecording=true,dumponexit=true,dumponexitpath=/tmp/jfr/,repository=/tmp/jfr/,disk=true -XX:+HeapDumpOnOutOfMemoryError -XX:HeapDump  Path=/tmp/heap.dump/"

```
2. This will create upon OOM
 - A report under `/tmp/jfr/hotspot-pid-32537-id-0-2019_06_07_10_08_40.jfr` (which did not have memory heap exhaustive information)
 - A heap dump under `/tmp/heap.dump/java_pid15538.hprof`
3. To open the .jfr, open Java Mission Control (tool from jdk: jmc)
4. To open the .hprof heap dump, you can use `jhat` or `jvisualvm`.



