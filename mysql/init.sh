#!/bin/bash

TEMP_FILE='/tmp/mysql-first-time.sql'

MYSQL_OIC_PASSWORD=${MYSQL_OIC_PASSWORD:-"oic"}

echo "CREATE USER 'oic'@'%' IDENTIFIED WITH mysql_native_password BY '${MYSQL_OIC_PASSWORD}' ;" >> "$TEMP_FILE"
echo "CREATE DATABASE IF NOT EXISTS oic DEFAULT CHARACTER SET 'utf8' COLLATE 'utf8_unicode_ci';" >> "$TEMP_FILE"
echo "GRANT ALL PRIVILEGES ON oic.* TO 'oic'@'%' ;" >> "$TEMP_FILE"
echo "GRANT ALL ON *.* TO 'oic'@'%' WITH GRANT OPTION ;" >> "$TEMP_FILE"
echo "FLUSH PRIVILEGES ;" >> "$TEMP_FILE"

if [ -n "$MYSQL_PASSWORD" ] ; then

        echo "DELETE FROM mysql.user WHERE user = 'root' AND host = '%';" >> "$TEMP_FILE"
        echo "CREATE USER 'root'@'%' IDENTIFIED WITH mysql_native_password BY '${MYSQL_PASSWORD}' ;" >> "$TEMP_FILE"
        echo "GRANT ALL ON *.* TO 'root'@'%' WITH GRANT OPTION ;" >> "$TEMP_FILE"
        echo "FLUSH PRIVILEGES ;" >> "$TEMP_FILE"

fi

# set this as an init-file to execute on startup
set -- "$@" --init-file="$TEMP_FILE"

# execute the command supplied
exec "$@"


