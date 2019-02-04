# Run

docker build --build-arg https_proxy=http://ip:port --build-arg http_proxy=http://ip:port -t niwde/server-mysql5.6 .

docker run -d --name mysql56-dev niwde/myslq-5.6
