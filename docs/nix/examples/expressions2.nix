let 
  v1 = {x = 1; y = "hey";};
in {
  inherit (v1) x y;
  w = with v1; x;
  z = "${v1.y} you";
}
