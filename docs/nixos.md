# NIX OS

Some terminology: 
- derivation (.drv file, containing the description of the plan to build a package)
- expression
- plan (translating a .drv into a result in the store)
- store (where all derivations .drv and results (directory result of the build))
- instantiate (create the derivation)



Useful commands

```
nix-env -q # list "installed" packages (active in your profile)
```


Install a package
```
nix-env -iA nixpgks.bat # path needs to be known, nixpks is the domain of packages, bat is the name of what we want to install
                        # nixpks is the channel name
nix-env -i bat          # equivalent (by name)
```

All package definitions can be found here: 

https://github.com/NixOS/nixpkgs/tree/master/pkgs


nix repl

pkgs = (import <nixpkgs>) {}   # <nixpkgs> is relative to the NIX_PATH variable (see below where to find more info)
                             # assign to pkgs variable a function evaluated (thanks to {})
                             # (import <nixpkgs>) brings the function (is an expression which could be a function or any other value)
                             # {} evaluates it
                             # man nix-shell for more information on NIX_PATH



https://github.com/NixOS/nixpkgs/blob/master/default.nix

```
(let x = value; in

... expression using local variable x
```



# Build/install a custom package outside nix packages tree (as mebubo/nixos-example)

1. Go to the cloned repo
2. Enter the package you want to build/install `service-a`
3. 
```
nix-build release.nix # nix-instantiate and nix-store
```
