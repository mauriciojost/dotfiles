# README

This module allows to launch 'boundles' of snippets on Spark 3, where each boundle contains:

- a scala snippet
- the dependencies
- the spark settings

The simplest bundle: 

```scala
// Arguments: --executor-memory 1G --driver-memory 1G --executor-cores 1 --master local[6] --conf spark.sql.adaptive.enabled=false

val df = spark.read.option("delimiter","^").option("header","true").csv("datasets/optd_por_public_all.csv")

```

Mind that it contains in the first line all Spark shell arguments.

## Initialize it

The very first time: 

1. Add the following to your `.bashrc` file: 

```
export PATH=$PATH:<spark-shell-directory>
source $HOME/.dotfiles/modules/spark3/source.sh # to define the alias qspark
```

2. Then set up some sample datasets:

```
cd ~/.dotfiles/modules/spark3
curl https://raw.githubusercontent.com/opentraveldata/opentraveldata/master/opentraveldata/optd_por_public_all.csv > datasets/optd_por_public_all.csv
qspark dataset-gen.sc # this will generate .parquet, .delta, ... datasets
```

## Launch a bundle

```
qspark <bundle.sc> # this will launch the snippet with the settings defined after 'Arguments: ' prefixed line
```

