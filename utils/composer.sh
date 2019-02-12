#!/usr/bin/env bash

docker exec -it laravel-php-fpm /bin/bash -c "composer install --prefer-source --no-interaction --no-plugins --no-scripts"
