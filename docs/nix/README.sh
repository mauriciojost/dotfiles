echo Some expressions and functions

set -x

nix-instantiate --eval          examples/expressions.nix
nix-instantiate --eval --strict examples/expressions.nix

nix-instantiate --eval          examples/expressions2.nix
nix-instantiate --eval --strict examples/expressions2.nix

nix-instantiate --eval          examples/derivations/deriv1.nix
nix-instantiate                 examples/derivations/deriv1.nix # will create a derivation explorable with `nix show-derivation`
nix-build                       examples/derivations/deriv1.nix
