// Arguments: --executor-memory 1G --driver-memory 1G --executor-cores 1 --master local[6]

import java.util.UUID
import io.delta.tables.DeltaTable

val path = "datasets/optd_por_public_all.delta.cdf"
val tmpPath = "/tmp/tmpPath/" + UUID.randomUUID()
val output = tmpPath + "/data"
val checkpoint = tmpPath + "/checkpoint"

import org.apache.spark.sql._
import org.apache.spark.sql.functions._
import org.apache.spark.sql.streaming._

spark.conf.set("spark.sql.files.maxPartitionBytes", 10000 * 1024)

def processBatch(df: DataFrame, batchId: Long): Unit = {
  spark.sparkContext.setJobDescription(s"Batch: $batchId")
  println(s"Batch $batchId: tmpPath $tmpPath)")
  DeltaTable.forPath(output).update(col("country_name") === "Argentina", Map("continent_name" -> lit(s"$batchId")))
}

spark.read.format("delta").load(path).write.format("delta").save(output)

// read from output, write to output
val inputDf = spark.readStream.format("delta").option("maxBytesPerTrigger", "5000k").option("ignoreChanges", "true").load(output)
inputDf.writeStream.option("checkpointLocation", checkpoint).foreachBatch(processBatch _).outputMode(OutputMode.Update).trigger(Trigger.AvailableNow()).start().awaitTermination()

// Display in another shell with: 
//   DeltaTable.forPath("/tmp/tmpPath/9f23d0af-f9c3-466f-b58e-7e3c1ea84a2a/data").toDF.select("country_name","continent_name").filter(col("country_name") === "Argentina").show(10)
