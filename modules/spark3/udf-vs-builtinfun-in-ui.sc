// Arguments: --executor-memory 1G --driver-memory 1G --executor-cores 1 --master local[6] --conf spark.sql.adaptive.enabled=false

import java.util.UUID
import org.apache.spark.sql._
val output = "/tmp/output/" + UUID.randomUUID()
spark.conf.set("spark.sql.files.maxPartitionBytes", 1000 * 1024) // 1 MB 
spark.conf.set("spark.sql.autoBroadcastJoinThreshold", "-1")

val airports = spark.read.format("avro").load("datasets/optd_por_public_all.avro2/").select("name")

spark.sparkContext.setJobDescription("Airports with builtin function")
val airportsBuiltin = airports.withColumn("nameSubstring", substring($"name", 0, 2)).withColumn("nameUpper", upper($"nameSubstring"))
airportsBuiltin.write.parquet(output + ".builtin")
                                                                                
spark.sparkContext.setJobDescription("Airports with UDF function")
def substrFun(i: String): String = i.substring(0, 2)
spark.udf.register("substrUdf", substrFun _)
val airportsUdf = airports.withColumn("nameSubstring", expr("substrUdf(name)")).withColumn("nameUpper", upper($"nameSubstring"))
airportsUdf.write.parquet(output + ".udf")
              
