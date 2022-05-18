#!/usr/bin/env amm

import $ivy.`com.jayway.jsonpath:json-path:2.7.0`, com.jayway._

import com.jayway.jsonpath.JsonPath
import java.io.File

@main
def main(file: String, query: String) = {
  val result = JsonPath.parse(new File(file)).read[Any](query);
  println(result)
}

