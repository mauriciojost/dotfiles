# README

## Install IdeaVim 

1. Install IdeaVim plugin on Intellij.
3. After closing Intellij, copy the provided `keymaps/*.xml` into `$HOME/.IdeaXXX/config/keymaps/`
5. Restart Intellij.

Then you should have a very good keymap working ;)

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
