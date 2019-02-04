#Dockerfile 
FROM edwint88/1container
LABEL Description="This image is used to run shopware" Vendor="niwde" Version="1.0"

ARG dwurl=http://releases.s3.shopware.com.s3.amazonaws.com/install_5.5.6_9cb9f7b8f22ef979df1acd99b0e8071a6fbaf785.zip

ADD ./scripts/create_user.sh /usr/local
RUN chmod 777 /usr/local/create_user.sh && /usr/local/create_user.sh 
USER webshop

#create downloads folder
RUN mkdir -p /home/webshop/Downloads

USER root
# Common
# Install sshd
RUN apt-get install -y openssh-server
RUN mkdir /var/run/sshd
RUN sed -i 's/PermitRootLogin prohibit-password/PermitRootLogin yes/' /etc/ssh/sshd_config
# SSH login fix. Otherwise user is kicked off after login
RUN sed 's@session\s*required\s*pam_loginuid.so@session optional pam_loginuid.so@g' -i /etc/pam.d/sshd
ENV NOTVISIBLE "in users profile"
RUN echo "export VISIBLE=now" >> /etc/profile
EXPOSE 22

# Install COMPOSER and put binary into $PATH 
RUN curl -sS https://getcomposer.org/installer | php \
	&& mv composer.phar /usr/local/bin/ \
	&& ln -s /usr/local/bin/composer.phar /usr/local/bin/composer
	
# Clean 
RUN apt-get clean

#start services
ADD ./scripts/startup.sh /opt/startup.sh
RUN chown root:webshop /opt/startup.sh && chmod 777 /opt/startup.sh

# Add scripts
ADD ./scripts/installWebshop.sh /home/webshop/scripts/
ADD ./scripts/initDB.sh /home/webshop/scripts/

RUN chmod 777 /home/webshop/scripts/initDB.sh && /home/webshop/scripts/initDB.sh
RUN chmod 777 /home/webshop/scripts/installWebshop.sh && /home/webshop/scripts/installWebshop.sh

CMD /opt/startup.sh