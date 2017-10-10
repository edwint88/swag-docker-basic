#Dockerfile 
FROM php:5.6-apache
LABEL Description="This image is used to start the php5.6" Vendor="niwde" Version="1.0"

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

#PHP extensions
# Install bz2
RUN apt-get update && apt-get install -y \
		libbz2-dev \
	&& docker-php-ext-install bz2
# Install zip
RUN apt-get update && apt-get install -y \
		libzip-dev \
	&& docker-php-ext-install zip 
# Install php extensions: mysql mysqli pdo_mysql
RUN docker-php-ext-install mysql mysqli pdo_mysql
# Install ioncube
ADD resources/ioncube.tar.gz /home/webshop/Downloads/
RUN cd /home/webshop/Downloads/ \
    && mv ioncube/ioncube_loader_lin_5.6.so /usr/local/lib/php/extensions/* \
	&& echo "zend_extension=ioncube_loader_lin_5.6.so" > /usr/local/etc/php/conf.d/00_docker-php-ext-ioncube_loader_lin_5.6.ini
# Install mcrypt
RUN apt-get update && apt-get install -y \
        libmcrypt-dev \
    && docker-php-ext-install -j$(nproc) mcrypt
# Install intl
RUN apt-get update && apt-get install -y \
        libicu-dev \
    && docker-php-ext-install -j$(nproc) intl
#RUN add pecl proxy
RUN pear config-set http_proxy $http_proxy system
RUN pear config-set http_proxy $http_proxy user
# Install memcached
RUN apt-get update && apt-get install -y \
		libmemcached-dev \
		zlib1g-dev \
    && pecl install memcached-2.2.0 \
    && docker-php-ext-enable memcached
# Install gd && iconv
RUN apt-get update && apt-get install -y \
        libfreetype6-dev \
        libjpeg62-turbo-dev \
        libpng12-dev \
	&& docker-php-ext-install -j$(nproc) iconv \
    && docker-php-ext-configure gd --with-freetype-dir=/usr/include/ --with-jpeg-dir=/usr/include/ \
    && docker-php-ext-install -j$(nproc) gd
# Install soap
RUN apt-get update && apt-get install -y \
		libxml2-dev \
		php-soap \
	&& docker-php-ext-install -j$(nproc) soap
# Install gettext && mbstring 
RUN docker-php-ext-install \
	gettext \
	mbstring
# others 
RUN docker-php-ext-install \
	sockets \
	calendar \
	sysvmsg \
	sysvsem \
	sysvshm

# Clean 
RUN apt-get clean