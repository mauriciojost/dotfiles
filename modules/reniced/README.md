# README

1. Copy the .conf file to /etc/
2. Ensure reniced is installed
3. Add this to `crontab -e` for `root` user

```
* * * * * /usr/sbin/service reniced restart
```
