#!/usr/bin/env amm

// Heads up with the imports colliding with the file-name, avoid it

import $ivy.`com.github.vagmcs::optimus:3.2.4`, optimus.optimization._
import $ivy.`com.github.vagmcs::optimus-solver-lp:3.2.4`
import $ivy.`com.github.vagmcs::optimus-solver-oj:3.2.4`

import optimus.optimization.enums.SolverLib
import optimus.optimization.model.MPFloatVar

@main
def main() = {
  // Excercise 3 from https://www.hds.utc.fr/~dnace/dokuwiki/_media/fr/megaexercises.pdf

  implicit val model = MPModel(SolverLib.oJSolver)
  val p1 = MPFloatVar("p1", 0, 1000)
  val p2 = MPFloatVar("p2", 0, 1000)

  // a = 1h, b = 0.75h, c = 0.25h (+0.25h hand)
  // Each week total production time
  // p1 => 1 A + 1 C => 1 * 1 + 1 * 0.25
  // p2 => 2 B + 1 C => 2 * 0.75 + 1 * 0.25
  add(p1 * (1 * 1 + 0.25 * 1) + p2 * (0.75 * 2 + 0.25 * 1) <:= 300)

  // and hand finishing must not exceed 45 hrs.
  // p1 => 1 C => 1 * 0.25
  // p2 => 1 C => 1 * 0.25
  add(p1 * (0.25 * 1) + p2 * (0.25 * 1) <:= 45)

  // p1 => max 130
  // p2 => max 100
  add(p1 <:= 130)
  add(p2 <:= 100)

  // p1 => 30 pounds
  // p2 => 45 pounds
  maximize(p1 * 30 + p2 * 45)

  // Formulate the problem of planning weekly production to maximise total proceeds as a linear programming problem in 2 variables and obtain the solution graphically.

  start()
  println(s"objective: $objectiveValue")
  println(s"p1=${p1.value} p2=${p2.value}")
  release()
}



