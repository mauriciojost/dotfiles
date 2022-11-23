# README

## Install IdeaVim 

1. Install IdeaVim plugin on Intellij.
3. After closing Intellij, copy the provided `keymaps/*.xml` into `$HOME/.IdeaXXX/config/keymaps/` or `$HOME/.config/JetBrains/IdeaICXXXX.Y/keymaps` (as per [this](https://www.jetbrains.com/help/idea/configuring-keyboard-and-mouse-shortcuts.html#54eb49dd))
4. Restart Intellij for the keymap to be available, and choose (Ctrl-Alt-S)

For information: there are keymaps that may conflict between Intellij and the Vim plugin, you can see them with `Settings -> Editor -> Vim -> ...`. However they should be automatically configured thanks to `$HOME/.ideavimrc`.

You should have a very good keymap working ;)

## Use reniced

This app lets set up the `nice` number and `ionice` number automatically for IntelliJ related processes.

```
# apt-get install reniced
# cat reniced/reniced.conf >> /etc/reniced.conf
# service reniced start

```

Then add to CronTab via `crontab -e` the following: 

```
* * * * * /usr/sbin/service reniced start
```
