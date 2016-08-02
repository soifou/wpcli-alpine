# WP-CLI on Alpine Linux


## Bash alias
You can create a bash alias like this:
```
function wp() {
    DOCKER_NETWORK_NAME="docker_default"
    WORDPRESS_DIR=$(pwd)
    docker run -it --rm \
        -v $WORDPRESS_DIR:/mnt \
        --net=$DOCKER_NETWORK_NAME \
        soifou/wpcli-alpine ${@:1}
}
```
Assuming docker network is `lamp-network`.
See your available networks with `docker network ls`

## Database operations
If you want import/export database, you can do something like this:
```
$ cd /path/to/wordpress/project
$ wp db import /mnt/dump.sql
```
Since the `--path` point inside the container, your dump must be available inside.