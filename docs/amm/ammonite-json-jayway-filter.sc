#!/usr/bin/env amm

import $ivy.`com.jayway.jsonpath:json-path:2.8.0`, com.jayway._

import com.jayway._
import com.jayway.jsonpath._
import net.minidev.json._

import java.io.File

@main
def main(file: String, query: String) = {
  val result = JsonPath.parse(new File(file)).read[JSONArray](query)
  println(s"RESULT: \n$result\n\n")
  if (result.isEmpty)
    println("==> NOT ELIGIBLE")
  else
    println("==> ELIGIBLE")
}

