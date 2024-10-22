#!/usr/bin/env amm

// Heads up with the imports colliding with the file-name, avoid it

import $ivy.`com.github.pureconfig::pureconfig:0.17.7`

import pureconfig._
import pureconfig.generic.auto._

case class Loose(json: String) 
case class BaseConf(
  host: String,
  useHttps: Boolean,
  addons: Loose
)

implicit val looseReader = ConfigReader.fromCursor[Loose] { cur =>
  val res = for {
    objCur <- cur.asObjectCursor      // 1
  } yield new Loose(objCur.valueOpt.head.toString)
  res
}

@main
def main(path: String) = {
  println(ConfigSource.file(path).load[BaseConf])

}

