#!/usr/bin/env amm

import scala.collection.parallel.ParSeq
import scala.util.Try

@main
def main() = {
  val seq = Seq(1, 2, 3)
  val seqPar: ParSeq[Int] = seq.par
  val seqTryProcPar = seqPar.map{d => println("processing started"); Thread.sleep(1000 * 5); println("processing finished"); Try(if (d!=1) d + 1 else throw new RuntimeException("toto"))}
  println("before sleep")
  Thread.sleep(1000 * 10)
  println("after sleep")
  seqTryProcPar.foreach(println)
}

