# NIX OS

## From Pills

See [here](https://nixos.org/guides/nix-pills/)

A **profile** in Nix is a general and convenient concept for realizing rollbacks.
Profiles are made up of multiple "generations": they are versioned.
**Generations** can be switched and rolled back atomically, which makes them convenient for managing changes to your system. Whenever you change a **profile**, a new **generation** is created.

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

# Write a package on your own

From [here](https://nix-tutorial.gitlabpages.inria.fr/nix-tutorial/first-package.html)

Language: “Nix Expression Language”.
- functional
- weird syntax

A `derivation` is a sort of `package`. More precisely is the function that describes a build process.

This is a derivation for the example: 

```
{                                                                                                   #  between these {} you have the input of the functionb
  pkgs ? import (fetchTarball "https://github.com/NixOS/nixpkgs-channels/archive/b58ada326aa612ea1e2fb9a53d550999e94f1985.tar.gz") {} #  input: the pkgs variable, ? gives a default value to pkgs, top-level tree of packages, The pkgs imported here is a snapshot of the unstable nixpkgs channel on the b58ada326aa612ea1e2fb9a53d550999e94f1985 commit. The nixpkgs tree of this commit can be traversed here.
}:
pkgs.stdenv.mkDerivation rec { # mkDerivation takes a set as input and expects many attributes within it 
  pname = "chord"; # the pname and version attributes are concatenated to form the package name (i.e. chord-0.1.0)
  version = "0.1.0";

  rev = "cbe903e7f8839794fbe572ea4c811e2c802a4038";
  src = pkgs.fetchurl { # the src attribute is mandatory and needs to point to the directory that contains the source code.
                        # fetchurl downloads the file, unpacks it if necessary, then ensures that the hash of the download content matches the expected sha256.
    url = "https://gitlab.inria.fr/nix-tutorial/chord-tuto-nix-2019/-/archive/${rev}/chord-tuto-nix-2019-${rev}.tar.gz";
    sha256 = "1d75ad63llkcgs2y44fsfismg0n6srlzx3n8fy9v07550jnhwh1c";
  };

  buildInputs = [ # buildInputs attribute contains the list of packages required to build the derivation
    pkgs.simgrid
    pkgs.boost
    pkgs.cmake
  ];

  configurePhase = '' # Nix separates the build process in several phases, that are concatenated to form a build script. This seems strange at first but this is quite convenient, as usually only a small subpart of the package build process needs to be changed.
    cmake .
  '';

  buildPhase = ''
    make
  '';
  # In this case, Nix does the default build script for CMake, which is essentially cmake && make && make install

  installPhase = ''
    mkdir -p $out/bin
    mv chord $out/bin
  '';
}
```

Then you can do: 
```
nix-build chord_example.nix
```

And thanks to the build of the derivation see: 

```
./result/bin/chord --help
```

You can also enter the environment: 
```
nix-shell --pure chord_example.nix
```

## From meetup


If you want a package, search it in nixpkgs
- use that version nixpkgs
- bring the derivation to your environment (for instance via dotfiles, or shell.nix)
    - nix and what it builds: stable (minimal)
    - mix diffuse function(packages) -> (not stable)

## Questions
1. How to add a section to your dotfiles


```

nix-instantiate --eval a.nix
nix-instantiate --eval --expr "2 + 2"
nix-instantiate --eval a.nix -A attribute1    # pick one attribute from the attribute set
```


2. What are the available types:
```
boolean
int
string
path
attribute set aka record (c struct, case class in scala, product type)
...
```

3. What is the `inherit` keyword for

It's a way to reference children attributes in the in


4. About the let/in block, ... what are they?

```
let
  <bindings>    # expressions to names, assignments
in
  ...  # in block
```

## Function

Different ways to define functions:

```
f = x: y: x + y;   # one function expecting 2 curried integers
f1 = {x,y}: x + y;} # one function expecting 1 attribute set with x and y
h3 = {x, y, ...}: x + y;
h4 = {x, y ? 3}: x + y;

```

Lambda in nix = closure (function that depends on other variables in the in section / assignments section.

## Nix file

A `.nix` file returns an expression:

```
let x = 2 + 2; f = x: x * 2; in f (x + 3)
```

With `import` you load its content, passing as argument normally an attribute set {} .

## Nix expression nixpkgs

When you do `import <nixpkgs> {}` (equivalent to `(import <nixpkgs) {}`) you are referring to the value of the stuff in NIX_PATH environment variable which looks as:

```
$NIX_PATH=nixpkgs=/..../    # contains a default.nix
```

The referred path in `nixpkgs=...` is a path that contains a `default.nix` file.

(import <nixpkgs>) called with an empty attribute set (as an argument)

# Build a derivation

A derivation is just a special type of attribute set, that contains `type`, `name`, `system` and `builder` attributes.

```
...
int
string
path
attribute set aka record (c struct, case class in scala, product type)
    - derivation (required certain attributes)                             # important for derivations !!!
        -  ..., name: string, system: string, builder: path, ...
```

To evaluate it (you will see the attribute set as generated):
```
nix-instantiate --eval c1.nix # evaluates the expression
```

To **instantiate** it interpreting as derivation (not evaluate, but instantiate, you will see the attribute set as generated:
```
nix-instantiate c1.nix
```

Builds a derivation and puts it into the store. Nix language stops at the first stage. Building it is independent from nix language.

Builtin function `derivation` is important, so that nix instantiate can produce a meaningful derivation:

```
derivation {
  name = "myname";
  system = "x86_64-linux";
  builder = ./builder;
}
```

Produces a richer resource set:
```
{
  name = "myname";
  system = "x86_64-linux";
  builder = ./builder;
  ... # extra stuff
}
```

nix-instantiate c1.nix # produces a path .drv in the store


It will contain:
- the output of the `product` / `build output` / `store path` which will be the only writeable path.
- input sources
- input derivations
- builder
- args
- environment

Builder + args + env (with already dependent derivations built) =>


Files loaded via paths become part of the store and dependencies.

```
nix show-derivation
```

Types of hash:
- content addressable (hashes based on the content of output files, better )
- extensionally address (addressed by their dependencies)

```
nix-instantiate # instantiate
+
nix-store --realize <derivation> # realized
```

or
```
nix-build { <derivation> | c.nix } # instantiate + realize
```

# Questions

- What is `self: super: `
- What is overlays
