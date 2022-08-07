# README

Download x.run from https://developers.hp.com/hp-linux-imaging-and-printing/gethplip for Debian and install it (something like `hplip-3.22.6-plugin.run`).
Ensure python is not from Nix :D
This step will also setup your printer.

Then you will need to install `the` plugin (something like `hplip-3.22.6-plugin.run`).

Then use [this documentation](https://www.systutorials.com/docs/linux/man/1-hp-scan/).

```
scanimage -L
hp-scan -dhpaio:/net/HP_LaserJet_Pro_MFP_M125nw?hostname=DEVC2859F.local -i --mode=gray
```

