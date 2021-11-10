function qsystemd-reload() {
  systemctl daemon-reload
}

function qsystemd-list() {
  systemctl list-unit-files
}

function qsystemd-start-service() {
  local service="$1"
  systemctl start "$service"
}

function qsystemd-stop-service() {
  local service="$1"
  systemctl stop "$service"
}

function qsystemd-restart-service() {
  local service="$1"
  systemctl restart "$service"
}

function qsystemd-logs() {
  journalctl -xe
}

function qsystemd-logs-service() {
  local service="$1"
  journalctl -u "$service"
}

function qsystemd-enable-on-boot-service() {
  local service="$1"
  systemctl enable "$service"
}

function qsystemd-status-service() {
  local service="$1"
  systemctl status "$service"
}

function qsystemd-user-reload() {
  systemctl --user daemon-reload
}

function qsystemd-user-list() {
  systemctl --user list-unit-files
}

function qsystemd-user-start() {
  local service="$1"
  systemctl --user start "$service"
}

function qsystemd-user-stop() {
  local service="$1"
  systemctl --user stop "$service"
}

function qsystemd-user-restart() {
  local service="$1"
  systemctl --user restart "$service"
}

function qsystemd-logs() {
  journalctl -xe
}

function qsystemd-user-logs() {
  local service="$1"
  journalctl --user -u "$service"
}

function qsystemd-user-enable-on-boot() {
  local service="$1"
  systemctl --user enable "$service"
}

function qsystemd-user-status() {
  local service="$1"
  systemctl --user status "$service"
}

