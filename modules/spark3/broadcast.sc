// Arguments: --executor-memory 1G --driver-memory 1G --executor-cores 1
sc.setJobDescription("Broadcaster")

val r = new java.util.Random()
val c = (0 to 1000000).map(_ => r.nextLong().toString).toSeq
sc.parallelize(Seq(1)).map(_ => c.length).collect()
