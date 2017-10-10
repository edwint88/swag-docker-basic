#Dockerfile 
FROM niwde/server-php7.0
LABEL Description="This image is used to installs mysql 5.6 for Plugins Development" Vendor="niwde" Version="1.0"

# MYSQL
# Install mysql server and client
RUN DEBIAN_FRONTEND=noninteractive apt-get -q -y install mysql-client mysql-server
RUN sed -i -e"s/^bind-address\s*=\s*127.0.0.1/bind-address = 0.0.0.0/" /etc/mysql/my.cnf

# Clean 
RUN apt-get clean

ADD ./create_user.sh /tmp/create_user.sh
RUN bash /tmp/create_user.sh

#create downloads folder
RUN mkdir -p /home/webshop/Downloads

# Common
# Install sshd
RUN apt-get update && apt-get install -y openssh-server
RUN mkdir /var/run/sshd
RUN sed -i 's/PermitRootLogin prohibit-password/PermitRootLogin yes/' /etc/ssh/sshd_config
# SSH login fix. Otherwise user is kicked off after login
RUN sed 's@session\s*required\s*pam_loginuid.so@session optional pam_loginuid.so@g' -i /etc/pam.d/sshd
ENV NOTVISIBLE "in users profile"
RUN echo "export VISIBLE=now" >> /etc/profile
EXPOSE 22

# Install ant
RUN apt-get update && \
    apt-get install ant -y
	
# Install git
RUN apt-get update && apt-get install git -y

# Install mercurial
#RUN apt-get update && apt-get install -q -y mercurial
#to use with mercurial without promting user and pass - dev only
#COPY config/.hgrc /home/webshop/	

# PHP Extensions

# Install xdebug
#RUN apt-get update && apt-get install php5-xdebug -y \
RUN pecl install xdebug-2.5.5 \
	&& docker-php-ext-enable xdebug
	
# Install COMPOSER and put binary into $PATH 
RUN curl -sS https://getcomposer.org/installer | php \
	&& mv composer.phar /usr/local/bin/ \
	&& ln -s /usr/local/bin/composer.phar /usr/local/bin/composer
	
# Install PHPUNIT
RUN su webshop -c "composer global require 'phpunit/phpunit 4.8.35'"
ENV PATH /home/webshop/.composer/vendor/bin:$PATH
RUN ln -s /home/webshop/.composer/vendor/bin/phpunit /usr/local/bin/phpunit

# Install NodeJS 
#RUN curl -sL https://deb.nodesource.com/setup_6.x | bash - \
#	&& apt-get install -y nodejs

# Install Grunt globally 
#RUN npm install -g grunt-cli
# Install Gulp globally 
#RUN npm install -g gulp-cli
# Install Bower globally 
#RUN npm install -g bower

# Clean 
RUN apt-get clean