// Arguments: --driver-memory 2G --driver-cores 4

// First download optd_por_public_all.csv as described in the README.md

sc.setJobDescription("dataset-gen.sc: read")
val df = spark.read.option("delimiter","^").option("header","true").csv("datasets/optd_por_public_all.csv")

sc.setJobDescription("dataset-gen.sc: write delta")
df.write.format("delta").save("datasets/optd_por_public_all.delta")

sc.setJobDescription("dataset-gen.sc: write parquet")
df.write.format("parquet").save("datasets/optd_por_public_all.parquet")

sc.setJobDescription("dataset-gen.sc: write parquet partitioned")
df.withColumn("part", substring(col("geoname_id"), 1,3)).write.format("parquet").partitionBy("part").save("datasets/optd_por_public_all.parquetpartitioned")

sc.setJobDescription("dataset-gen.sc: write parquet partitioned2")
df.withColumn("part", col("geoname_id")).write.format("parquet").partitionBy("part").save("datasets/optd_por_public_all.parquetpartitioned2")

sc.setJobDescription("dataset-gen.sc: write delta (with cdf)")
df.repartition(100).write.format("delta").option("delta.enableChangeDataFeed", "true").save("datasets/optd_por_public_all.delta.cdf1")

sc.setJobDescription("dataset-gen.sc: write delta (with cdf 100)")
df.repartition(100).write.format("delta").option("delta.enableChangeDataFeed", "true").save("datasets/optd_por_public_all.delta.cdf")

sc.setJobDescription("dataset-gen.sc: write delta (with cdf 1000)")
df.repartition(1000).write.format("delta").option("delta.enableChangeDataFeed", "true").save("datasets/optd_por_public_all.delta.cdf1000")

sc.setJobDescription("dataset-gen.sc: write delta (with cdf Z)")
import org.apache.spark.sql.types._
import io.delta.tables._
DeltaTable.create(spark).tableName("optd_por_public_all_delta_cdfz").addColumns(df.schema).location(System.getProperty("user.dir") + "/datasets/optd_por_public_all.delta.cdfz").property("delta.enableChangeDataFeed", "true").execute()
DeltaTable.forName("optd_por_public_all_delta_cdfz").as("tgt").merge(df.as("src"), "src.name = tgt.name").whenNotMatched.insertAll.execute()

sc.setJobDescription("dataset-gen.sc: write avro")
df.repartition(100).write.format("avro").save("datasets/optd_por_public_all.avro")

sc.setJobDescription("dataset-gen.sc: write avro2")
df.repartition(8).write.format("avro").save("datasets/optd_por_public_all.avro2")

sc.setJobDescription("dataset-gen.sc: random string table")
def randomStringGen(length: Int) = scala.util.Random.alphanumeric.take(length).mkString
val df = spark.sparkContext.parallelize(Seq.fill(10000){(randomStringGen(4), randomStringGen(4), randomStringGen(6), randomStringGen(4))}, 10).toDF("columna", "columnb", "columnc", "columnd")
df.write.option("header", "true").csv("datasets/dataset1.csv")
