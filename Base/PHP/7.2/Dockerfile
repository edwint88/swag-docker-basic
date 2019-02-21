#Dockerfile 
FROM php:7.2.15-apache-stretch
LABEL Description="This image is used to start the php:7.2" Vendor="niwde" Version="1.0"

# apache2 rewrite mode
RUN a2enmod rewrite

# Common
# Install Vim
RUN apt-get update && \
    apt-get install vim -y
# Install openssl
RUN apt-get update && apt-get install openssl -y
# Install unzip
RUN apt-get update && apt-get install -y unzip

#To install crontab
RUN apt-get update && apt-get install -y cron

#PHP extensions
# Install zip
RUN apt-get update && apt-get install -y \
		libzip-dev \
	&& docker-php-ext-install zip 
# Install php extensions: mysqli pdo_mysql
RUN docker-php-ext-install mysqli pdo_mysql
# Install opcache 
RUN apt-get update && apt-get install -y \
		libxml2-dev 
RUN docker-php-ext-install opcache 
# Install intl
RUN apt-get update && apt-get install -y \
        libicu-dev \
    && docker-php-ext-install -j$(nproc) intl
# Install gd && iconv
RUN apt-get update && apt-get install -y \
        libfreetype6-dev \
        libjpeg62-turbo-dev \
    && docker-php-ext-configure gd --with-freetype-dir=/usr/include/ --with-jpeg-dir=/usr/include/ \
    && docker-php-ext-install -j$(nproc) gd
# Install gettext && mbstring && hash && json && xml
RUN docker-php-ext-install -j$(nproc) \
	gettext 
# others 
RUN docker-php-ext-install \
	sockets \
	calendar \
	sysvmsg \
	sysvsem \
	sysvshm

# Clean 
RUN apt-get clean