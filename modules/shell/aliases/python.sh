function qpython-virtualenv-create() {
  virtualenv -p /usr/bin/python3.8 venv
}
function qpython-virtualenv-activate() {
  source venv/bin/activate
}
function qpython-virtualenv-deactivate() {
  deactivate
}

# first install
# https://github.com/pyenv/pyenv?tab=readme-ov-file
# https://github.com/pyenv/pyenv-virtualenv
function qpython-pyenv-create() {
  version=$1
  envname=$2
  pyenv virtualenv $version $envname
}

function qpython-pyenv-list() {
  pyenv virtualenvs
}

function qpython-pyenv-activate() {
  envname=$1
  pyenv activate $envname
}

function qpython-pyenv-deactivate() {
  pyenv deactivate
}
