// Arguments: --executor-memory 1G --driver-memory 1G --executor-cores 1 --master local[6]

import java.util.UUID
val path = "datasets/optd_por_public_all.delta"
val checkpoint = "/tmp/checkpoint/" + UUID.randomUUID()

import org.apache.spark.sql._
import org.apache.spark.sql.streaming._

def processBatch1(df: DataFrame, batchId: Long): Unit = {
  spark.sparkContext.setJobDescription(s"Batch: $batchId")
  println(s"Batch $batchId: count ${df.count()} (partitions: ${df.toJavaRDD.getNumPartitions} checkpoints: $checkpoint)")
  df.select("name", "country_name", "continent_name").show(1, true)
  df.select("name", "continent_name").show(1, true)
}

def processBatch2(df: DataFrame, batchId: Long): Unit = {
  spark.sparkContext.setJobDescription(s"Batch: $batchId")
  println(s"Batch $batchId: count ${df.count()} (partitions: ${df.toJavaRDD.getNumPartitions} checkpoints: $checkpoint)")
  df.select("name", "country_name", "continent_name").show(1, true)
  df.select("name", "continent_name").show(1, true)
}

spark.conf.set("spark.sql.files.maxPartitionBytes", 100 * 1024) // 0.1 MB

val inputDf = spark.readStream.format("delta").option("maxBytesPerTrigger", "10k").option("ignoreChanges", "true").load(path) // works

inputDf.writeStream.option("checkpointLocation", checkpoint + "1").queryName("queryX").foreachBatch(processBatch1 _).outputMode(OutputMode.Update).trigger(Trigger.AvailableNow()).start()

inputDf.writeStream.option("checkpointLocation", checkpoint + "2").queryName("queryX").foreachBatch(processBatch2 _).outputMode(OutputMode.Update).trigger(Trigger.AvailableNow()).start()

