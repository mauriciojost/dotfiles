function qpower-mode-save() {
  for cpu in seq 0 7
  do
    sudo cpufreq-set --cpu $cpu -g powersave
  done
}

function qpower-mode-performance() {
  for cpu in seq 0 7
  do
    sudo cpufreq-set --cpu $cpu -g performance
  done
}

function qpower-mode() {
  cpufreq-info | grep 'governor' | grep -v available
}
