# WP-CLI on Alpine Linux

WP-CLI baked from Composer build on top of Alpine Linux.

## Alias
- `1.1.0`, `latest` [(*Dockerfile*)](https://github.com/soifou/wpcli-alpine/blob/latest/Dockerfile) [![](https://images.microbadger.com/badges/image/soifou/wpcli-alpine:1.1.0.svg)](http://microbadger.com/images/soifou/wpcli-alpine "Get your own image badge on microbadger.com")
- `1.0.0` [(*Dockerfile*)](https://github.com/soifou/wpcli-alpine/blob/1.0.0/Dockerfile) [![](https://images.microbadger.com/badges/image/soifou/wpcli-alpine:1.0.0.svg)](http://microbadger.com/images/soifou/wpcli-alpine "Get your own image badge on microbadger.com")
- `0.25.0` [(*Dockerfile*)](https://github.com/soifou/wpcli-alpine/blob/0.25.0/Dockerfile) [![](https://images.microbadger.com/badges/image/soifou/wpcli-alpine:0.25.0.svg)](http://microbadger.com/images/soifou/wpcli-alpine "Get your own image badge on microbadger.com")

## Bash alias
You can create a bash alias ie:
```
function wp() {
    docker run -it --rm \
        -v $(pwd):/mnt \
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
Import/export database:
```
$ cd /path/to/wordpress/project
$ wp db import /mnt/dump.sql
```
Since the `--path` point inside the container, your dump must be available inside.