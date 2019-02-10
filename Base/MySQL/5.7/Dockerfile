FROM edwint88/php7.3
LABEL Description="This image is used to installs mysql 5.7" Vendor="niwde" Version="1.0"

# MYSQL

RUN apt-get install -y debconf-utils
RUN apt-get install -y gnupg
RUN apt-get install -y wget
RUN apt-get install -y lsb-release
# Download
RUN mkdir -p /home/webshop/scripts
RUN cd /home/webshop/scripts/ && wget https://dev.mysql.com/get/mysql-apt-config_0.8.12-1_all.deb && ls -la
ADD install.sh /home/webshop/scripts
# Run install MySQL
RUN /bin/bash /home/webshop/scripts/install.sh
RUN chown -R mysql:mysql /var/lib/mysql 
#start db
#RUN /usr/bin/mysqld_safe --user=mysql &
#RUN find /var/lib/mysql -type f -exec touch {} \; && service mysql start

# Clean 
RUN apt-get clean

ADD start.sh /home/webshop/scripts
RUN chmod 777 /home/webshop/scripts/start.sh

CMD /home/webshop/scripts/start.sh