# README

Use [this](https://github.com/astrada/google-drive-ocamlfuse).

Then:

```
crontab -e
```
And add: 
```
* * * * * /usr/bin/google-drive-ocamlfuse $HOME/shared/gdrive
```

