# PYTHON 

Examples

```
import os
import codecs
import re

# Process all the reports in the input directory
# one by one
def process_reports(reports_dir, output_dir):
  reports = os.listdir(reports_dir)
  for r in reports:
    print 'Processing ' + r
    process_report(os.path.join(reports_dir, r), output_dir)

# Process a given report and write it to the 
# output directory
def process_report(report, output_dir):
  f = codecs.open(os.path.join(output_dir, os.path.basename(report)), 'w+')

  with open(report) as file:
	lines = file.readlines()

  output=[]
  for l in lines: 
    processed_line = process_line(l, len(output) == 0)
    output.extend([processed_line])

  for o in sorted(output):
    f.write(o + '\n')

  f.close()


def process_line(line, header):
        r[8] + new_sep

def standard_date(raw_date):
  dd = raw_date[0:2]
  mm = raw_date[3:5]
  yyyy = raw_date[6:10]
  return yyyy + '-' + mm + '-' + dd

def standard_amount(raw_amount):
  return re.sub(r"(\d) (\d)",r"\1\2", raw_amount)

if __name__ == '__main__':
  output="output"
  reports="reports"
  process_reports(reports, output)


