#!/usr/bin/env amm

// Heads up with the imports colliding with the file-name, avoid it

import $ivy.`com.chuusai::shapeless:2.3.3`, shapeless._

@main
def main(i: Int, s: String, path: os.Path = os.pwd) = {
  s"Hello! ${s * i} ${path.last}."
}

