// Arguments: --executor-memory 1G --driver-memory 1G --executor-cores 1
sc.setJobDescription("Noop sample")

io.delta.tables.DeltaTable.forPath("datasets/optd_por_public_all.delta/").toDF.write.format("noop").mode("overwrite").save()

