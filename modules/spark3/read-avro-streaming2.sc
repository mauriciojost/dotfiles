// Arguments: --executor-memory 1G --driver-memory 1G --executor-cores 1 --master local[2]

import java.util.UUID
val path = "/some/large/file/"
val checkpoint = "/tmp/checkpoint/" + UUID.randomUUID()


import org.apache.spark.sql._
import org.apache.spark.sql.streaming._

def processBatch(df: DataFrame, batchId: Long): Unit = {
  println(s"Batch $batchId: count ${df.count()} (partitions: ${df.toJavaRDD.getNumPartitions}, checkpoints: $checkpoint)")
  df.show(1, false)
}

spark.conf.set("spark.sql.files.maxPartitionBytes", 100 * 1024) // 100 KB 

val schema = spark.read.format("avro").load(path).schema
val d = spark.readStream.format("avro").schema(schema)

val inputDf = d.option("maxFilesPerTrigger", "2").load(path)

inputDf.writeStream.option("checkpointLocation", checkpoint).foreachBatch(processBatch _).outputMode(OutputMode.Update).trigger(Trigger.AvailableNow()).start()

