FROM wordpress:6.0.1-php8.1-fpm-alpine

COPY ./php/uploads.ini /usr/local/etc/php/conf.d

RUN chmod -R 755 /var/www/html/
RUN chown www-data:www-data -R /var/www/html/

VOLUME /var/www/html
