FROM php:8.3-rc-apache

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
    && rm -rf /var/lib/apt/lists/*

COPY --from=mlocati/php-extension-installer /usr/bin/install-php-extensions /usr/local/bin/
RUN install-php-extensions @composer xdebug opcache bcmath pdo_mysql redis
RUN  echo "xdebug.mode=debug" >> /usr/local/etc/php/conf.d/docker-php-ext-xdebug.ini \
    && echo "xdebug.client_host = host.docker.internal" >> /usr/local/etc/php/conf.d/docker-php-ext-xdebug.ini

COPY ./php.ini /usr/local/etc/php/php.ini
COPY ./apache2/sites-available/*.conf /etc/apache2/sites-available/
COPY ./apache2/ssl /etc/apache2/ssl
COPY ./msmtprc /etc/msmtprc

RUN a2enmod rewrite \
    && a2enmod ssl \
    && a2ensite default-ssl \
    && a2ensite vhost \
    && usermod -u 1000 www-data \
    && chown -R www-data:www-data /var/www
