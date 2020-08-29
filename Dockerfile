FROM openresty/openresty:xenial

RUN apt-get update && \
    apt-get install inotify-tools -y && \
    apt-get install vim -y

# symlinks access.log and error.log to /dev/stdout and /dev/stderr
RUN ln -sf /dev/stdout /usr/local/openresty/nginx/logs/access.log \
    && ln -sf /dev/stderr /usr/local/openresty/nginx/logs/error.log

EXPOSE 80
EXPOSE 443

COPY start.sh /start.sh
RUN chmod +x /start.sh
CMD /start.sh