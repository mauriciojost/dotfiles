#!/usr/bin/env amm

// Heads up with the imports colliding with the file-name, avoid it

import $ivy.`com.amazonaws:jmespath-java:1.12.215`, com.amazonaws._

import com.amazonaws.jmespath.{JmesPath, Expression}
import com.amazonaws.jmespath.jackson.JacksonRuntime

@main
def main(file: String, query: String) = {

  val jr = new JacksonRuntime();
  val query = jr.compile(query);
  //query.search(


}

