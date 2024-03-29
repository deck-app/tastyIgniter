#!/bin/bash
set +x

if [ ! -e '/var/www/html/index.php' ]; then
	echo >&2 "Tastyigniter not found in $(pwd) ..."
	tar cf - --one-file-system -C /usr/src/tastyigniter . | tar xf - 2> /dev/null
	chown -R www-data:www-data /var/www/html  2> /dev/null
	HOST=`hostname`
    NAME=`echo $HOST | cut -c7-`
	sed -i "s/{DB_HOSTNAME}/$NAME/g" /var/www/html/system/tastyigniter/config/database.php
	echo "Application installed successfully"
fi

exec "$@"
