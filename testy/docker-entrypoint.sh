#!/bin/bash
set -e

if [ ! -e '/var/www/html/index.php' ]; then
	tar cf - --one-file-system -C /usr/src/tastyigniter . | tar xf -
	chown -R www-data /var/www/html
	HOST=`hostname`
    NAME=`echo $HOST | cut -c5-`

	if [ -n "${NAME}" ]; then
		sed -i -e "s/localhost/$NAME/g" /var/www/html/system/tastyigniter/config/database.php
		sed -i -e "s/your database username/$MARIADB_USER/g" /var/www/html/system/tastyigniter/config/database.php
		sed -i -e "s/your database password/$MARIADB_PASSWORD/g" /var/www/html/system/tastyigniter/config/database.php
		sed -i -e "s/your database name/$MARIADB_DATABASE/g" /var/www/html/system/tastyigniter/config/database.php
	fi
fi

exec "$@"
