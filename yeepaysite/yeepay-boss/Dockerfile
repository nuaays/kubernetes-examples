#################################################### 
# For Node.js (www.yeepay.com) 
####################################################
 
FROM yeepay/nodejs-base
MAINTAINER lidawei dawei.li@yeepay.com

RUN mkdir /usr/local/yeepay-boss
#RUN mkdir /usr/local/yeepay-img/output
ADD yeepay-boss /usr/local/yeepay-boss

RUN cd /usr/local/yeepay-boss

WORKDIR /usr/local/yeepay-boss

EXPOSE 8080

ENTRYPOINT ["/usr/bin/node", "yeepay-boss.js"]
