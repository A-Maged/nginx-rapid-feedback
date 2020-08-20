#!/bin/bash

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

