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

Current issue:

```
Activating checkFilesChanged
Activating checkLinkTargets
Activating writeBoundary
Activating installPackages
replacing old 'home-manager-path'
installing 'home-manager-path'
building '/nix/store/mp02k3h202xsp1cql2m3hnjmhwizyy1j-user-environment.drv'...
error: packages '/nix/store/h3yarf0n9jrls162abl9420l10ijwkaj-home-manager-path/bin/rview' and '/nix/store/79ffq01b16a3lz53zvfvh32pfmhpynnv-vim-8.2.1123/bin/rview' have the same priority 5; use 'nix-env --set-flag priority NUMBER INSTALLED_PKGNAME' to change the priority of one of the conflicting packages (0 being the highest priority)
builder for '/nix/store/mp02k3h202xsp1cql2m3hnjmhwizyy1j-user-environment.drv' failed with exit code 1
error: build of '/nix/store/mp02k3h202xsp1cql2m3hnjmhwizyy1j-user-environment.drv' failed


```
