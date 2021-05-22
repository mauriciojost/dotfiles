https://www.youtube.com/watch?v=agzf6ftEsLU

- strongly typed
- tuples
- options
- structs
- concurrency
- pattern matching
- ...

https://play.rust-lang.org/

```rust
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
    //let dog2 = dog; // illegal, only one owner
    let dog2 = &dog; // borrowed
    go(cat);
    go(dog);
}
```
