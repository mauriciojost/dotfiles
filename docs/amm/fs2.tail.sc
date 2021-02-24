#!/usr/bin/env amm

// Heads up with the imports colliding with the file-name, avoid it

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
): Stream[IO, String] = {
  val bytes = fs2.io.file.tail[IO](path, blocker, chunkSize)
  bytes.through(fs2.text.utf8Decode).through(fs2.text.lines)
}

def print(s: Stream[IO, String]): Stream[IO, String] = {
  s.evalMap{s =>
    IO {
      println(s)
      s
    }
  }
}


@main
def main(file: String) = {
  val tail = tailFile(Paths.get(file), 8)
  println(s"Reading $file...")
  tail.through(print).drain.compile.toList.unsafeRunSync()
}



