#!/usr/bin/env amm

import scala.io.Source

@main
def main(f: String) = {
  val echoDateSessionDashWorspaceBranchCommands = "echo (\\w{3} \\d+ \\w+ [0-9:]+ \\w+ \\d{4} \\w+ - ws:.* branch:.*);.*".r
  val echoDateSessionDashWorspaceCommands = "echo (\\w{3} \\d+ \\w+ [0-9:]+ \\w+ \\d{4} \\w+ - ws:.*);.*".r
  val echoDate2SessionDashWorspaceBranchCommands = "echo (\\w{10}\\s+[0-9:]+ \\w+\\s+-\\s+ws:\\s+.*\\s+branch:.*);.*".r
  val echoDate2SessionDashWorspaceCommands = "echo ([0-9\\-]{10} [0-9:]+ \\w+ - ws:.*; .*)".r
  val echoSessionArrowCommandsDate = "([^ ]+\\s+->\\s+.*\\s+#\\s+\\d{4}-\\d{2}-\\d{2} [0-9:]+.*)".r
  val echoSessionArrowCommands = "([^ ]+\\s+->\\s+.*)".r
  val commandsDate = "(.*\\s+#\\s+\\d{4}-\\d{2}-\\d{2} [0-9:]+.*)".r
  val cdCommandsDate = "(>\\s+cd.*\\s+#.*)".r
  val a = Source.fromFile(f).getLines.filterNot(_.isEmpty).map(s => s.replaceAll("  ", " ")).foreach {
    case echoDateSessionDashWorspaceBranchCommands(m) => println("matched1 " + m)
    case echoDateSessionDashWorspaceCommands(m) => println("matched1a " + m)
    case echoDate2SessionDashWorspaceBranchCommands(m) => println("matched2 " + m)
    case echoDate2SessionDashWorspaceCommands(m) => println("matched2a " + m)
    case echoSessionArrowCommandsDate(m) => println("matched3 " + m)
    case echoSessionArrowCommands(m) => println("matched4 " + m)
    case commandsDate(m) => println("matched5 " + m)
    case cdCommandsDate(m) => println("matched6 " + m)
    case x => println("unmatched " + x)
  }
}

