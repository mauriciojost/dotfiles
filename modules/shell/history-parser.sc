#!/usr/bin/env amm

import scala.io.Source
import java.time._
import java.time.format._
import scala.util.Try

@main
def main(f: String) = {
  val p1 = DateTimeFormatter.ofPattern("E d MMM HH:mm:ss VV yyyy")
  val p2 = DateTimeFormatter.ofPattern("yyyy-MM-dd HH:mm")
  case class Record(pattern: Int, or: String, date: Option[String], session: Option[String], ws: Option[String], branch: Option[String], commands: Option[String]) {
    def dt: Option[ZonedDateTime] = { 
      date.flatMap { d => 
        val trimmed = d.trim
        val f1 = Try(ZonedDateTime.parse(trimmed.replace("CEST", "CET"), p1)).toOption
        val f2 = Try(LocalDateTime.parse(trimmed, p2).atZone(ZoneId.of("CET"))).toOption
        val v = f1.orElse(f2)
        if (! v.isDefined) 
          throw new IllegalArgumentException(s"Cannot parse date: '$trimmed'")
        v
      }
    }
    def csv: String = {
      if (ws.mkString.size > 30)
        throw new IllegalArgumentException(s"Unexpected large ws: '$ws' ('$or': $pattern)")
      s"$pattern^${dt.mkString}^${ws.mkString.trim}"
    }
  }
  val echoDateSessionDashWorspaceBranchCommands = "echo (\\w{3} \\d+ \\w+ [0-9:]+ \\w+ \\d{4}) (\\w+) - ws:(.*?) branch:(.*?);(.*)".r
  val echoDateSessionDashWorspaceCommands = "echo (\\w{3} \\d+ \\w+ [0-9:]+ \\w+ \\d{4}) (\\w+) - ws:(.*?);(.*)".r
  val echoDate2SessionDashWorspaceBranchCommands = "echo (\\w{10}\\s+[0-9:]+) (\\w+)\\s+-\\s+ws:\\s+(.*?)\\s+branch:(.*?);(.*)".r
  val echoDate2SessionDashWorspaceCommands = "echo ([0-9\\-]{10} [0-9:]+) (\\w+) - ws:(.*?); (.*)".r
  val echoSessionArrowCommandsDate = "([^ ]+)\\s+->\\s+(.*?)\\s+#\\s+(\\d{4}-\\d{2}-\\d{2} [0-9:]+)(.*)".r
  val echoSessionArrowCommands = "([^ ]+)\\s+->\\s+(.*)".r
  val commandsDate = "(.*)\\s+#\\s+(\\d{4}-\\d{2}-\\d{2} [0-9:]+.*)".r
  val cdCommandsDate = ">\\s+(cd.*\\s+#.*)".r
  val records = Source.fromFile(f).getLines.filterNot(_.isEmpty).map(s => s.replaceAll("  ", " ")).map { original =>
    original match {
      case echoDateSessionDashWorspaceBranchCommands(date, session, ws, branch, cmd) => Record(1, or = original, date = Some(date), session = Some(session), ws = Some(ws), branch = Some(branch), commands = Some(cmd))
      case echoDateSessionDashWorspaceCommands(date, session, ws, cmd) => Record(2, or = original, date = Some(date), session = Some(session), ws = Some(ws), branch = None, commands = Some(cmd))
      case echoDate2SessionDashWorspaceBranchCommands(date, session, ws, branch, cmd) => Record(3, or = original, date = Some(date), session = Some(session), ws = Some(ws), branch = Some(branch), commands = Some(cmd))
      case echoDate2SessionDashWorspaceCommands(date, session, ws, cmd) => Record(4, or = original, date = Some(date), session = Some(session), ws = Some(ws), branch = None, commands = Some(cmd))
      case echoSessionArrowCommandsDate(session, cmd, date, unk) => Record(5, or = original, date = Some(date), session = Some(session), ws = None, branch = None, commands = Some(cmd))
      case echoSessionArrowCommands(session, cmd) => Record(6, or = original, date = None, session = Some(session), ws = None, branch = None, commands = Some(cmd))
      case commandsDate(cmd, date) => Record(7, or = original, date = Some(date), session = None, ws = None, branch = None, commands = Some(cmd))
      case cdCommandsDate(cmd) => Record(8, or = original, date = None, session = None, ws = None, branch = None, commands = Some(cmd))
      case x => Record(9, or = original, date = None, session = None, ws = None, branch = None, commands = None)
    }
  }
  //records.foreach(k => println(k.dt))
  records.foreach(k => println(k.csv))
}

