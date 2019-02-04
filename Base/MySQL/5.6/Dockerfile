#Dockerfile 
FROM niwde/server-php7.1
LABEL Description="This image is used to installs mysql 7.1" Vendor="niwde" Version="1.0"

# MYSQL
# Install mysql server and client
RUN DEBIAN_FRONTEND=noninteractive apt-get -q -y install mysql-client mysql-server
RUN sed -i -e"s/^bind-address\s*=\s*127.0.0.1/bind-address = 0.0.0.0/" /etc/mysql/my.cnf

# Clean 
RUN apt-get clean
