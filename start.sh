#!/bin/bash

pkill openresty
pkill nginx
openresty

while true; do
    inotifywait -r -e modify,attrib,close_write,move,create,delete /usr/local/openresty/nginx/conf/*
    
    pkill openresty
    pkill nginx
    openresty
done

