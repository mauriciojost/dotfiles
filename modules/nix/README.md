# README

I had not much disk space left under `/` so I created a bind mountpoint for `/nix` in via `/ets/fstab` (to mount `/nix` into `/home/nix` in my case).

```
/home/nix                                 /nix            none     defaults,bind  0        0
```
