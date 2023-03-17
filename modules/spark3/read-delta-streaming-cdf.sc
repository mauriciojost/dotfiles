// Arguments: --executor-memory 1G --driver-memory 1G --executor-cores 1

import java.util.UUID
val name = "optd_por_public_all_delta_cdfz"
val checkpoint = "/tmp/checkpoint/" + UUID.randomUUID()


import org.apache.spark.sql._
import org.apache.spark.sql.streaming._

def processBatch(df: DataFrame, batchId: Long): Unit = {
  println(s"Batch $batchId: count ${df.count()} (partitions: ${df.toJavaRDD.getNumPartitions} checkpoints: $checkpoint)")
  df.select("name", "country_name", "continent_name").show(1, true)
}

// Which one is used?
spark.conf.set("spark.sql.files.maxPartitionBytes", 1 * 1024) // 1 KB
//spark.conf.set("spark.sql.files.maxPartitionBytes", 1000000 * 1024) // 100 KB
val inputDf = spark.readStream.format("delta").option("maxBytesPerTrigger", "100000k").option("readChangeFeed", "true").option("ignoreChanges", "true").table(name)

inputDf.writeStream.option("checkpointLocation", checkpoint).foreachBatch(processBatch _).outputMode(OutputMode.Update).trigger(Trigger.AvailableNow()).start()

