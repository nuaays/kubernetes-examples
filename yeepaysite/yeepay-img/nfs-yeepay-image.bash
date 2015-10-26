#!/bin/bash
docker run -d --restart=always --name yeepay-img-server  -v /mnt/yeepay/yeepay-img/public/:/tmp --privileged=true yeepay/docker-nfs-server /tmp
