# README: create an HTTP proxy

Install tool `squid`.
Then configure /etc/squid3/squid.conf
```
http_access deny all 
```

to 

```
http_access allow all
```

That's all!
