with (import <nixpkgs> {});
derivation {
  home.packages = with pkgs; [
    pkgs.atool
    pkgs.elinks
    pkgs.unzip
    pkgs.zip
  ];
}

