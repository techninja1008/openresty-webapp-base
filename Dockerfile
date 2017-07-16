FROM openresty/openresty:xenial

# Various fixes to make lapis happy when installing
RUN apt update && \
    apt install -y libssl-dev git && \
    cd /tmp && \
    git clone https://github.com/openresty/lua-cjson && \
    cd lua-cjson && \
    luarocks make && \
    apt purge --autoremove -y git

RUN /usr/local/openresty/luajit/bin/luarocks install moonscript
RUN /usr/local/openresty/luajit/bin/luarocks install lapis

RUN mkdir /app

ADD nginx.conf mime.types /app/
ONBUILD ADD . /app/

ENTRYPOINT ["/usr/local/openresty/bin/openresty", "-c", "/app/nginx.conf", "-g", "daemon off;"] 
