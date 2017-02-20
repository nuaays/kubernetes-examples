#######################################################
# Image: img.reg.3g:15000/zookeeper-3.4.6
#######################################################

FROM img.reg.3g:15000/jdk:1.7.0_67 

MAINTAINER dawei.li@yeepay.com

USER root

ENV ZOOKEEPER_VERSION 3.4.6

ADD Dockerfile /

ADD zookeeper/ /opt/

COPY zoo.cfg /opt/zookeeper/conf/zoo.cfg

RUN mkdir -p /opt/zookeeper/{data,log}

WORKDIR /opt/zookeeper

VOLUME ["/opt/zookeeper/conf", "/opt/zookeeper/data", "/opt/zookeeper/log"]

COPY config-and-run.sh /opt/zookeeper/bin/

EXPOSE 2181 2888 3888

CMD ["/opt/zookeeper/bin/config-and-run.sh"]
