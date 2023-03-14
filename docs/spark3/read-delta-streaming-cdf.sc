// Arguments: --executor-memory 1G --driver-memory 1G --executor-cores 1

import java.util.UUID
val path = "datasets/optd_por_public_all.delta.cdf"
val name = "optd_por_public_all_delta_cdfy"
val checkpoint = "/tmp/checkpoint/" + UUID.randomUUID()

// Create a large partition by mismanaging shuffle partitions
spark.conf.set("spark.sql.shuffle.partitions", 7)
spark.conf.set("spark.sql.files.maxPartitionBytes", 1 * 1024) // 1 KB

val df1 = spark.read.parquet(path)
df1.toJavaRDD.getNumPartitions

import org.apache.spark.sql._
import org.apache.spark.sql.streaming._

def processBatch(df: DataFrame, batchId: Long): Unit = {
  println(s"Batch $batchId: count ${df.count()} (checkpoints: $checkpoint)")
  df.select("name", "country_name", "continent_name").show(1, true)
}

val inputDf = spark.readStream.format("delta").option("maxBytesPerTrigger", "1k").option("readChangeFeed", "true").option("ignoreChanges", "true").table(name)

inputDf.writeStream.option("checkpointLocation", checkpoint).foreachBatch(processBatch _).outputMode(OutputMode.Update).trigger(Trigger.AvailableNow()).start()

