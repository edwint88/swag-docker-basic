#!/bin/bash

# don't show anything until it's sure that the images are downloaded
service apache2 stop
# Download Shopware test_images.zip
cd /home/webshop/Downloads/
wget -O test_images.zip http://releases.s3.shopware.com/test_images_since_5.1.zip
unzip -d /var/www/html/shopware /home/webshop/Downloads/test_images.zip

# set the rights to www-data and webshop
chown -R www-data:www-data /var/www/html/ \
	&& chmod -R 777 /var/www/html/
chown -R webshop:www-data /home/webshop \
	&& chmod -R 777 /home/webshop

#start open ssh
/usr/sbin/sshd &

#start mysql safe
/etc/init.d/mysql stop
status="$(/etc/init.d/mysql status)"
if [[ "${status}" != *"Uptime"* ]]; then
		echo "start mysql server safe"
        find /var/lib/mysql -type f -exec touch {} \; && /usr/bin/mysqld_safe &
fi

#check if apache2 is started
status="$(/etc/init.d/apache2 status)"
if [[ "${status}" != "apache2 is running." ]]; then
		echo "start apache2 server"
        service apache2 start
fi

# keep container alive
tail -f /dev/null