FROM php:7.4-fpm-alpine

WORKDIR /var/www/html/

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
    && apk add --no-cache nginx \
    && apk del --no-cache \
        freetype-dev \
        libjpeg-turbo-dev \
        libpng-dev \
        libzip-dev \
    && rm -rf /tmp/*

COPY src/index.php /var/www/html
COPY nginx.conf /etc/nginx/nginx.conf
COPY . .
RUN rm -rf /tmp/* /var/cache/apk/*
EXPOSE 80
CMD ["nginx", "-g", "daemon off;"]
