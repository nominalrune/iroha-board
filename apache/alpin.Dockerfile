FROM php:7.4-cli
LABEL version="0.1" name="iroha"
RUN apt-get update \
	&& apt-get -y install \
	libmemcached-dev zlib1g-dev \
	&& docker-php-source extract \
	&& docker-php-ext-install mbstring \
	&& docker-php-ext-install pdo \
	&& docker-php-ext-install podp_mysql \
	&& docker-php-source delete \
	&& apt-get -y remove libmemcached-dev zlib1g-dev \
	&& apt-get -y autoremove \
	&& apt-get -y clean \
	&& rm -rf /var/cache/apk/*
ENV APACHE_DOCUMENT_ROOT=/var/www/html \
	APACHE_RUN_DIR=/var/run/apache2 \
	PHP_INI_DIR=/etc/php/7.4/apache2
COPY ./apache2.conf /etc/apache2/apache2.conf
COPY ./envvars /etc/apache2/envvars
#COPY ./php.ini /etc/php/7.4/apache2/php.iniいらない可能性
RUN . /etc/apache2/envvars \
	&& service apache2 restart \
	&& chown -R www-data /var/www/html
ENTRYPOINT ["/usr/sbin/apache2ctl", "-D", "FOREGROUND"]