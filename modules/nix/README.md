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
nix-shell '<home-manager>' -A install
# Switch to your environment
home-manager switch
```
