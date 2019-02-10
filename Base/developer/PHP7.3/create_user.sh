#!/bin/bash

#create user webshop
rm -rf /home/webshop/ 
userexists="$(cut -d: -f1 /etc/passwd | grep webshop)"
if [[ -n $userexists ]]; then 
	echo $userexists
	userdel webshop;
fi
useradd -G www-data --create-home --shell /bin/bash webshop
echo 'webshop:webshop' | chpasswd