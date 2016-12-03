Learning Nginx

keywords nginx http server redirect request forward proxy firewall open 

# Install nginx-full package
# Create a rule in the available rules directory
configure /etc/nginx/sites-available/afile
# Create a link in the enabled rules directory 
   $ ln -s /etc/nginx/sites-available/afile /etc/nginx/sites-enabled/afile
   $ service nginx restart


# An example of the configuration file: 

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



Make a rebound machine (you contact it and actually you’re contacting a 3rd one) 

# port 8000 directs to https://api2.numergy.com/
server {
        listen 8000;
        location / {
                proxy_pass https://api2.numergy.com/;
        }
}


HTTPS rebound machine: 

Description: this document explains how to set up NGINX in a rebond host so that api2.numergy.com can be accessed from VMs in Numergy infrastrucutre (which is not the case by default…)

1. Open HTTPS port

Open VM endpoint TCP:443

2. Create credentials for HTTPS host

sudo mkdir /etc/nginx/ssl
cd /etc/nginx/ssl
sudo openssl genrsa -des3 -out server.key 1024
sudo openssl req -new -key server.key -out server.csr
sudo cp server.key server.key.org
sudo openssl rsa -in server.key.org -out server.key
sudo openssl x509 -req -days 365 -in server.csr -signkey server.key -out server.crt

3. Configure nginx

sudo vim /etc/nginx/sites-available/example

# HTTPS server
server {
        listen 443;
        server_name localhost;
        ssl on;
        ssl_certificate /etc/nginx/ssl/server.crt;
        ssl_certificate_key /etc/nginx/ssl/server.key;
        location / {
                proxy_pass https://api2.numergy.com/;
        }
}

4. Restart nginx
 
service nginx restart

5. Test locally by comparing the output of

curl https://api2.numergy.com | python -mjson.tool
curl -k https://localhost | python -mjson.tool

5. Test remotelly by comparing the output of

curl https://api2.numergy.com | python -mjson.tool
curl -k https://109.24.132.213 | python -mjson.tool




