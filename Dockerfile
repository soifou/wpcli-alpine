FROM soifou/composer:latest

MAINTAINER François Fleur <fleur.fr@gmail.com>

ARG BUILD_DATE
ARG VCS_REF
LABEL org.label-schema.build-date=$BUILD_DATE \
    org.label-schema.name="WP-CLI baked with Composer on top of Alpine Linux" \
    org.label-schema.vcs-ref=$VCS_REF \
    org.label-schema.docker.dockerfile="/Dockerfile" \
    org.label-schema.vcs-url="https://github.com/soifou/wpcli-alpine"

ENV WP_CLI_VERSION 1.1.0

RUN apk add --no-cache --repository "http://dl-cdn.alpinelinux.org/alpine/edge/testing" \
    bash \
    curl \
    less \
    freetype-dev libjpeg-turbo-dev libpng-dev \
    mariadb-client \
    php7-gd \
    php7-mysqli \
    php7-mongodb

RUN rm -rf /tmp/src && \
    rm -rf /var/cache/apk/*

RUN composer create-project wp-cli/wp-cli:$WP_CLI_VERSION /usr/share/wp-cli --no-dev
RUN ln -s /usr/share/wp-cli/bin/wp /usr/bin/wp

ENTRYPOINT ["/usr/bin/wp", "--allow-root", "--path=/mnt"]