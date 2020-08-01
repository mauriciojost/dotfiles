alias qnix-list='nix-env -q'
alias qnix-install='nix-env -i'

function qnix-explore-db() {
  nix-env -iA sqlite -f '<nixpkgs>'
  sqlite3 /nix/var/nix/db/db.sqlite
}

function qnix-explore-profile() {
  ls $HOME/.nix-profile
}

alias qnix-generations-list='nix-env --list-generations'
alias qnix-derivations-list='nix-env -q'
alias qnix-generation-rollback='nix-env --rollback'
alias qnix-generation-switch-to-x='nix-env -G'
function qnix-dependencies-of-x() {
  local bin="$1"
  nix-store -q --references "$(which "$bin")"
}
function qnix-dependencies-of-x-all() {
  local bin="$1"
  nix-store -q --tree $(which "$bin")
}

alias qnix-channels-list='nix-channel --list'

function qnix-packages-upgrade-all() {
  nix-channel --update
  nix-env -u
}

alias qnix-repl='nix repl'

alias qnix-build-pointnix-x='nix-build'
