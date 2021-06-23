echo Some expressions and functions

set -x

nix-instantiate --eval          examples/expressions.nix
nix-instantiate --eval --strict examples/expressions.nix

nix-instantiate --eval          examples/expressions2.nix
nix-instantiate --eval --strict examples/expressions2.nix
