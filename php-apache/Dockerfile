FROM php:8.1-rc-apache

RUN apt update -yqq && apt install -yqq \
    git \
    wget \
    zip \
    unzip \
    vim \
    msmtp msmtp-mta \
    default-mysql-server \
    graphviz \
    && echo 'mysql-server mysql-server/root_password password pass' | debconf-set-selections \
    && echo 'mysql-server mysql-server/root_password_again password pass' | debconf-set-selections \
    && apt-get clean \
    && rm -rf /var/lib/apt/lists/* \
    && docker-php-ext-install pdo_mysql opcache

RUN git clone https://github.com/tideways/php-xhprof-extension.git \
    && cd php-xhprof-extension \
    && phpize \
    && ./configure \
    && make \
    && make install

COPY --from=composer /usr/bin/composer /usr/bin/composer

COPY ./apache2/sites-available/*.conf /etc/apache2/sites-available/

RUN a2enmod rewrite \
    && a2enmod ssl \
    && a2ensite default-ssl \
    && a2ensite vhost \
    && usermod -u 1000 www-data \
    && chown -R www-data:www-data /var/www
