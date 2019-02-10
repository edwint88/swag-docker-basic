#!/bin/bash

su 'webshop'
#clone Shopware from Official git
cd /var/www/html/
git clone https://github.com/shopware/shopware.git
cd /var/www/html/shopware
echo "shop_version:${shop_version}"
echo "shop_branch:${shop_branch}"
branch="$(git branch -a) | grep $shop_branch"
tags="$(git tag -l) | grep $shop_version"
if [[ -n $shop_version && -n $tags && -n $shop_branch && -n $branch ]]; then
	echo $tags
	echo $branch
	git checkout "tags/v${shop_version}" -b $shop_branch
elif [[ -n $shop_version && -n $tags ]]; then
	echo $tags
	git checkout "tags/v${shop_version}"
elif [[ -n $shop_branch && -n $branch ]]; then
	git checkout -b ${shop_branch}
fi

echo 'clone finished'

#build shopware
cd /var/www/html/shopware/build
#ant configure
echo 'start ant tasks'
ant -Ddb.host=127.0.0.1 -Ddb.name=shopware_dev -Ddb.user=webshop -Duser.db.password=webshop -Ddb.password=webshop -Ddb.port=3306 write-properties

#make sure the mysql service is running
status="$(/etc/init.d/mysql status)"
if [[ "${status}" != *"Uptime"* ]]; then
		echo "start mysql server"
        find /var/lib/mysql -type f -exec touch {} \; && /etc/init.d/mysql start
fi

echo 'start build-unit'
ant build-unit
echo 'finish build-unit'


# set the rights to www-data and webshop
chown -R www-data:www-data /var/www/html/ \
	&& chmod -R 777 /var/www/html/
chown -R webshop:www-data /home/webshop \
	&& chmod -R 777 /home/webshop