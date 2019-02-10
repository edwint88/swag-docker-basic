#Dockerfile 
FROM edwint88/1container-mariadb
LABEL Description="This image is used for Shopware Development" Vendor="edwint88" Version="1.0"

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

RUN echo 'deb http://ftp.debian.org/debian/ stable main contrib non-free' >>/etc/apt/sources.list
RUN mkdir -p /usr/share/man/man1
RUN apt-get update && apt-get install openjdk-8-jre-headless -y

# Install ant
RUN apt-get update && \
    apt-get -f install ant -y

RUN apt-get update && apt-get install wget -y 	

# Install git
RUN apt-get update && apt-get install git -y

# Install xdebug
#RUN apt-get update && apt-get install php5-xdebug -y \
RUN pecl install xdebug-2.7.0beta1 \
	&& docker-php-ext-enable xdebug
	
# Install COMPOSER and put binary into $PATH 
RUN curl -sS https://getcomposer.org/installer | php \
	&& mv composer.phar /usr/local/bin/ \
	&& ln -s /usr/local/bin/composer.phar /usr/local/bin/composer
	
# Install PHPUNIT
RUN su webshop -c "composer global require --dev 'phpunit/phpunit ˆ8'"
ENV PATH /home/webshop/.composer/vendor/bin:$PATH
RUN ln -s /home/webshop/.composer/vendor/bin/phpunit /usr/local/bin/phpunit

# Clean 
RUN apt-get clean