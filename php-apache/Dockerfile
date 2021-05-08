FROM php:8.0.3-apache

RUN apt update -yqq && apt install -yqq \
    git \
    wget \
    zip \
    unzip \
    vim \
    msmtp msmtp-mta \
    default-mysql-server \
    && echo 'mysql-server mysql-server/root_password password pass' | debconf-set-selections \
    && echo 'mysql-server mysql-server/root_password_again password pass' | debconf-set-selections \
    && apt-get clean \
    && rm -rf /var/lib/apt/lists/* \
    && docker-php-ext-install pdo_mysql opcache

COPY --from=composer /usr/bin/composer /usr/bin/composer

COPY ./apache2/sites-available/*.conf /etc/apache2/sites-available/

RUN a2enmod rewrite \
    && a2ensite vhost \
    && usermod -u 1000 www-data \
    && chown -R www-data:www-data /var/www
