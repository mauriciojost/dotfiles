// Arguments: --driver-memory 2G --driver-cores 4
sc.setJobDescription("dataset2-gen.sc: read")
val df = spark.read.option("delimiter","^").option("header","true").csv("datasets/optd_por_public_all.csv")
//sc.setJobDescription("dataset2-gen.sc: write delta")
//df.write.format("delta").save("datasets/optd_por_public_all.delta")
//sc.setJobDescription("dataset2-gen.sc: write parquet")
//df.write.format("parquet").save("datasets/optd_por_public_all.parquet")
//sc.setJobDescription("dataset2-gen.sc: write parquet partitioned")
//df.withColumn("part", substring(col("geoname_id"), 1,3)).write.format("parquet").partitionBy("part").save("datasets/optd_por_public_all.parquetpartitioned")
//sc.setJobDescription("dataset2-gen.sc: write parquet partitioned2")
//df.withColumn("part", col("geoname_id")).write.format("parquet").partitionBy("part").save("datasets/optd_por_public_all.parquetpartitioned2")
//sc.setJobDescription("dataset2-gen.sc: write delta (with cdf)")
//df.repartition(100).write.format("delta").option("delta.enableChangeDataFeed", "true").save("datasets/optd_por_public_all.delta.cdf1")
import org.apache.spark.sql.types._
import io.delta.tables._
DeltaTable.create(spark).tableName("optd_por_public_all_delta_cdfy").addColumns(df.schema).location("datasets/optd_por_public_all.delta.cdfy").property("delta.enableChangeDataFeed", "true").execute()
DeltaTable.forName("optd_por_public_all_delta_cdfy").as("tgt").merge(df.as("src"), "src.name = tgt.name").whenNotMatched.insertAll.execute()
