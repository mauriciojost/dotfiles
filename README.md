# README 

This is my `.dotfiles` project. 

Your dotfiles define how you personalize your system. 

It is tuned for Ubuntu Linux with XFCE on it / Xubuntu distro.

I conceived it for: 
- helping me with commands (and its flags) I often find useful via aliases / functions
- keeping in hand code snippets I often forget
- settings of window manager that suit daily life and work (task oriented using workspaces)
- providing at hand topics
    - create in a single command a dated Scrum daily report, with a template
    - same way create a Scrum retrospective document
    - same way create meeting minutes document
- relies on Ulauncher for quick application starts
    - can launch commands or aliases from it
    - can be easily customized to open predefined pre-filled URLs
- named workspace oriented window manager
    - workspace name can be easily modified with a few keystrokes
    - workspace name is part of command history
- and more!

It's look in a glance: 

![Look](README.look.png)

Use of `fzf` tool:

![FZF](docs/img/dotfile.fzf.dir.gif)

## Getting started

```
git clone https://github.com/mauriciojost/dotfiles.git
mv dotfiles $HOME/.dotfiles
cd $HOME/.dotfiles
./install.sh
```
All files in this repo whose name ends in `.symlink` will be symlinked to `$HOME`. All 
the files whose name ends in `.configlink` will be symlinked to `$HOME/.config/` .

# References

See [these slides](https://mauriciojost.github.io/2017/10/23/dotfiles/presentation.html).
