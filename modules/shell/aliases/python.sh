function qpython-virtualenv-create() {
  virtualenv -p /usr/bin/python3.8 venv
}
function qpython-virtualenv-activate() {
  source venv/bin/activate
}
function qpython-virtualenv-deactivate() {
  deactivate
}
