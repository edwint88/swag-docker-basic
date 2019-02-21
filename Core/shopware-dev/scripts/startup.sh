#!/bin/bash

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