# README

## Photo visualization & cleanup

### Linux

Use `nautilus` for browsing, or `rawtherapee` for photo opening.

To set up `nautilus` follow: 

https://gist.github.com/h4cc/13450db3d4a7457f9b38

```
sudo apt-get install gnome-raw-thumbnailer ufraw-batch
cp $HOME/.dotfiles/modules/photo/raw.thumbnailer /usr/share/thumbnailers/raw.thumbnailer
nautlius -q
rm -rf $HOME/.cache/thumbnails/* $HOME/.thumbnails/*
```

That's all!

## Photo backup (in Facebook)

Use `Album & Photo Manager for Facebook` Chrome plugin.
