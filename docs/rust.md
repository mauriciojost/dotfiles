# RUST

## LLVM
https://www.llvm.org/
Has nothing to do with VMs.
The LLVM Project is a collection of modular and reusable compiler and toolchain technologies. 
The LLVM Core libraries provide a modern source- and target-independent optimizer, along with code generation support for many popular CPUs.
Clang is an "LLVM native" C/C++/Objective-C compiler, which aims to deliver amazingly fast compiles, extremely useful error and warning messages and to provide a platform for building great source level tools

The tool `bindgen` uses CLANG. Indeed parameters passed after -- are for CLANG; it probably generates code for the provided target, then `bindgen` probably takes it and generates Rust headers from that.

## RUSTC

If installed directly with rustup no target `xtensa` available:

```
mjost@lapin:~/persospace/xtensa-rust-quickstart (mytest) $ bash flash-esp8266
error: cargo metadata invocation failed: Error during execution of `cargo metadata`: error: failed to run `rustc` to learn about target-specific information

Caused by:
  process didn't exit successfully: `rustc - --crate-name ___ --print=file-names -C link-arg=-Wl,-Tlink.x -C link-arg=-nostartfiles --target xtensa-esp32-none-elf --crate-type bin --crate-type rlib --crate-type dylib --crate-type cdylib --crate-type staticlib --crate-type proc-macro --print=sysroot --print=cfg` (exit code: 1)
  --- stderr
  error: Error loading target specification: Could not find specification for target "xtensa-esp32-none-elf". Use `--print target-list` for a list of built-in targets
```

However if installed a la `xtensa-rust-quickstart` (`rust-xtensa`) all worked fine, reminder of instructions (from xtensa-rust-quickstart): 

```
$ sudo apt-get install cargo
$ cargo install cargo-xbuild
$ cargo install cargo-espflash
$ git clone https://github.com/MabezDev/rust-xtensa
$ cd rust-xtensa
$ ./configure --experimental-targets=Xtensa
$ ./x.py build --stage 2

# to check if the above is up-to-date with the README

and then use xtensa-rust-quickstart/setenv to set some environment varialbes like XARGO_RUST_SRC RUSTC so that the new project builds using the above compiled rust (containing the xtensa target)

```

The builds above in `rust-xtensa` create several binaries to be used, they are under:

```
rust-xtensa/build/x86_64-unknown-linux-gnu/stage0/bin/{cargo,rustc,rustdoc,rust-gdb,rust-gdbgui,rust-lldb}
#and
rust-xtensa/build/x86_64-unknown-linux-gnu/stage2/bin/{rustc,rustdoc}
```
. 
We need the `xtensa` target provided by `stage2/bin/rustc` (the target is named `x86_64-unknown-linux-gnu`), so we need to use the rustc provided after this build (and not the one provided by rustup).

### Notes

To see the targets available for rustc do: 

```
rustc --print target-list
```

## Material
- [Book](https://doc.rust-lang.org/book/title-page.html)
- [Video 1](https://www.youtube.com/watch?v=agzf6ftEsLU)

## Features
- strongly typed
- tuples
- options
- structs
- concurrency
- pattern matching
- ...

## To play

https://play.rust-lang.org/

## Examples

```rust
// borrowing
fn main() {
    let number = 1
    //let number2 = number; // illegal, only one owner
    {
        let number2 = &number; // can be borrowed within this scope
    }
}
```

```rust
// scala-like pattern matching
enum Animal {
  Dog { name: String,  age: i8 },
  Cat { name: String,  age: i8 }
}

fn go(a: Animal) {
    match a {
        Animal::Dog {name, age} => {
            println!("Dog: {} {}", name, age);
        }
        Animal::Cat {name, age} => {
            println!("Cat: {} {}", name, age);
        }
    }
}
fn main() {
    let cat: Animal = Animal::Cat {name: "miau".to_string(), age: 2};
    let dog: Animal = Animal::Dog {name: "bau".to_string(), age: 1};
    go(cat);
    go(dog);
}
```

# RUST FOR ARDUINO

## Example

Get started [here](https://github.com/mauriciojost/platformio-arduino-rust).

```
curl --proto '=https' --tlsv1.2 -sSf https://sh.rustup.rs | sh
cargo install bindgen
# also install platformio
```
