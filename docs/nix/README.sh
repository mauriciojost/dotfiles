echo Some expressions and functions

set -x

nix-instantiate --eval          examples/expressions.nix
nix-instantiate --eval --strict examples/expressions.nix
