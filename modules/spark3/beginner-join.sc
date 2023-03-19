// Arguments: --executor-memory 1G --driver-memory 1G --executor-cores 1 --master local[6] --conf spark.sql.adaptive.enabled=false

import java.util.UUID
import org.apache.spark.sql._
val output = "/tmp/output/" + UUID.randomUUID()
spark.conf.set("spark.sql.files.maxPartitionBytes", 1000 * 1024) // 1 MB 
spark.conf.set("spark.sql.autoBroadcastJoinThreshold", "-1")

spark.sparkContext.setJobDescription("Read continents.csv")
val continentsInSpanish = spark.read.option("delimiter",",").option("header","true").csv("datasets/continents.csv")

spark.sparkContext.setJobDescription("Count, join and write")
val airports = spark.read.format("avro").load("datasets/optd_por_public_all.avro2/")
val airportsByContinent = airports.groupBy("continent_name").count().join(continentsInSpanish, "continent_name")
airportsByContinent.write.parquet(output)


