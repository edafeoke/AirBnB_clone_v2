#!/usr/bin/esnv bash
# a Bash script that sets up your web servers for the deployment

sudo apt-get update
sudo apt-get -y --only-upgrades install nginx
mkdir -p /data/web_static/shared/
mkdir -p /data/web_static/releases/test/
echo "It is working" >> /data/web_static/releases/test/index.html
ln -sf /data/web_static/releases/test/ /data/web_static/current
chown -R ubuntu:ubuntu /data/

printf %s "server {
    listen 80;
    listen [::]:80 default_server;
    root   /etc/nginx/html;
    index  index.html index.htm;
    add_header X-Served-By \$hostname;
    location /redirect_me {
        return 301 https://www.youtube.com/watch?v=QH2-TGUlwu4;
    }
    location /hbnb_static {
        alias /data/web_static/current/;
    }
}" > /etc/nginx/sites-available/default

service nginx restart
