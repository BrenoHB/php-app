FROM php:7.4-fpm-alpine

WORKDIR /var/www/html

# Instalação de dependências e extensões PHP
RUN apk --no-cache add \
        freetype \
        libjpeg-turbo \
        libpng \
        freetype-dev \
        libjpeg-turbo-dev \
        libpng-dev \
        libzip-dev \
    && docker-php-ext-configure gd \
        --with-freetype=/usr/include/ \
        --with-jpeg=/usr/include/ \
    && docker-php-ext-install -j$(nproc) gd pdo pdo_mysql zip bcmath \
    && apk del --no-cache \
        freetype-dev \
        libjpeg-turbo-dev \
        libpng-dev \
        libzip-dev \
    && rm -rf /tmp/*
