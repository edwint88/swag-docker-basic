docker build --build-arg shop_version=5.5.6 -t edwint88/shopware:dev-7.3 . 
docker build -f Dockerfile-PHP7.2 --build-arg shop_version=5.5.6 -t edwint88/shopware:dev-7.2 . 