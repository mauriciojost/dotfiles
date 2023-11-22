// Arguments: --executor-memory 1G --driver-memory 1G --executor-cores 1 --master local[6]

import io.delta.tables.DeltaTable

import java.util.UUID
val output = "/tmp/output/" + UUID.randomUUID()

val df = spark.range(0, 5)
df.repartition(5).write.format("delta").save(output)
val dt = DeltaTable.forPath(spark, output)
dt.optimize().executeCompaction()

spark.conf.set("spark.databricks.delta.retentionDurationCheck.enabled", "false")
dt.vacuum(0)
