#Dockerfile 
FROM php:7.1.10-apache
LABEL Description="This image is used to start the php:7.1.10" Vendor="niwde" Version="1.0"

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
# Install bz2
RUN apt-get update && apt-get install -y \
		libbz2-dev \
	&& docker-php-ext-install bz2
# Install zip
RUN apt-get update && apt-get install -y \
		libzip-dev \
	&& docker-php-ext-install zip 
# Install php extensions: mysqli pdo_mysql
RUN docker-php-ext-install mysqli pdo_mysql
# Install soap
RUN apt-get update && apt-get install -y \
		libxml2-dev \
		php-soap \
	&& docker-php-ext-install -j$(nproc) soap
# Install opcache && dom
RUN docker-php-ext-install opcache dom
# Install ioncube
RUN mkdir -p /home/webshop/Downloads
RUN cd /home/webshop/Downloads/ \
	&& curl -O http://downloads3.ioncube.com/loader_downloads/ioncube_loaders_lin_x86-64.tar.gz \
	&& tar xvfz ioncube_loaders_lin_x86-64.tar.gz
RUN ls /home/webshop/Downloads/
RUN cd /home/webshop/Downloads/ \
    && mv ioncube/ioncube_loader_lin_7.1.so /usr/local/lib/php/extensions/* \
	&& echo "zend_extension=ioncube_loader_lin_7.1.so" > /usr/local/etc/php/conf.d/00_docker-php-ext-ioncube_loader_lin_7.1.ini
# Install mcrypt
RUN apt-get update && apt-get install -y \
        libmcrypt-dev \
    && docker-php-ext-install -j$(nproc) mcrypt
# Install intl
RUN apt-get update && apt-get install -y \
        libicu-dev \
    && docker-php-ext-install -j$(nproc) intl
# RUN add pecl proxy
RUN pear config-set http_proxy $http_proxy system
RUN pear config-set http_proxy $http_proxy user
# Install memcached
#RUN apt-get update && apt-get install -y \
#		libmemcached-dev \
#		zlib1g-dev \
#    && pecl install memcached-2.2.0 \
#    && docker-php-ext-enable memcached
# Install gd && iconv
RUN apt-get update && apt-get install -y \
        libfreetype6-dev \
        libjpeg62-turbo-dev \
        libpng12-dev \
	&& docker-php-ext-install -j$(nproc) iconv \
    && docker-php-ext-configure gd --with-freetype-dir=/usr/include/ --with-jpeg-dir=/usr/include/ \
    && docker-php-ext-install -j$(nproc) gd
# Install gettext && mbstring && hash && json && xml
RUN docker-php-ext-install -j$(nproc) \
	gettext \
	mbstring \
	hash \
	json \
	xml
# others 
RUN docker-php-ext-install \
	sockets \
	calendar \
	sysvmsg \
	sysvsem \
	sysvshm

# Clean 
RUN apt-get clean
