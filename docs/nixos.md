# NIX OS

## From Pills


A **profile** in Nix is a general and convenient concept for realizing rollbacks.
Profiles are made up of multiple "generations": they are versioned.
Generations can be switched and rolled back atomically, which makes them convenient for managing changes to your system.

Nix **expressions** are used to describe packages and how to build them. Nixpkgs is the repository containing all of the expressions: https://github.com/NixOS/nixpkgs.

**Channels** are a set of packages and expressions available for download. Similar to Debian stable and unstable, there's a stable and unstable channel. In this installation, we're tracking nixpkgs-unstable.

Channels are where are we getting packages from. There's a list of channels from which we get packages, although usually we use a single channel. The tool to manage channels is nix-channel.

To remind you, ~/.nix-profile/etc points to the nix-2.1.3 derivation.



## With Sergei
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
