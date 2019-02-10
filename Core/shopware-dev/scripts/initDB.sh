#!/bin/bash

status="$(/etc/init.d/mysql status)"
if [[ "${status}" != *"Uptime"* ]]; then
		echo "start mysql server"
		find /var/lib/mysql -type f -exec touch {} \; && service mysql start
fi

echo "GRANT USAGE ON *.* TO 'webshop'@'localhost';" | mysql -uroot 
echo "DROP USER 'webshop'@'localhost';" | mysql -uroot 
echo "create user webshop@localhost identified by 'webshop';" | mysql -uroot 

echo "create database shopware;" | mysql -uroot 
echo "GRANT ALL ON *.* TO webshop@localhost IDENTIFIED BY 'webshop' WITH GRANT OPTION; FLUSH PRIVILEGES" | mysql -uroot 