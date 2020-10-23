#!/usr/bin/env amm

import scala.io.Source
import java.time._
import java.time.format._
import scala.util._
import java.io._

object Record {
  val p1 = DateTimeFormatter.ofPattern("E d MMM HH:mm:ss VV yyyy")
  val p2 = DateTimeFormatter.ofPattern("yyyy-MM-dd HH:mm")
  val p3output = DateTimeFormatter.ofPattern("yyyy-MM-dd-HH-mm-ss")

  def sanitize(s: String): String = s.trim
  def dateParse(d: String): ZonedDateTime = {
    val t = d.trim.replace("CEST", "CET")
    val r1 = Try(ZonedDateTime.parse(t, p1)).toOption
    val r2 = Try(LocalDateTime.parse(t, p2).atZone(ZoneId.of("CET"))).toOption
    val r3 = Try(LocalDateTime.parse(t, p3output).atZone(ZoneId.of("CET"))).toOption
    r1.orElse(r2).orElse(r3).getOrElse(throw new IllegalArgumentException(s"Cannot parse date: '$t'"))
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

  def from(pattern: Int, or: String, date: Option[String], session: Option[String], ws: Option[String], branch: Option[String], commands: Option[String]): Try[Record] = Try{
    val cmd = commands.toList.flatMap(_.split(';').toList).map(_.trim)
    val (cd, otherCmds) = cmd match {
      case cdCmd :: otherCmds if (pattern != 10) && cdCmd.startsWith("cd ") => (Some(cdCmd.replace("cd ", "").trim), otherCmds)
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
  }.flatMap(validate)
  def formatDate(zdt: ZonedDateTime): String = p3output.format(zdt)
}

case class Record(pattern: Int, line: String, date: Option[ZonedDateTime], session: Option[String], ws: Option[String], branch: Option[String], commands: List[String], pwd: Option[String]) {
  import Record._
  def normalize(s: String): String = s.replaceAll(" ", "").replaceAll(";", "")
  def dateStr: String = date.map(d => normalize(formatDate(d))).mkString
  def wsStr: String = ws.map(normalize).mkString
  def pwdStr: String = pwd.mkString
  def branchStr: String = branch.mkString
  def sessionStr: String = session.map(normalize).mkString
  def csv: String = s"${commands.mkString("; ")} ### pwd='$pwdStr' date='$dateStr' ws='$wsStr' br='$branchStr' ss='$sessionStr'"
}

@main
def main(iFile: String, oFile: String) = {
  val echoDateSessionDashWorspaceBranchCommands = "echo (\\w{3} \\d+ \\w+ [0-9:]+ \\w+ \\d{4}) (\\w+) - ws:(.*?) branch:(.*?);(.*)".r
  val echoDateSessionDashWorspaceCommands = "echo (\\w{3} \\d+ \\w+ [0-9:]+ \\w+ \\d{4}) (\\w+) - ws:(.*?);(.*)".r
  val echoDate2SessionDashWorspaceBranchCommands = "echo (\\w{10}\\s+[0-9:]+) (\\w+)\\s+-\\s+ws:\\s+(.*?)\\s+branch:(.*?);(.*)".r
  val echoDate2SessionDashWorspaceCommands = "echo ([0-9\\-]{10} [0-9:]+) (\\w+) - ws:(.*?); (.*)".r
  val echoSessionArrowCommandsStrangeDate = "([^ ]+)\\s+->\\s+(.*?);\\s+[0-9]+(.*?)\\s+#\\s+(\\d{4}-\\d{2}-\\d{2} [0-9:]+)(.*)".r
  val echoSessionArrowCommandsDate = "([^ ]+)\\s+->\\s+(.*?)\\s+#\\s+(\\d{4}-\\d{2}-\\d{2} [0-9:]+)(.*)".r
  val echoSessionArrowCommands = "([^ ]+)\\s+->\\s+(.*)".r
  val commandsDate = "(.*)\\s+#\\s+(\\d{4}-\\d{2}-\\d{2} [0-9:]+.*)".r
  val cdCommandsDate = ">\\s+(cd.*\\s+#.*)".r
  val target = "(.*?) ### pwd='(.*?)' date='(.*?)' ws='(.*?)' br='(.*?)' ss='(.*?)'".r
  val records = Source.fromFile(iFile).getLines.filterNot(_.isEmpty).map(s => s.replaceAll("  ", " ")).map { original =>
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
      case target(cmd, pwd, date, ws, br, sess) => Record.from(10, or = original, date = Some(date), session = Some(sess), ws = Some(ws), branch = Some(br), commands = Some(cmd))
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
  val useful = successes
    .filterNot(_.commands == List("ls"))

  val pw = new PrintWriter(new File(oFile))
  useful.foreach(r => pw.write(r.csv))
  pw.close
}

