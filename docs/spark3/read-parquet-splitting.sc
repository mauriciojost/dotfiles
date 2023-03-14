// Arguments: --executor-memory 1G --driver-memory 1G --executor-cores 1

// Create a large partition by mismanaging shuffle partitions
spark.conf.set("spark.sql.shuffle.partitions", 1)
spark.conf.set("spark.sql.files.maxPartitionBytes", 524288) // 512 KB

val df1 = spark.read.parquet("datasets/optd_por_public_all.parquet")
df1.toJavaRDD.getNumPartitions

spark.conf.set("spark.sql.files.maxPartitionBytes", 524288 * 100) // infinite

val df2 = spark.read.parquet("datasets/optd_por_public_all.parquet")
df2.toJavaRDD.getNumPartitions
