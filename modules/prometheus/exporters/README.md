# README

## Process exporter

I installed it with the regular package manager and passed the hereby provided configuration file. 
That was enough for me.

## Grok logs parser exporter

I had to tweak it and install it manually under `/opt/grok_exporter/`. The tweak was due to the high amount of files 
that need to be parsed (around 1 year of data, hourly files).
The best way I found was to parse the current-day data, and expose their metrics. This means that regularly the loaded 
files have to change, so the process that reads them needs to be restarted upon configuration file update.

