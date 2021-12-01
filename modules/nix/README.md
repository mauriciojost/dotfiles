# README

I had not much disk space left under `/` so I created a bind mountpoint for `/nix` in via `/ets/fstab` (to mount `/nix` into `/home/nix` in my case).

```
/home/nix                                 /nix            none     defaults,bind  0        0
```

Inspiration:

- https://hugoreeves.com/posts/2019/nix-home/

## HOME-MANAGER

This tool allows you to set up the environment for your home. 

```
# Install home-manager
nix-channel --add https://github.com/rycee/home-manager/archive/master.tar.gz home-manager
nix-channel --update
export NIX_PATH=$NIX_PATH:$HOME/.nix-defexpr/channels # you may need this, as per https://github.com/NixOS/nix/issues/2033
nix-shell '<home-manager>' -A install
# Switch to your environment (ensure you're on the root generation, no packages installed manually)
cd ~/.config/nixpkgs
home-manager switch
```
