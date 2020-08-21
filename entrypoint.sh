#!/bin/bash

groupadd www
usermod -a -G www ubuntu

mkdir /etc/resty-auto-ssl

openssl req -new -newkey rsa:2048 -days 3650 -nodes -x509 \
  -subj '/CN=sni-support-required-for-valid-ssl' \
  -keyout /etc/ssl/resty-auto-ssl-fallback.key \
  -out /etc/ssl/resty-auto-ssl-fallback.crt

chmod -R 777 /etc/resty-auto-ssl 
chmod -R 777 /usr/local/openresty
chmod -R 777 /etc/ssl/

pkill openresty
pkill nginx
openresty -c /home/conf/nginx.conf

# while :; do :; done & kill -STOP $! && wait $!

while true; do
    inotifywait -r -e modify,attrib,close_write,move,create,delete /home/conf/nginx.conf
    
    pkill openresty
    pkill nginx
    openresty -c /home/conf/nginx.conf
done

