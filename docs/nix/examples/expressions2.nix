# https://nixos.wiki/wiki/Nix_Expression_Language
let 
  v1 = {x = 1; y = "hey";};
in {
  inherit (v1) x y;
  w = with v1; x; # The with statement (link to Nix manual section) introduces an attrset's value contents into the lexical scope of into the expression which follows. 
  z = "${v1.y} you";
}
