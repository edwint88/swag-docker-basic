#Dockerfile 
FROM niwde/server-php7.0
LABEL Description="This image is used to installs mysql 5.6 for Plugins Development" Vendor="niwde" Version="1.0"
#name niwde/php7-mysql5.6

RUN apt-get install -y lsb-release
RUN apt-get install -y wget
RUN apt-get install -y debconf-utils

ADD mysql-apt-config_0.8.3-1_all.deb /home/webshop/
ADD install.sh /home/webshop/scripts/

# MYSQL
RUN /home/webshop/scripts/install.sh

# Clean 
RUN apt-get clean
RUN chown -R mysql:mysql /var/lib/mysql /var/run/mysqld/ 
#RUN /usr/bin/mysqld_safe --user=mysql &
#RUN find /var/lib/mysql -type f -exec touch {} \; && service mysql start
