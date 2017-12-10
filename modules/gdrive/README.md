# README

Use one of these:
- [drive](https://github.com/odeke-em/drive)
- [google-drive-ocamlfulse](https://github.com/astrada/google-drive-ocamlfuse).

Then (if ocamlfuse):

```
crontab -e
```
And add: 
```
* * * * * /usr/bin/google-drive-ocamlfuse $HOME/shared/gdrive
```

