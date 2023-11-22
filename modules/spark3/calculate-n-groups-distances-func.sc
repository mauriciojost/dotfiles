// Arguments: --executor-memory 1G --driver-memory 1G --executor-cores 1

import org.apache.spark.sql.expressions.Window
import org.apache.spark.sql.DataFrame


// Prepare the data
val df = spark.read.option("delimiter","^").option("header","true").option("inferSchema","true").csv("datasets/optd_por_public_all.csv").where(col("latitude").isNotNull)
df.createOrReplaceTempView("df")
val df1 = df.where(df("country_name") === "Nicaragua" || df("country_name") === "Argentina" || df("country_name") === "France")
df1.createOrReplaceTempView("df1")

// Define the algorithm
def calculateGroups(df: DataFrame, colName: String, nroGroups: Int): List[String] = {

  val lagColName = s"lag_$colName"

  val orderByColName = Window.orderBy(desc(colName))
  val orderByDiff = Window.orderBy(desc("diff"))
  val diffs = df.withColumn("diff", lag(colName, 1).over(orderByColName) - col(colName)).withColumn(lagColName, lag(colName, 1).over(orderByColName))
  val topDiffs = diffs.withColumn("rank", rank().over(orderByDiff)).where($"rank" <= nroGroups - 1).drop("rank")
  val max :: min :: _ = diffs.selectExpr(s"max($colName)", s"min($colName)").first.toSeq.toList
  topDiffs.select(colName, lagColName).collect()
  val ranges = ((min +: topDiffs.select(colName, lagColName).collect.toList.map(i => i.toSeq.toList).flatten) ++ List(max)).grouped(2).toList
  val queries = ranges.map{case List(f, t)  => s"$colName BETWEEN $f and $t"}
  queries
}


// dimension   2 3       5 6       8 9
// diff         1    2    1    2    1
// diffranges       3 5       6 8
// maxmins     2                     9

// predicates  2[  ]3 5[     ]6 8[  ]9


// CHECKS

val queries = calculateGroups(df1, "latitude", 3)

spark.sql(s"select count(*), country_name from df1 group by country_name").show(10)
spark.sql(s"select count(*), country_name from df1 where ${queries.mkString(" OR ")} group by country_name").show(10)
spark.sql(s"select count(*), country_name from df1 where ${queries(0)} group by country_name").show(10)
spark.sql(s"select count(*), country_name from df1 where ${queries(1)} group by country_name").show(10)
spark.sql(s"select count(*), country_name from df1 where ${queries(2)} group by country_name").show(10)
