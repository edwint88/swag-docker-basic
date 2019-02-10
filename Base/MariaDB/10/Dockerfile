FROM edwint88/php7.3
LABEL Description="This image is used to installs mariadb" Vendor="niwde" Version="1.0"

# MYSQL

RUN apt-get install -y debconf-utils
RUN apt-get install -y gnupg
RUN apt-get install -y wget
RUN apt-get install -y lsb-release
# Download
RUN mkdir -p /home/webshop/scripts
# Run install MariaDB
RUN apt-get -y install mysql-server
RUN sed -i -e"s/^bind-address\s*=\s*127.0.0.1/bind-address = 0.0.0.0/" /etc/mysql/my.cnf
RUN chown -R mysql:mysql /var/lib/mysql 

# Clean 
RUN apt-get clean

ADD start.sh /home/webshop/scripts
RUN chmod 777 /home/webshop/scripts/start.sh

CMD /home/webshop/scripts/start.sh