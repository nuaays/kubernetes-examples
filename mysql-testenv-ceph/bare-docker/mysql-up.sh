#!/bin/bash

docker run -tid --name mysql-yce -e "MYSQL_ROOT_PASSWORD=root" -p 3306:3306 -v $PWD/data:/var/lib/mysql  mysql:latest
