let 
  pkgs = (import <nixpkgs>) {};
in 
  pkgs.runCommand "myname" {
    #buildInputs = [ pkgs.coreutils ];
  } ''
    mkdir $out
    echo tototext > $out/file1
  ''
