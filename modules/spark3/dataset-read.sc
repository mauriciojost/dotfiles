sc.setJobDescription("dataset2-read.sc: read csv with header")
val df1 = spark.read.option("delimiter","^").option("header","true").csv("datasets/optd_por_public_all.csv")
df1.explain
df1.write.format("noop").mode("overwrite").save()

sc.setJobDescription("dataset2-read.sc: read delta")
val df2 = spark.read.format("delta").load("datasets/optd_por_public_all.delta")
df2.explain
df2.write.format("noop").mode("overwrite").save()

sc.setJobDescription("dataset2-read.sc: read parquet")
val df3 = spark.read.format("parquet").load("datasets/optd_por_public_all.parquet")
df3.explain
df3.write.format("noop").mode("overwrite").save()

sc.setJobDescription("dataset2-read.sc: read parquet partitioned")
val df4 = spark.read.format("parquet").load("datasets/optd_por_public_all.parquetpartitioned")
df4.explain
df4.write.format("noop").mode("overwrite").save()

sc.setJobDescription("dataset2-read.sc: read parquet partitioned2")
val df5 = spark.read.format("parquet").load("datasets/optd_por_public_all.parquetpartitioned2")
df5.explain
df5.write.format("noop").mode("overwrite").save()
