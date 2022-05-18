#!/usr/bin/env amm

// Heads up with the imports colliding with the file-name, avoid it

import $ivy.`com.fasterxml.jackson.core:jackson-databind:2.9.8`, com.fasterxml._

import com.fasterxml.jackson.databind.ObjectMapper
import java.io.File

@main
def main(file: String, query: String) = {
  val mapper = new ObjectMapper();
  val root = mapper.readTree(new File(file));
  println(root.at(query))
}

