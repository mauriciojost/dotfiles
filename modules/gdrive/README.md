# README

Use one of these:
- [drive](https://github.com/odeke-em/drive)
- [google-drive-ocamlfulse](https://github.com/astrada/google-drive-ocamlfuse).

# drive

```
cd $HOME/opt/zips
wget https://redirector.gvt1.com/edgedl/go/go1.9.2.linux-amd64.tar.gz
tar -xvzf go*.tar.gz
cd ..
ln -s zips/go* go

echo 'export GOROOT=$HOME/opt/go' >> ~/.localrc
echo 'export GOPATH=$HOME/opt/gopath' >> ~/.localrc
echo 'export PATH=$GOROOT:$GOROOT/bin:$GOPATH/bin:$PATH' >> ~/.localrc
go get -u github.com/odeke-em/drive/cmd/drive

drive init $HOME/shared/gdrive2
```


# google-drive-ocamlfuse

```
crontab -e
```
And add: 
```
* * * * * /usr/bin/google-drive-ocamlfuse $HOME/shared/gdrive
```

