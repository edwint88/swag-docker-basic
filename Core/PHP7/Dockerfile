#Dockerfile 
FROM niwde/base-php7-mysql5.6-developer

#init image
LABEL Description="This image is used to start the php7.0 server with Shopware for dev" Vendor="niwde" Version="1.0"

ARG shop_version
ARG shop_branch

# copy php.ini for user
COPY config/php.ini /usr/local/etc/php/

#start services
ADD ./scripts/startup.sh /opt/startup.sh
#dev ports
EXPOSE 9000
EXPOSE 3306
CMD ["/bin/bash", "/opt/startup.sh"]

# Add scripts
ADD ./scripts/initDB.sh /home/webshop/scripts/
ADD ./scripts/installWebshop.sh /home/webshop/scripts/

#VOLUME ["/var/lib/mysql"]

RUN /home/webshop/scripts/initDB.sh
RUN /home/webshop/scripts/installWebshop.sh

# Add bash profile for ssh in the shop directory
ADD ./config/.bash_profile /home/webshop/