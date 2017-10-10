Run

build --build-arg https_proxy=http://ip:port --build-arg http_proxy=http://ip:port -t niwde/base-developer-image .
docker build --build-arg https_proxy=http://10.3.33.206:3128 --build-arg http_proxy=http://10.3.33.206:3128 -t niwde/base-php7-mysql5.6-developer .