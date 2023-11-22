// Arguments: --executor-memory 1G --driver-memory 1G --executor-cores 1

import org.apache.spark.sql.expressions.Window

val NroGroups = 3
val ColumnName = "latitude"
val Dimension = "dimension"
val LagDimension = "lag_dimension"

val df = spark.read.option("delimiter","^").option("header","true").option("inferSchema","true").csv("datasets/optd_por_public_all.csv").withColumn(Dimension, col(ColumnName)).where(col(ColumnName).isNotNull)
df.createOrReplaceTempView("df")

val df1 = df.where(df("country_name") === "Nicaragua" || df("country_name") === "Argentina" || df("country_name") === "France")
df1.createOrReplaceTempView("df1")

val orderByDimension = Window.orderBy(desc(Dimension))
val orderByDiff = Window.orderBy(desc("diff"))

val prefilter = df1.select(Dimension,"country_name")

val diffs = prefilter.withColumn("diff", lag(Dimension, 1).over(orderByDimension) - prefilter(Dimension)).withColumn(LagDimension, lag(Dimension, 1).over(orderByDimension))

val topDiffs = diffs.withColumn("rank", rank().over(orderByDiff)).where($"rank" <= NroGroups - 1).drop("rank")

val max :: min :: _ = diffs.selectExpr("max(dimension)", "min(dimension)").first.toSeq.toList
topDiffs.select(Dimension, LagDimension).collect()

val ranges = ((min +: topDiffs.select(Dimension, LagDimension).collect.toList.map(i => i.toSeq.toList).flatten) ++ List(max)).grouped(2).toList

val queries = ranges.map{case List(f, t)  => s"dimension BETWEEN $f and $t"}




// dimension   2 3       5 6       8 9
// diff         1    2    1    2    1
// diffranges       3 5       6 8
// maxmins     2                     9

// predicates  2[  ]3 5[     ]6 8[  ]9


// CHECKS

spark.sql(s"select count(*), country_name from df1 group by country_name").show(10)
spark.sql(s"select count(*), country_name from df1 where ${queries.mkString(" OR ")} group by country_name").show(10)
spark.sql(s"select count(*), country_name from df1 where ${queries(0)} group by country_name").show(10)
spark.sql(s"select count(*), country_name from df1 where ${queries(1)} group by country_name").show(10)
spark.sql(s"select count(*), country_name from df1 where ${queries(2)} group by country_name").show(10)
