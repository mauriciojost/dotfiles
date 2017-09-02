# README 

This is my .dotfiles project. Your dotfiles are how you personalize your system. These are mine. Welcome!


## Getting started

Clone the project in ~/.dotfiles and then: 

```
$ git clone x ~/.dotfiles
$ cd ~/.dotfiles
$ ./install.sh

git submodule update --init --recursive
```

This will symlink the appropriate files in `.dotfiles` to your home directory.
Everything is configured and tweaked within `~/.dotfiles`.  The main file you'll want to change right off the bat is `modules/shell/bashrc.symlink`, which sets up a few paths that'll be different on your particular machine.

