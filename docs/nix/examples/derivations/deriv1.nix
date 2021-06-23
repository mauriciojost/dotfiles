with ((import <nixpkgs>) {});
derivation { 
  name = "myname";
  builder = "${bash}/bin/bash";
  system = "x86_64-linux";
  inherit coreutils;
  args = [./builder1];
}
