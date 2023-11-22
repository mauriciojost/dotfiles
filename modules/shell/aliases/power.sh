function qpower-mode-save() {
  sudo cpufreq-set -g powersave
}

function qpower-mode-performance() {
  sudo cpufreq-set -g performance
}

function qpower-mode() {
  cpufreq-info | grep 'governor'
}
