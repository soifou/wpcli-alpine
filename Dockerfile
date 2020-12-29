FROM alpine:3.9

ARG BUILD_DATE
ARG VCS_REF
LABEL org.label-schema.build-date=$BUILD_DATE \
    org.label-schema.name="WP-CLI baked with Composer on top of Alpine Linux" \
    org.label-schema.vcs-ref=$VCS_REF \
    org.label-schema.docker.dockerfile="/Dockerfile" \
    org.label-schema.vcs-url="https://github.com/soifou/wpcli-alpine"

ENV WP_CLI_VERSION 1.5.1

ADD https://dl.bintray.com/php-alpine/key/php-alpine.rsa.pub /etc/apk/keys/php-alpine.rsa.pub

RUN echo "https://dl.bintray.com/php-alpine/v3.9/php-7.3" >> /etc/apk/repositories && \
    apk add --update --no-cache \
    bash \
    curl \
    less \
    freetype-dev libjpeg-turbo-dev libpng-dev \
    mariadb-client \
    php7 \
    php7-dom \
    php7-ftp \
    php7-gd \
    php7-openssl \
    php7-phar \
    php7-iconv \
    php7-mbstring \
    php7-mongodb \
    php7-mysqli \
    php7-zlib

RUN ln -sf /usr/bin/php7 /usr/bin/php

ADD ./composer.sh /composer.sh
RUN chmod u+x /composer.sh; sync && /composer.sh

RUN rm -rf /tmp/src && \
    rm -f /composer.sh \
    rm -rf /var/cache/apk/*

RUN composer create-project wp-cli/wp-cli:$WP_CLI_VERSION /usr/share/wp-cli --no-dev && \
    composer clear-cache

RUN ln -s /usr/share/wp-cli/bin/wp /usr/bin/wp

ENTRYPOINT ["/usr/bin/wp", "--allow-root", "--path=/mnt"]
