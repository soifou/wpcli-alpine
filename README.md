# WP-CLI on Alpine Linux

[WP-CLI](http://wp-cli.org/) baked from [PHP Composer](https://getcomposer.org/) build on top of [Alpine Linux](https://alpinelinux.org/).

## Alias
- `1.4.0`, `latest` [(*Dockerfile*)](https://github.com/soifou/wpcli-alpine/blob/master/Dockerfile) [![](https://images.microbadger.com/badges/image/soifou/wpcli-alpine:1.4.0.svg)](http://microbadger.com/images/soifou/wpcli-alpine "Get your own image badge on microbadger.com")
- `1.3.0` [(*Dockerfile*)](https://github.com/soifou/wpcli-alpine/blob/1.3.0/Dockerfile) [![](https://images.microbadger.com/badges/image/soifou/wpcli-alpine:1.3.0.svg)](http://microbadger.com/images/soifou/wpcli-alpine "Get your own image badge on microbadger.com")
- `1.1.0` [(*Dockerfile*)](https://github.com/soifou/wpcli-alpine/blob/1.1.0/Dockerfile) [![](https://images.microbadger.com/badges/image/soifou/wpcli-alpine:1.1.0.svg)](http://microbadger.com/images/soifou/wpcli-alpine "Get your own image badge on microbadger.com")
- `1.0.0` [(*Dockerfile*)](https://github.com/soifou/wpcli-alpine/blob/1.0.0/Dockerfile) [![](https://images.microbadger.com/badges/image/soifou/wpcli-alpine:1.0.0.svg)](http://microbadger.com/images/soifou/wpcli-alpine "Get your own image badge on microbadger.com")
- `0.25.0` [(*Dockerfile*)](https://github.com/soifou/wpcli-alpine/blob/0.25.0/Dockerfile) [![](https://images.microbadger.com/badges/image/soifou/wpcli-alpine:0.25.0.svg)](http://microbadger.com/images/soifou/wpcli-alpine "Get your own image badge on microbadger.com")

## Bash alias
Minimal:
```
wp() {
    docker run -it --rm \
        -v $(pwd):/mnt \
        soifou/wpcli-alpine:latest ${@:1}
}
```
Bells and whistles:
```
wp() {
    tty=
    tty -s && tty=--tty
    docker run \
        $tty \
        --interactive \
        --rm \
        -v $(pwd):/mnt \
        -u `id -u`:`id -g` \
        --net=my-network \
        soifou/wpcli-alpine:latest ${@:1}
}
```

## Create a wordpress project
```
$ mkdir wp-test && cd wp-test
$ wp core download
$ wp core config --dbhost=db --dbname=wptest --dbuser=root --dbpass=root
$ wp core install \
    --url=http://wp-test \
    --title="Awesome website" \
    --admin_user=admin --admin_password=admin --admin_email admin@admin.com
```

## Database operations

Since the `--path` point inside the container, your dump must be available inside.

```
$ cd /path/to/wordpress/project
$ wp db dump /mnt/dump.sql
$ wp db import /mnt/dump.sql
```