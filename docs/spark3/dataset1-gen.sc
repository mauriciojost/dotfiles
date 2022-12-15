sc.setJobDescription("dataset1-gen.sc")
def randomStringGen(length: Int) = scala.util.Random.alphanumeric.take(length).mkString
val df = spark.sparkContext.parallelize(Seq.fill(10000){(randomStringGen(4), randomStringGen(4), randomStringGen(6), randomStringGen(4))}, 10).toDF("columna", "columnb", "columnc", "columnd")
df.write.option("header", "true").csv("datasets/dataset1.csv")
