let 
  f1 = x: y: x + y;   # function expecting 2 curried integers
  f2 = {x,y}: x + y; # function expecting 1 attribute set with x and y
  f3 = {x, y, ...}: x + y; # function expecting at least x and y
  f4 = {x, y ? 2}: x + y; # function expecting x and maybe y (with default value)
in {
  o1 = f1 1 2;
  o2 = f2 {x = 1; y = 2;};
  o3 = f3 {x = 1; y = 2; z = 3;};
  o4 = f4 {x = 1;};
}
