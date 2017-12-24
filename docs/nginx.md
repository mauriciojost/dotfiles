# Learning Nginx

keywords nginx http server redirect request forward proxy firewall open 

- Install nginx-full package
- Create a rule in the available rules directory
configure /etc/nginx/sites-available/afile
- Create a link in the enabled rules directory 
   $ ln -s /etc/nginx/sites-available/afile /etc/nginx/sites-enabled/afile
   $ service nginx restart

## About domains

One you bought a domain you can set up the resource records as folows:

**Custom resource records**

```
--------+------+-----+--------------
NAME    | TYPE | TTL | DATA
--------+------+-----+--------------
@       | A    | 1h  | 193.70.41.112
jenkins | A    | 1h  | 193.70.41.112
www     | A    | 1h  | 193.70.41.112
```

## Example of the configuration file

```
server {
    listen      80;
    location / {
        proxy_pass http://localhost:5050;
    }
    location /rm/ {
        proxy_pass http://localhost:8080;
    }
    location /scheduler/ {
        proxy_pass http://localhost:8080;
    }
    location /rest/ {
        proxy_pass http://localhost:9080/SchedulingRest/;
    }
    location /rm/rest/ {
        proxy_pass http://localhost:9080/SchedulingRest/rest/rm/;
    }
    location /scheduler/rest/ {
        proxy_pass http://localhost:9080/SchedulingRest/rest/scheduler/;
    }
}

```


## Make a rebound machine

```
# port 8000 directs to https://api2.numergy.com/
server {
        listen 8000;
        location / {
                proxy_pass https://api2.numergy.com/;
        }
}

```

## Make an HTTPS rebound machine (even locally)

Description: this document explains how to set up NGINX in a rebond host so that api2.numergy.com can be accessed from VMs in Numergy infrastrucutre (which is not the case by default…)

1. Open HTTPS port

Close endpoint port TCP:8080 (or whichever HTTP you want to disable, as now you will have http)
Open endpoint port TCP:443 (or whichever HTTPS you want to enable from now on)

2. Create credentials for HTTPS host

```
sudo mkdir /etc/nginx/ssl
cd /etc/nginx/ssl
sudo openssl genrsa -des3 -out server.key 1024
sudo openssl req -new -key server.key -out server.csr
sudo cp server.key server.key.org
sudo openssl rsa -in server.key.org -out server.key
sudo openssl x509 -req -days 365 -in server.csr -signkey server.key -out server.crt
```

3. Configure nginx

```
sudo vim /etc/nginx/sites-available/https

```

Add this: 

```
# HTTPS server
server {
        listen 443;
        server_name localhost;
        ssl on;
        ssl_certificate /etc/nginx/ssl/server.crt;
        ssl_certificate_key /etc/nginx/ssl/server.key;
        location / {
                proxy_pass http://localhost:8080/;
        }
}

```
4. Enable the site and restart nginx
 
```
cd /etc/nginx/sites-enabled
ln -s /etc/nginx/sites-available/https https
service nginx restart
```

5. Test locally by comparing the output of

```
curl http://localhost
curl -k https://localhost
```



