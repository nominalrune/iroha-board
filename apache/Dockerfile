FROM ubuntu
LABEL version="0.1" name="iroha_board" author="nominalrune"
RUN apt-get update \
	&& apt-get install -y apt-utils \
	&& echo Asia/Tokyo > /etc/timezone \
	&& env DEBIAN_FRONTEND="noninteractive" apt-get install -y --no-install-recommends apache2 file \
	mysql-common mysql-client-core-8.0 \
	php7.4 php7.4-mbstring php7.4-pdo php7.4-mysqlnd \
	&& apt-get remove -y --purge apt-utils \
	&& apt-get -y autoremove \
	&& apt-get -y clean \
	&& rm -rf /var/lib/apt/lists/*
ENV APACHE_DOCUMENT_ROOT=/var/www/html \
	APACHE_RUN_DIR=/var/run/apache2 \
	PHP_INI_DIR=/etc/php/7.4/apache2
COPY ./apache2.conf /etc/apache2/apache2.conf
COPY ./envvars /etc/apache2/envvars
COPY ./php.ini /etc/php/7.4/apache2/php.ini
RUN . /etc/apache2/envvars \
	&& chown -R www-data /var/www/html \
	&& service apache2 restart
ENTRYPOINT ["/usr/sbin/apache2ctl", "-D", "FOREGROUND"]
