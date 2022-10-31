FROM php:8.1-apache  AS BASE
ENV PHP_IDE_CONFIG="serverName=localhost"

ENV APACHE_DOCUMENT_ROOT /var/www/docroot

# php.ini configs.
RUN mv "$PHP_INI_DIR/php.ini-development" "$PHP_INI_DIR/php.ini"
COPY ./local.ini "$PHP_INI_DIR/conf.d/local.ini"

RUN sed -ri -e 's!/var/www/html!${APACHE_DOCUMENT_ROOT}!g' /etc/apache2/sites-available/*.conf
RUN sed -ri -e 's!/var/www/!${APACHE_DOCUMENT_ROOT}!g' /etc/apache2/apache2.conf /etc/apache2/conf-available/*.conf

RUN a2enmod rewrite

# Install developer dependencies
RUN apt-get update -yqq && apt-get install -y vim wget git libsqlite3-dev nano libxml2-dev libicu-dev libfreetype6-dev libjpeg62-turbo-dev libpng-dev libcurl4-gnutls-dev libbz2-dev libssl-dev -yqq

ADD http://curl.haxx.se/ca/cacert.pem /usr/lib/ssl/certs/cacert.pem
RUN chmod 644 /usr/lib/ssl/certs/cacert.pem
RUN update-ca-certificates

RUN apt-get install -y imagemagick

# Install imagemagick.
RUN export CFLAGS="$PHP_CFLAGS" CPPFLAGS="$PHP_CPPFLAGS" LDFLAGS="$PHP_LDFLAGS" \
    && apt-get update \
    && apt-get install -y --no-install-recommends \
        libmagickwand-dev \
    && rm -rf /var/lib/apt/lists/* \
    && pecl install imagick \
    && docker-php-ext-enable imagick

RUN apt-get update && apt-get install -y libzip-dev

# Install other php extensions
RUN docker-php-ext-install sockets
RUN docker-php-ext-install mysqli
RUN docker-php-ext-install pdo_mysql
RUN docker-php-ext-install xml
RUN pecl install zip
RUN docker-php-ext-enable zip
RUN docker-php-ext-install bz2
RUN docker-php-ext-install curl

RUN docker-php-ext-configure gd --with-jpeg=/usr/include/ --with-freetype=/usr/include/
RUN docker-php-ext-install gd


RUN apt-get install -y mariadb-client

ADD ./composer.phar /usr/bin/composer
ADD https://github.com/drush-ops/drush-launcher/releases/latest/download/drush.phar /usr/bin/drush
RUN chmod +x \
    /usr/bin/composer \
    /usr/bin/drush

RUN apt-get install -y rsync
# RUN apt-get install -y inotify-tools


RUN mkdir /var/www/docroot \
    && chown -R www-data /var/www/docroot

RUN echo 'max_execution_time = 320' >> /usr/local/etc/php/conf.d/docker-php-maxexectime.ini;

WORKDIR /var/www/docroot

# Install xdebug for development
RUN pecl install xdebug \
    && docker-php-ext-enable xdebug

# Copy the configuration file into xdebug, if running phpinfo() you see the loaded file is not this one, change the path accordingly.
COPY ./xdebug.ini /usr/local/etc/php/conf.d/docker-php-ext-xdebug.ini

RUN echo 'max_execution_time = 320' >> /usr/local/etc/php/conf.d/docker-php-maxexectime.ini;
