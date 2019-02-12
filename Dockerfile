FROM php:7.2-fpm

RUN apt-get update -y && apt-get install -y \
    openssl \
    zip \
    unzip \
    git \
    libxml2-dev

RUN docker-php-ext-install pdo_mysql mbstring opcache xml

RUN curl -sS https://getcomposer.org/installer | php -- --install-dir=/usr/local/bin --filename=composer

RUN composer install --prefer-source --no-interaction --no-plugins --no-scripts

COPY . /var/www/html
COPY ./utils/tasks.sh /usr/local/bin/laravel-tasks
COPY ./utils/queues.sh /usr/local/bin/laravel-queues

RUN chmod -R 775 /var/www/html/storage
RUN chown -R www-data:www-data /var/www/html
RUN chmod u+x /usr/local/bin/laravel-tasks
RUN chmod u+x /usr/local/bin/laravel-queues

WORKDIR /var/www/html
