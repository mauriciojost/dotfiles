// Arguments: --executor-memory 1G --driver-memory 1G --executor-cores 1 --master local[6]

import java.util.UUID
val path = "datasets/optd_por_public_all.avro2/"
val checkpoint = "/tmp/checkpoint/" + UUID.randomUUID()


import org.apache.spark.sql._
import org.apache.spark.sql.streaming._

def processBatch(df: DataFrame, batchId: Long): Unit = {
  println(s"Batch $batchId: count ${df.count()} (partitions: ${df.toJavaRDD.getNumPartitions}, checkpoints: $checkpoint)")
  df.select("name", "country_name", "continent_name").show(1, true)
}

// Which one is used?
// spark.conf.set("spark.sql.files.maxPartitionBytes", 1 * 1024) // 1 KB // TAKEN INTO ACCOUNT (23411 tasks)
//spark.conf.set("spark.sql.files.maxPartitionBytes", 10 * 1024) // 10 KB 
// spark.conf.set("spark.sql.files.maxPartitionBytes", 1024 * 1024) // 1MB // TAKEN INTO ACCOUNT (100 tasks, at most a whole file, no grouping YET of files into same partition)
// spark.conf.set("spark.sql.files.maxPartitionBytes", 10 * 1024 * 1024) // 10MB // TAKEN INTO ACCOUNT (34 tasks, grouping of files into same partition)
spark.conf.set("spark.sql.files.maxPartitionBytes", 1024 * 1024 * 1024) // 1GB (6 tasks, as many as executors)

val schema = spark.read.format("avro").load(path).schema
val inputDf = spark.readStream.format("avro").schema(schema).option("maxFilesPerTrigger", "100").load(path) // works, 1 batch
//val inputDf = spark.readStream.format("avro").schema(schema).option("maxFilesPerTrigger", "50").load(path) // works, 2 batches
//val inputDf = spark.readStream.format("avro").schema(schema).option("maxFilesPerTrigger", "25").load(path) // works, 4 batches
//val inputDf = spark.readStream.format("avro").schema(schema).option("maxBytesPerTrigger", "500k").load(path) // ignored
//val inputDf = spark.readStream.format("avro").schema(schema).option("maxBytesPerTrigger", "500k").load(path) // ignored
inputDf.writeStream.option("checkpointLocation", checkpoint).foreachBatch(processBatch _).outputMode(OutputMode.Update).trigger(Trigger.AvailableNow()).start()

// Conclusions (100 files of max 200K each): 
// maxBytesPerTrigger is ignored with Avro
// maxFilesPerTrigger works with Avro
// spark.sql.files.maxPartitionBytes works splitting and grouping files, at least as many partitions as cores, and the data is actually split among tasks (not like delta)

