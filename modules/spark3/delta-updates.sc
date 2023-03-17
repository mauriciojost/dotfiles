// Arguments: --executor-memory 1G --driver-memory 1G --executor-cores 1
import collection.JavaConverters._
// First delta commit
io.delta.tables.DeltaTable.forPath("datasets/optd_por_public_all.delta/").toDF.repartition(2).write.partitionBy("continent_name").format("delta").save("/tmp/deltatmp")
// Second delta commit
io.delta.tables.DeltaTable.forPath("/tmp/deltatmp").delete(col("name") === "Split"))
println("Now take a look at /tmp/deltatmp where only a record from Europe has been removed in the second commit)

