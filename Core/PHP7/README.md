# Ports to run the image
30080:80

30006:3306

30022:22

# Commands

## build image
Give a shopware version here (shop_version=...)

docker build --build-arg shop_version=5.2.21 -t php7swag 

with proxy:
docker build --build-arg https_proxy=protocol://ip:port --build-arg http_proxy=protocol://ip:port --build-arg shop_version=5.2.21 -t php7swag .

docker run -d -p 30022:22 -p 30080:80 -p 30006:3306 --name php7swag niwde/swag-php7-dev

# Troubleshooting

## shopware change version

### reset to a specific version
git reset --hard (tag)5.3
### clean tracking files
git clean -xf
### checkout the version
git checkout 5.3
### move to build folder
cd /var/www/html/shopware/build
#### set db connection & create build.properties
ant -Ddb.host=127.0.0.1 -Ddb.name=shopware_dev -Ddb.user=webshop -Duser.db.password=webshop -Ddb.password=webshop -Ddb.port=3306 write-properties
### start build
ant build-unit
### get test images
cd /home/webshop/Downloads/
### if they are not already downloaded, do:
curl -s http://releases.s3.shopware.com/test_images_since_5.1.zip > test_images.zip
### extract images
unzip -d /var/www/html/shopware /home/webshop/Downloads/test_images.zip

## Set the rights to www-data and webshop
chown -R www-data:www-data /var/www/html/ && chmod -R 777 /var/www/html/
