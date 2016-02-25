#
# Yeeapy kafka-manager 1.2.0
# Image: yeepay/kafka-manager:1.2.0
#

# Pull base image.
FROM yeepay/oraclejdk8:latest

MAINTAINER dawei.li@yeepay.com 

# Prepare
RUN mkdir /opt/kafka-manager-1.2.0
ADD kafka-manager-1.2.0/ /opt/kafka-manager-1.2.0/
ADD KafkaOffsetMonitor-assembly-0.2.1.jar /opt/

EXPOSE 9001
EXPOSE 8086

ADD start.sh /opt/
RUN chmod +x /opt/start.sh

CMD ["/opt/start.sh"]
