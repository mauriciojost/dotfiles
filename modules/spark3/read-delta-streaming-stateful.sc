// Arguments: --executor-memory 1G --driver-memory 1G --executor-cores 1 --master local[6]

import java.util.UUID
val path = "datasets/optd_por_public_all.delta"
val checkpoint = "/tmp/checkpoint/" + UUID.randomUUID()

import org.apache.spark.sql._
import org.apache.spark.sql.streaming._

def processBatch(df: DataFrame, batchId: Long): Unit = {
  spark.sparkContext.setJobDescription(s"Batch: $batchId")
  println(s"Batch $batchId: count ${df.count()} (partitions: ${df.toJavaRDD.getNumPartitions} checkpoints: $checkpoint)")
  df.select("name", "country_name", "continent_name").show(1, true)
  df.select("name", "continent_name").show(1, true)
}

spark.conf.set("spark.sql.files.maxPartitionBytes", 100 * 1024) // 0.1 MB

val inputDf = spark.readStream.format("delta").option("maxBytesPerTrigger", "100m").option("ignoreChanges", "true").load(path) // works

inputDf.distinct().writeStream.option("checkpointLocation", checkpoint).foreachBatch(processBatch _).outputMode(OutputMode.Update).trigger(Trigger.AvailableNow()).start()

