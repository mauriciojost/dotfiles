// Arguments: --executor-memory 1G --driver-memory 1G --executor-cores 1 --master local[6]

import java.util.UUID
val path = "datasets/optd_por_public_all.avro/"
val checkpoint = "/tmp/checkpoint/" + UUID.randomUUID()


import org.apache.spark.sql._
import org.apache.spark.sql.streaming._

def processBatch(df: DataFrame, batchId: Long): Unit = {
  println(s"Batch $batchId: count ${df.count()} (partitions: ${df.toJavaRDD.getNumPartitions}, checkpoints: $checkpoint)")
  df.select("name", "country_name", "continent_name").show(1, true)
}

val schema = spark.read.format("avro").load(path).schema
val inputDf = spark.readStream.format("avro").schema(schema).option("maxFilesPerTrigger", "1").load(path)

spark.conf.set("spark.sql.files.maxPartitionBytes", 512 * 1024)

def query(p: String) = {
spark.conf.set("spark.sql.shuffle.partitions", p)
inputDf.writeStream.option("checkpointLocation", checkpoint).foreachBatch(processBatch _).outputMode(OutputMode.Update).trigger(Trigger.AvailableNow())
}

val query1 = query("10")
val q1 = query1.start()
Thread.sleep(10 * 1000)
q1.stop()


val query2 = query("333")
query2.start()
