#!/usr/bin/env amm

import $ivy.`co.fs2::fs2-io:2.4.5`, fs2.Stream
import $ivy.`org.typelevel::cats-effect:2.2.0`, cats.effect._

import java.nio.file.{Path, Paths}

import scala.concurrent.ExecutionContext

implicit val ec: ExecutionContext = ExecutionContext.global
implicit val cs: ContextShift[IO] = IO.contextShift(ec)
implicit val blocker: Blocker = Blocker.liftExecutionContext(ec)
implicit val timer: Timer[IO] = IO.timer(ec)

def tailFile(
  path: Path,
  chunkSize: Int = 1024
): Stream[IO, Byte] = {
  val bytes = fs2.io.file.tail[IO](path, blocker, chunkSize)
  //bytes.through(fs2.text.utf8Decode).through(fs2.text.lines)
  bytes
}

def p(i: Stream[IO, Byte]): Stream[IO, Byte] = {
  i.evalMap{s =>
    IO {
      println(s.toInt)
      s
    }
  }
}


@main
def main(f: String) = {
  val s = tailFile(Paths.get(f), 8)
  s.through(p).drain.compile.toList.unsafeRunSync()
}



