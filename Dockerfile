FROM openresty/openresty:xenial

RUN /usr/local/openresty/luajit/bin/luarocks install moonscript
RUN /usr/local/openresty/luajit/bin/luarocks install lapis

RUN mkdir /app

ADD nginx.conf /app/
ONBUILD ADD . /app/

ENTRYPOINT /usr/local/openresty/bin/openresty -c /app/nginx.conf
