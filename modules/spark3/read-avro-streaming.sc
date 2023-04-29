// Arguments: --executor-memory 1G --driver-memory 1G --executor-cores 1 --master local[2]

import java.util.UUID
val path = "datasets/optd_por_public_all.avro/"
val checkpoint = "/tmp/checkpoint/" + UUID.randomUUID()


import org.apache.spark.sql._
import org.apache.spark.sql.streaming._

def processBatch(df: DataFrame, batchId: Long): Unit = {
  println(s"Batch $batchId: count ${df.count()} (partitions: ${df.toJavaRDD.getNumPartitions}, checkpoints: $checkpoint)")
  df.select("name", "country_name", "continent_name").show(1, true)
}

// Which one is used?
// spark.conf.set("spark.sql.files.maxPartitionBytes", 1 * 1024) // 1 KB
spark.conf.set("spark.sql.files.maxPartitionBytes", 100 * 1024) // 100 KB 
// spark.conf.set("spark.sql.files.maxPartitionBytes", 1024 * 1024) // 1MB
// spark.conf.set("spark.sql.files.maxPartitionBytes", 10 * 1024 * 1024)
//spark.conf.set("spark.sql.files.maxPartitionBytes", 1024 * 1024 * 1024)

val schema = spark.read.format("avro").load(path).schema
val d = spark.readStream.format("avro").schema(schema)

val inputDf = d.option("maxFilesPerTrigger", "2").load(path)
//val inputDf = d.option("maxFilesPerTrigger", "50").load(path)
//val inputDf = d.option("maxFilesPerTrigger", "25").load(path)
//val inputDf = d.option("maxBytesPerTrigger", "500k").load(path) // ignored

inputDf.writeStream.option("checkpointLocation", checkpoint).foreachBatch(processBatch _).outputMode(OutputMode.Update).trigger(Trigger.AvailableNow()).start()

// Conclusions (100 files of ~ 230K each): 
// maxBytesPerTrigger is ignored with Avro
// maxFilesPerTrigger works with Avro
// spark.sql.files.maxPartitionBytes works splitting *and grouping files* (confirmed), at least as many partitions as cores, and the data is actually split among tasks (not like delta)
// *                       + maxBytesPerTrigger *  => ignored maxBytesPerTrigger
// maxPartitionBytes 100KB + maxFilesPerTrigger 2  => 
// maxPartitionBytes 1MB   + maxFilesPerTrigger 2  => 
// maxPartitionBytes 1GB   + maxFilesPerTrigger 10 =>

