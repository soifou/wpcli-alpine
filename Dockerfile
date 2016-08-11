FROM alpine:edge
MAINTAINER François Fleur <fleur.fr@gmail.com>

RUN apk add --no-cache --repository "http://dl-cdn.alpinelinux.org/alpine/edge/testing" \
    curl \
    less \
    mysql-client \
    php7 \
    php7-curl \
    php7-dom \
    php7-iconv \
    php7-json \
    php7-mbstring \
    php7-mysqli \
    php7-openssl \
    php7-pdo \
    php7-pdo_mysql \
    php7-phar \
    php7-posix \
    php7-zlib

RUN ln -s /etc/php7 /etc/php && \
    ln -s /usr/bin/php7 /usr/bin/php && \
    ln -s /usr/lib/php7 /usr/lib/php

COPY rootfs/ /

RUN mkdir /usr/local/share/php && cd /usr/local/share/php && \
    curl -sSfLJO https://raw.githubusercontent.com/wp-cli/builds/gh-pages/phar/wp-cli.phar && \
    chmod +x wp-cli.phar && \
    ln -s /usr/local/share/php/wp-cli.phar /usr/local/bin/wp

ENTRYPOINT ["wp", "--path=/mnt"]