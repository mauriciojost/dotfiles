let 
  pkgs = (import <nixpkgs>) {};
in 
  pkgs.runCommand "myname" {} ''
    ${pkgs.coreutils}/bin/mkdir $out
    echo tototext > $out/file1
  ''

# runCommand is a function that creates a derivation that would create its output by running a command
