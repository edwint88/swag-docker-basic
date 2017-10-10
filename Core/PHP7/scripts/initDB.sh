#!/bin/bash

status="$(/etc/init.d/mysql status)"
if [[ "${status}" != *"Uptime"* ]]; then
		echo "start mysql server"
		#/usr/sbin/mysqld --skip-grant-tables &
		#/etc/init.d/mysql restart
		#mysqlcheck --auto-repair --all-databases
		#ps aux | grep mysqld | awk '{print$2}' | while read l; do kill -9 $l; done
		#service --status-all
		find /var/lib/mysql -type f -exec touch {} \; && service mysql start
        #/etc/init.d/mysql restart
		#mysqlcheck --auto-repair --all-databases
		#service --status-all
fi

echo "GRANT USAGE ON *.* TO 'webshop'@'localhost';" | mysql
echo "DROP USER 'webshop'@'localhost';" | mysql
echo "create user webshop@localhost identified by 'webshop';" | mysql

echo "create database shopware_dev;" | mysql
echo "GRANT ALL ON *.* TO webshop@localhost IDENTIFIED BY 'webshop' WITH GRANT OPTION; FLUSH PRIVILEGES" | mysql