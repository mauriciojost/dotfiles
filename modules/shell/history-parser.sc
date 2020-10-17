#!/usr/bin/env amm

import scala.io.Source
import java.time._
import java.time.format._
import scala.util._

object Record {
  val p1 = DateTimeFormatter.ofPattern("E d MMM HH:mm:ss VV yyyy")
  val p2 = DateTimeFormatter.ofPattern("yyyy-MM-dd HH:mm")

  def sanitize(s: String): String = s.trim
  def dateParse(d: String): ZonedDateTime = {
    val t = d.trim.replace("CEST", "CET")
    val r1 = Try(ZonedDateTime.parse(t, p1)).toOption
    val r2 = Try(LocalDateTime.parse(t, p2).atZone(ZoneId.of("CET"))).toOption
    r1.orElse(r2).getOrElse(throw new IllegalArgumentException(s"Cannot parse date: '$t'"))
  }

  def validate(r: Record): Try[Record] = Try {
    r.ws.foreach { w =>
      if (w.length > 30 || w.contains(" "))
        throw new IllegalArgumentException(s"Unexpected ws: $r")
    }
    r.session.foreach { s =>
      if (s.length > 40 || s.contains(" "))
        throw new IllegalArgumentException(s"Unexpected session: $r")
    }
    r.branch.foreach { b =>
      if (b.length > 50)
        throw new IllegalArgumentException(s"Unexpected branch: $r")
    }
    if (r.commands.isEmpty) {
      throw new IllegalArgumentException(s"Unexpected command: $r")
    }
    if (r.commands.exists(_.matches("^[0-9]+.*")))
      throw new IllegalArgumentException(s"Unexpected command: $r")
    r
  }

  def from(pattern: Int, or: String, date: Option[String], session: Option[String], ws: Option[String], branch: Option[String], commands: Option[String]): Try[Record] = validate{
    val cmd = commands.toList.flatMap(_.split(';').toList).map(_.trim)
    val (cd, otherCmds) = cmd match {
      case cdCmd :: otherCmds if cdCmd.startsWith("cd ") => (Some(cdCmd.replace("cd ", "")), otherCmds)
      case otherCmds => (None, otherCmds)
    }
    Record(
      pattern = pattern,
      line = or,
      date = date.map(dateParse),
      session = session.map(sanitize),
      ws = ws.map(sanitize),
      branch = branch.map(sanitize),
      commands = otherCmds.filterNot(_.isEmpty).map(_.trim),
      pwd = cd
    )
  }
  def formatDate(zdt: ZonedDateTime): String = zdt.toString
}

case class Record(pattern: Int, line: String, date: Option[ZonedDateTime], session: Option[String], ws: Option[String], branch: Option[String], commands: List[String], pwd: Option[String]) {
  import Record._
  def normalize(s: String): String = s.replaceAll(" ", "").replaceAll(";", "")
  def dateStr: String = date.map(d => normalize(formatDate(d))).mkString
  def wsStr: String = ws.map(normalize).mkString
  def pwdStr: String = pwd.mkString
  def branchStr: String = branch.mkString
  def sessionStr: String = session.map(normalize).mkString
  def csv: String = {
    s"${commands.mkString("; ")} ### pwd='$pwdStr' date='$dateStr' ws='$wsStr' branch='$branchStr' session='$sessionStr'"
  }

  override def toString: String = s"pattern=$pattern line='$line' date='$date' session='$session' ws='$ws' branch='$branch' commands='$commands'"
}

@main
def main(f: String) = {
  val echoDateSessionDashWorspaceBranchCommands = "echo (\\w{3} \\d+ \\w+ [0-9:]+ \\w+ \\d{4}) (\\w+) - ws:(.*?) branch:(.*?);(.*)".r
  val echoDateSessionDashWorspaceCommands = "echo (\\w{3} \\d+ \\w+ [0-9:]+ \\w+ \\d{4}) (\\w+) - ws:(.*?);(.*)".r
  val echoDate2SessionDashWorspaceBranchCommands = "echo (\\w{10}\\s+[0-9:]+) (\\w+)\\s+-\\s+ws:\\s+(.*?)\\s+branch:(.*?);(.*)".r
  val echoDate2SessionDashWorspaceCommands = "echo ([0-9\\-]{10} [0-9:]+) (\\w+) - ws:(.*?); (.*)".r
  val echoSessionArrowCommandsStrangeDate = "([^ ]+)\\s+->\\s+(.*?);\\s+[0-9]+(.*?)\\s+#\\s+(\\d{4}-\\d{2}-\\d{2} [0-9:]+)(.*)".r
  val echoSessionArrowCommandsDate = "([^ ]+)\\s+->\\s+(.*?)\\s+#\\s+(\\d{4}-\\d{2}-\\d{2} [0-9:]+)(.*)".r
  val echoSessionArrowCommands = "([^ ]+)\\s+->\\s+(.*)".r
  val commandsDate = "(.*)\\s+#\\s+(\\d{4}-\\d{2}-\\d{2} [0-9:]+.*)".r
  val cdCommandsDate = ">\\s+(cd.*\\s+#.*)".r
  val records = Source.fromFile(f).getLines.filterNot(_.isEmpty).map(s => s.replaceAll("  ", " ")).map { original =>
    original match {
      case echoDateSessionDashWorspaceBranchCommands(date, session, ws, branch, cmd) => Record.from(1, or = original, date = Some(date), session = Some(session), ws = Some(ws), branch = Some(branch), commands = Some(cmd))
      case echoDateSessionDashWorspaceCommands(date, session, ws, cmd) => Record.from(2, or = original, date = Some(date), session = Some(session), ws = Some(ws), branch = None, commands = Some(cmd))
      case echoDate2SessionDashWorspaceBranchCommands(date, session, ws, branch, cmd) => Record.from(3, or = original, date = Some(date), session = Some(session), ws = Some(ws), branch = Some(branch), commands = Some(cmd))
      case echoDate2SessionDashWorspaceCommands(date, session, ws, cmd) => Record.from(4, or = original, date = Some(date), session = Some(session), ws = Some(ws), branch = None, commands = Some(cmd))
      case echoSessionArrowCommandsStrangeDate(session, pwd, cmd, date, unk) => Record.from(55, or = original, date = Some(date), session = Some(session), ws = None, branch = None, commands = Some(pwd + ";" + cmd))
      case echoSessionArrowCommandsDate(session, cmd, date, unk) => Record.from(5, or = original, date = Some(date), session = Some(session), ws = None, branch = None, commands = Some(cmd))
      case echoSessionArrowCommands(session, cmd) => Record.from(6, or = original, date = None, session = Some(session), ws = None, branch = None, commands = Some(cmd))
      case commandsDate(cmd, date) => Record.from(7, or = original, date = Some(date), session = None, ws = None, branch = None, commands = Some(cmd))
      case cdCommandsDate(cmd) => Record.from(8, or = original, date = None, session = None, ws = None, branch = None, commands = Some(cmd))
      case x => Record.from(9, or = original, date = None, session = None, ws = None, branch = None, commands = None)
    }
  }

  val list = records.toList
  val (fa, su) = list.map(s => if (s.isFailure) (1, 0) else (0, 1)).reduce{(a, b) => (a._1 + b._1, a._2 + b._2)}
  val faPerc = 100.0 * fa/(fa + su)
  val suPerc = 100.0 * su/(fa + su)
  println(s"Failures: $fa ($faPerc%), successes: $su($suPerc%)")
  if (faPerc > 1.0) {
    list.filter(_.isFailure).foreach(println)
    throw new IllegalArgumentException("Too many failures")
  }
  val successes = list.collect {
    case Success(s) => s
  }
}

