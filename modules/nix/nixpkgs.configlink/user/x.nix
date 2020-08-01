# ~/.config/nixpkgs/user/x.nix
{ config, pkgs, ... }:

let 
  my-python-packages = python-packages: with python-packages; [
    pip
    virtualenv
    requests
    ipython
  ];
  python-with-my-packages = pkgs.python3.withPackages my-python-packages;
in 
{
  imports = [
    #../program/terminal/tmux/default.nix
  ];

  home.packages = with pkgs; [
    # Development
    neovim
    vim
    tmux
    jq
    git
    whois
    git-cola
    python-with-my-packages
  ];

  #programs.git = {
  #  enable = true;
  #  userEmail = "mauriciojost@gmail.com";
  #  userName = "Mauri Jost";
  #  signing.signByDefault = true;
  #};

}
