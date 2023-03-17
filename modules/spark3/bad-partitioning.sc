import collection.JavaConverters._
val df = spark.read.option("delimiter","^").option("header","true").csv("datasets/optd_por_public_all.csv")
df.select("name", "continent_name").show(10)
df.repartition(col("continent_name")).toJavaRDD.foreachPartition(i => println(i.asScala.size))
df.repartition(col("name")).toJavaRDD.foreachPartition(i => println(i.asScala.size))
df.select("continent_name").repartition(100, col("continent_name")).toJavaRDD.foreachPartition(i => println(i.asScala.toSet))
