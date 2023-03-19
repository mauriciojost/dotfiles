// Arguments: --executor-memory 1G --driver-memory 1G --executor-cores 1 --master local[6] --conf spark.sql.adaptive.enabled=false

import java.util.UUID
import org.apache.spark.sql._
val output = "/tmp/output/" + UUID.randomUUID()
spark.conf.set("spark.sql.files.maxPartitionBytes", 1000 * 1024) // 1 MB 
spark.conf.set("spark.sql.autoBroadcastJoinThreshold", "-1")

spark.sparkContext.setJobDescription("Group airports and write output")

val airports = spark.read.format("avro").load("datasets/optd_por_public_all.avro2/")
val airportsByContinent = airports.groupBy("continent_name").count()
airportsByContinent.write.parquet(output)


