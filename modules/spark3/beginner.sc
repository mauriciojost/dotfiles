// Arguments: --executor-memory 1G --driver-memory 1G --executor-cores 1 --master local[6] --conf spark.sql.adaptive.enabled=false

import java.util.UUID
val output = "/tmp/output/" + UUID.randomUUID()
import org.apache.spark.sql._
spark.conf.set("spark.sql.files.maxPartitionBytes", 1000 * 1024) // 1 MB 
spark.conf.set("spark.sql.autoBroadcastJoinThreshold", "-1")

spark.sparkContext.setJobDescription("Read continents.csv")
val cont = spark.read.option("delimiter",",").option("header","true").csv("datasets/continents.csv")

spark.sparkContext.setJobDescription("Read por.avro")
val por = spark.read.format("avro").load("datasets/optd_por_public_all.avro2/")

spark.sparkContext.setJobDescription("Display counts and id")
val dfByContinent = por.groupBy("continent_name").count().join(cont, "continent_name")
dfByContinent.write.parquet(output)


