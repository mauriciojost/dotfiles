#!/usr/bin/env amm

import scala.util.Try
import $ivy.`org.scala-lang.modules::scala-parallel-collections:0.2.0`,scala.collection.parallel._
import scala.collection.parallel.CollectionConverters._

@main
def main() = {
  val seq = Seq(1, 2, 3)
  val seqPar: ParSeq[Int] = seq.par
  val seqTryProcPar = seqPar.map { d => 
    println(s"Processing started: $d")
    Thread.sleep(1000 * 5)
    println(s"Processing finished: $d")
    Try {
      if (d!=1) 
        d + 1 
      else 
        throw new RuntimeException(s"Toto $d")
    }
  }
  println("Before sleep")
  Thread.sleep(1000 * 10)
  println("After sleep")
  seqTryProcPar.foreach(println)
}

