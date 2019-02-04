#!/bin/bash

#clone Shopware from Official git
cd /var/www/html/
wget $dwurl
unzip -d shopware $(ls . | grep install)

# set the rights to www-data and webshop
chown -R www-data:www-data /var/www/html/ \
	&& chmod -R 777 /var/www/html/