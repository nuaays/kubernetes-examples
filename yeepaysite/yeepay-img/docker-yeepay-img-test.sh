#!/bin/bash
docker run --rm -ti -v /mnt/yeepay/yeepay-img/public/:/usr/local/yeepay-img/public --name image yeepay/img-server
