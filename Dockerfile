FROM ubuntu:18.04

RUN apt-get update && \
    apt-get -y install software-properties-common wget && \
    wget -qO - https://openresty.org/package/pubkey.gpg | apt-key add - && \
    add-apt-repository -y "deb http://openresty.org/package/ubuntu $(lsb_release -sc) main" && \
    apt-get update -y && \
    apt-get install openresty -y && \
    apt-get install inotify-tools -y && \
    apt-get install -y luarocks && \
    apt-get install vim -y

Run luarocks install lua-resty-auto-ssl

# symlinks access.log and error.log to /dev/stdout and /dev/stderr
RUN ln -sf /dev/stdout /usr/local/openresty/nginx/logs/access.log \
    && ln -sf /dev/stderr /usr/local/openresty/nginx/logs/error.log

EXPOSE 80

COPY "entrypoint.sh" "/home/entrypoint.sh"

ENTRYPOINT "/home/entrypoint.sh"