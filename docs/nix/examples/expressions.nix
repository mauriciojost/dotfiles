# nix-instantiate --eval c1.nix

let 
  f = x: y: x + y;   # one function expecting 2 curried integers
  f1 = {x,y}: x + y; # one function expecting 1 attribute set with x and y
  h3 = {x, y, ...}: x + y;
  h4 = {x, y ? 3}: x + y;
in {
  y = f 1 2;
  #y = f1 {x: 1, y: 2};
}
