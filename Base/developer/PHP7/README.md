Run

docker build -t niwde/base-php7-mysql5.6-developer .

or with proxy

docker build --build-arg https_proxy=http://ip:port --build-arg http_proxy=http://ip:port -t niwde/base-php7-mysql5.6-developer .
