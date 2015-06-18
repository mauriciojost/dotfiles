# README

From [here](http://www.splitbrain.org/blog/2014-03/08-lenovo_thinkpad_x240_xubuntu).

Instead of relying on Ubuntu's standard power management I decided to install TLP.

- First I disabled Ubuntu's power governor:

```
sudo update-rc.d -f ondemand remove
```

- Then installed the tool and dependencies:

```
sudo add-apt-repository ppa:linrunner/tlp
sudo apt-get update
sudo apt-get install tlp tp-smapi-dkms acpi-call
```

TLP is well working without any configuration, but I changed a few things in its config anyway. The configuration file is:

```
/etc/default/tlp
```

and the changes are:

```
CPU_SCALING_GOVERNOR_ON_AC=ondemand
CPU_SCALING_GOVERNOR_ON_BAT=ondemand
CPU_BOOST_ON_AC=1
CPU_BOOST_ON_BAT=0
SATA_LINKPWR_ON_BAT=medium_power
```

These might be the defaults and commenting them in might be unnecessary. I'm not sure. The last option is a recommendation for some ThinkPads and might not be needed for the X240, but it won't hurt.
