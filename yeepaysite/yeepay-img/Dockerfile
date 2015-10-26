#################################################### 
# For Node.js (www.yeepay.com) 
####################################################
 
FROM yeepay/nodejs-base
MAINTAINER lidawei dawei.li@yeepay.com

RUN mkdir /usr/local/yeepay-img
RUN mkdir /usr/local/yeepay-img/output
ADD yeepay-img /usr/local/yeepay-img

RUN cd /usr/local/yeepay-img

WORKDIR /usr/local/yeepay-img

EXPOSE 8080

ENTRYPOINT ["/usr/bin/node", "img-server.js"]
