

Run cmd:

docker build -t niwde/server-php5.6 . 

or with proxy (give the ip and port of your proxy) 

docker build --build-arg https_proxy=http://127.0.0.1:3128 --build-arg http_proxy=http://127.0.0.1:3128 -t niwde/server-php5.6 .
