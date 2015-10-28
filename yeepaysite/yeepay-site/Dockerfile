#################################################### 
# For Node.js (www.yeepay.com) 
####################################################
 
FROM yeepay/nodejs-base
MAINTAINER lidawei dawei.li@yeepay.com

RUN mkdir /usr/local/yeepay-site
#RUN mkdir /usr/local/yeepay-img/output
ADD yeepay /usr/local/yeepay-site

RUN cd /usr/local/yeepay-site

WORKDIR /usr/local/yeepay-site

EXPOSE 8080

ENTRYPOINT ["/usr/bin/node", "yeepay.js"]
