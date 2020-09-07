FROM ubuntu
LABEL version="0.1" name="iroha"
RUN export DEBIAN_FRONTEND="noninteractive" \
	&& apt-get update \
	&& apt-get install -y --no-install-recommends\
	apt-utils \
	apache2 \
	php php-mbstring libapache2-mod-php7.4 php-mysql \
	&& apt-get clean \
	&& apt-get remove -y --purge apt-utils \
	&& apt-get -y autoremove \
	&& rm -rf /var/lib/apt/lists/* \
	&& export DEBIAN_FRONTEND="interactive"
#ここのnointeracttiveも外したい。（パイプで質問に答える 6. Asia  ）
ENV APACHE_DOCUMENT_ROOT=/var/www/html \
	APACHE_RUN_DIR=/var/run/apache2 
#\
#PHP_INI_DIR=/etc/php/7.4/apache2
COPY ./apache2.conf /etc/apache2/apache2.conf
COPY ./envvars /etc/apache2/envvars
#COPY ./php.ini /etc/php/7.4/apache2/php.iniいらない可能性
RUN . /etc/apache2/envvars \
	&& service apache2 restart \
	&& chown -R www-data /var/www/html
ENTRYPOINT ["/usr/sbin/apache2ctl", "-D", "FOREGROUND"]