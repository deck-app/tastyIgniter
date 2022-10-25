#!/bin/bash
set -e

if [ ! -e '/var/www/html/index.php' ]; then
	tar cf - --one-file-system -C /usr/src/tastyigniter . | tar xf - 2> /dev/null
	chown -R www-data:www-data /var/www/html  2> /dev/null
	HOST=`hostname`
    NAME=`echo $HOST | cut -c6-`
	echo $HOST
	echo $NAME
	sed -i "s/{DB_HOSTNAME}/$NAME/g" /var/www/html/system/tastyigniter/config/database.php
	
fi

exec "$@"
