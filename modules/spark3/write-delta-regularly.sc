// Arguments: --executor-memory 1G --driver-memory 1G --executor-cores 1 --master local[2]

import java.util.UUID
import io.delta.tables.DeltaTable

val inputDir = "datasets/optd_por_public_all.delta.cdf1000"
val tmpPath = "/tmp/tmpPath/" + UUID.randomUUID()
val outputDir = tmpPath + "/output"
val checkpointDir = tmpPath + "/checkpoint"

import org.apache.spark.sql._
import org.apache.spark.sql.functions._
import org.apache.spark.sql.streaming._
import sys.process._

spark.conf.set("spark.sql.shuffle.partitions", "10")
spark.conf.set("spark.databricks.delta.retentionDurationCheck.enabled", "false")
spark.conf.set("spark.databricks.delta.retentionDurationCheck.enabled", "false")

s"rm -fr tmpdir" !
s"ln -s ${tmpPath} tmpdir" !

println(s"""io.delta.tables.DeltaTable.forPath("tmpdir/data").toDF.selectExpr("count(*)").show(10)""")

spark.read.format("delta").load(inputDir).where(col("country_name") === "None").write.format("delta").save(outputDir)
DeltaTable.forPath(outputDir).toDF.createOrReplaceTempView("output")
spark.sql("ALTER TABLE output SET TBLPROPERTIES ('delta.enableDeletionVectors' = true);")


def processBatch(batch: DataFrame, batchId: Long): Unit = {
  //spark.sparkContext.setJobGroup(s"Batch: $batchId", "Display stats")
  //batch.selectExpr("max(iata_code)", "min(iata_code)", "count(*)").show(1)
  println(s"Batch merge $batchId: tmpPath $tmpPath)")
  spark.sparkContext.setJobGroup(s"Batch: $batchId", "Merge")
  DeltaTable
    .forPath(outputDir)
    .as("output")
    .merge(
      batch.as("batch"), 
      "batch.iata_code == output.iata_code and batch.geoname_id == output.geoname_id"
    )
    .whenMatched.updateAll
    .whenNotMatched.insertAll
    .execute()
  spark.sparkContext.setJobGroup(s"Batch: $batchId", "Display stats")
  DeltaTable.forPath(outputDir).detail().show(10, false)
  DeltaTable.forPath(outputDir).history(1).show(10, false)
  if (batchId % 10 == 0) {
    println(s"Optimize $batchId")
    spark.sparkContext.setJobGroup(s"Batch: $batchId", "Optimize output")
    DeltaTable.forPath(outputDir).optimize().executeZOrderBy("iata_code", "geoname_id").show(10, false)
  }
  if (batchId % 100 == 0) {
    println(s"Vacuum $batchId")
    spark.sparkContext.setJobGroup(s"Batch: $batchId", "Vacuum output")
    DeltaTable.forPath(outputDir).vacuum(0.01)
  }
}

spark
  .readStream
  .format("delta")
  .option("maxBytesPerTrigger", "1k")
  .option("ignoreChanges", "true")
  .load(inputDir) 
  .writeStream
  .option("checkpointLocation", checkpointDir)
  .foreachBatch(processBatch _)
  .outputMode(OutputMode.Update)
  .trigger(Trigger.AvailableNow())
  .start()

