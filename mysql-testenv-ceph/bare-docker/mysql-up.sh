#!/bin/bash

docker run -tid --name mysql-yce -e "MYSQL_ROOT_PASSWORD=root" -p 3306:3306 -v data:/data mysql:latest
