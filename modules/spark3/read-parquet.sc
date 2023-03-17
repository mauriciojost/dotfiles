// Arguments: --executor-memory 1G --driver-memory 1G --executor-cores 1 --master local[6]

import java.util.UUID
val path = "datasets/optd_por_public_all.parquet"
val output = "/tmp/output/" + UUID.randomUUID()

import org.apache.spark.sql._

//spark.conf.set("spark.sql.files.maxPartitionBytes", 1 * 1024) // 1 KB
spark.conf.set("spark.sql.files.maxPartitionBytes", 100 * 1024) // 0.1 MB
//spark.conf.set("spark.sql.files.maxPartitionBytes", 512 * 1024) // 0.5 MB
// spark.conf.set("spark.sql.files.maxPartitionBytes", 1024 * 1024) // 1 MB
//spark.conf.set("spark.sql.files.maxPartitionBytes", 1024 * 1024 * 1024) // 1 GB (taken into account)

val inputDf = spark.read.format("parquet").load(path)

inputDf.write.parquet(output)


