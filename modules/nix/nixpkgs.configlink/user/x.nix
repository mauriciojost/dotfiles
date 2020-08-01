# ~/.config/nixpkgs/user/x.nix
{ config, pkgs, ... }:

{
  imports = [
    #../program/editor/neovim/default.nix
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

  ];

  #programs.git = {
  #  enable = true;
  #  userEmail = "mauriciojost@gmail.com";
  #  userName = "Mauri Jost";
  #  signing.signByDefault = true;
  #};
  
}
