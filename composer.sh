#!/bin/sh

EXPECTED_SIGNATURE=$(curl https://composer.github.io/installer.sig)
php -r "copy('https://getcomposer.org/installer', 'composer-setup.php');"
ACTUAL_SIGNATURE=$(php -r "echo hash_file('SHA384', 'composer-setup.php');")

if [ "$EXPECTED_SIGNATURE" != "$ACTUAL_SIGNATURE" ]
then
    >&2 echo 'ERROR: Invalid installer signature'
    rm composer-setup.php
    exit 1
fi

php composer-setup.php --no-ansi --install-dir=/usr/bin --filename=composer --quiet --version=1.10.19
RESULT=$?
rm composer-setup.php
exit $RESULT
