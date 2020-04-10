# Notes

Algorithms:
- round robin
- least connected (based on served requests)
- source (same server for same ip address)
- sticky sessions (same server for same user)
- health check (based on availability)

Example:
- `vim /etc/haproxy/haproxy.cfg`
```
...
  frontend fe
          bind *:8080
          default_backend be
  backend be
          balance roundrobin
          server app1 127.0.0.1:8090 check
          server app2 127.0.0.1:8091 check
          server app3 127.0.0.1:8092 check
```


