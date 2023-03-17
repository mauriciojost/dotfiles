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
}

//spark.conf.set("spark.sql.files.maxPartitionBytes", 1 * 1024) // 1 KB
//spark.conf.set("spark.sql.files.maxPartitionBytes", 100 * 1024) // 0.1 MB
//spark.conf.set("spark.sql.files.maxPartitionBytes", 512 * 1024) // 0.5 MB
spark.conf.set("spark.sql.files.maxPartitionBytes", 1024 * 1024) // 1 MB
//spark.conf.set("spark.sql.files.maxPartitionBytes", 1024 * 1024 * 1024) // 1 GB (taken into account)

// val inputDf = spark.readStream.format("delta").option("maxFilesPerTrigger", "2").option("ignoreChanges", "true").load(path) // works
//val inputDf = spark.readStream.format("delta").option("maxBytesPerTrigger", "5m").option("ignoreChanges", "true").load(path) // works
val inputDf = spark.readStream.format("delta").option("maxBytesPerTrigger", "100m").option("ignoreChanges", "true").load(path) // works

inputDf.writeStream.option("checkpointLocation", checkpoint).foreachBatch(processBatch _).outputMode(OutputMode.Update).trigger(Trigger.AvailableNow()).start()

// Conclusions (with dataset of 8 files .parquet files, each roughly 2MB in size)
// maxPartitionBytes 1GB + maxFilesPerTrigger 2 => 4 batches (2 files each), 2 partitions (the maximum amount of files in the batch)
// maxPartitionBytes 1GB + maxBytesPerTrigger 5m => 3 batches (3, 4, 1 files each, with same amount of partitions each as the files)
// maxPartitionBytes 1MB + maxBytesPerTrigger 5m => 3 batches (7, 8, 3 partitions each)
// maxPartitionBytes 0.1MB + maxBytesPerTrigger 100m (1 trigger) => 1 batch with 160 partitions, but they are **NOT UNIFORM** (8 partitions filled with data, the rest empty) ???
