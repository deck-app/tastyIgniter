FROM php:7.0-apache

# install the PHP extensions we need
RUN set -ex; \
	\
	apt-get update; \
	apt-get install -y \
		unzip \
		libcurl4-openssl-dev \
		libjpeg-dev \
		libpng-dev \
		libmcrypt-dev \
	; \
	rm -rf /var/lib/apt/lists/*; \
	\
	docker-php-ext-configure gd --with-png-dir=/usr --with-jpeg-dir=/usr; \
	docker-php-ext-install gd mcrypt mbstring mysqli opcache curl
# TODO consider removing the *-dev deps and only keeping the necessary lib* packages

# set recommended PHP.ini settings
# see https://secure.php.net/manual/en/opcache.installation.php
RUN { \
		echo 'opcache.memory_consumption=128'; \
		echo 'opcache.interned_strings_buffer=8'; \
		echo 'opcache.max_accelerated_files=4000'; \
		echo 'opcache.revalidate_freq=2'; \
		echo 'opcache.fast_shutdown=1'; \
		echo 'opcache.enable_cli=1'; \
	} > /usr/local/etc/php/conf.d/opcache-recommended.ini

RUN a2enmod rewrite

VOLUME /var/www/html

ENV TASTYIGNITER_VERSION 2.1.1

RUN set -ex; \
	curl -o tastyigniter.zip -fSL "https://codeload.github.com/tastyigniter/TastyIgniter/zip/${TASTYIGNITER_VERSION}"; \
	unzip tastyigniter.zip -d /usr/src/; \
	rm tastyigniter.zip; \
	mv /usr/src/TastyIgniter-${TASTYIGNITER_VERSION} /usr/src/tastyigniter; \
	chown -R www-data:www-data /usr/src/tastyigniter
COPY htaccess /usr/src/tastyigniter/setup/.htaccess
COPY database.php /usr/src/tastyigniter/system/tastyigniter/config/database.php
ARG DB_NAME
ARG DB_USER
ARG DB_PASSWORD
RUN sed -i "s#{DB_USER}#${DB_USER}#g" /usr/src/tastyigniter/system/tastyigniter/config/database.php
RUN sed -i "s#{DB_PASSWORD}#${DB_PASSWORD}#g" /usr/src/tastyigniter/system/tastyigniter/config/database.php
RUN sed -i "s#{DB_NAME}#${DB_NAME}#g" /usr/src/tastyigniter/system/tastyigniter/config/database.php

ARG USER_ID
ARG GROUP_ID
RUN usermod -u ${USER_ID} www-data && groupmod -g ${GROUP_ID} www-data

COPY docker-entrypoint.sh /usr/local/bin/entrypoint.sh
RUN chmod +x /usr/local/bin/entrypoint.sh

ENTRYPOINT ["entrypoint.sh"]
CMD ["apache2-foreground"]

