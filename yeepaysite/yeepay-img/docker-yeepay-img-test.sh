#!/bin/bash
docker run -d -p 8088:8080 -v /mnt/yeepay/yeepay-img/public/:/usr/local/yeepay-img/public --name yeepay-image yeepay/img-server
