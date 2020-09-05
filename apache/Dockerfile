FROM ubuntu
LABEL version="0.1" name="iroha"
#ここのnointeracttiveも外したい。（パイプで質問に答える 6. Asia  ）..というか、update二回走っている。
RUN DEBIAN_FRONTEND=noninteractive \
	apt-get update \
	&& apt-get -y update \
	&& apt-get -y install \
	zlib1g-dev apache2 \
	php php-mbstring libapache2-mod-php7.4 \
	mysql-client php-mysql
ENV APACHE_DOCUMENT_ROOT=/var/www/html \
	APACHE_RUN_DIR=/var/run/apache2 \
	PHP_INI_DIR=/etc/php/7.4/apache2
COPY ./apache2.conf /etc/apache2/apache2.conf
COPY ./envvars /etc/apache2/envvars
COPY ./php.ini /etc/php/7.4/apache2/php.ini
RUN . /etc/apache2/envvars
ENV APACHE_RUN_USER=www-data \ 
#明日、この部分外してみる。
	APACHE_RUN_GROUP=www-data \
	APACHE_PID_FILE=/var/run/apache2/apache2.pid \
	APACHE_RUN_DIR=/var/run/apache2 \
	APACHE_LOCK_DIR=/var/lock/apache2 \
	APACHE_LOG_DIR=/var/log/apache2 \
	LANG=C
RUN chown -R www-data /var/www/
ENTRYPOINT ["/usr/sbin/apache2ctl", "-D", "FOREGROUND"]