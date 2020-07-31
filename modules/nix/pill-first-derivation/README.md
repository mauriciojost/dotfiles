# README

From [here](https://nixos.org/nixos/nix-pills/working-derivation.html).



## With nix-repl

In the nix-repl: 
```
:l <nixpkgs>
simple = derivation { name = "simple"; builder = "${bash}/bin/bash"; args = [ ./simple_builder.sh ]; gcc = gcc; coreutils = coreutils; src = ./simple.c; system = builtins.currentSystem; }
:b simple
```

Literally from the pill:

```
We added two new attributes to the derivation call, gcc and coreutils. In gcc = gcc;, the name on the left is the name in the derivation set, and the name on the right refers to the gcc derivation from nixpkgs. The same applies for coreutils.

We also added the src attribute, nothing magical - it's just a name, to which the path ./simple.c is assigned. Like simple-builder.sh, simple.c will be added to the store.

The trick: every attribute in the set passed to derivation will be converted to a string and passed to the builder as an environment variable. This is how the builder gains access to coreutils and gcc: when converted to strings, the derivations evaluate to their output paths, and appending /bin to these leads us to their binaries.

The same goes for the src variable. $src is the path to simple.c in the nix store. As an exercise, pretty print the .drv file. You'll see simple_builder.sh and simple.c listed in the input derivations, along with bash, gcc and coreutils .drv files. The newly added environment variables described above will also appear.

In simple_builder.sh we set the PATH for gcc and coreutils binaries, so that our build script can find the necessary utilities like mkdir and gcc.

We then create $out as a directory and place the binary inside it. Note that gcc is found via the PATH environment variable, but it could equivalently be referenced explicitly using $gcc/bin/gcc.
```

## With .nix

```
with (import <nixpkgs> {});
derivation {
  name = "simple";
  builder = "${bash}/bin/bash";
  args = [ ./simple_builder.sh ];
  inherit gcc coreutils;
  src = ./simple.c;
  system = builtins.currentSystem;
}
```

and run

```
nix-build simple.nix
```
