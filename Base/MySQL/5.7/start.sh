#!/bin/bash

find /var/lib/mysql -type f -exec touch {} \; && service mysql start &
service apache2 start

tail -f /dev/null