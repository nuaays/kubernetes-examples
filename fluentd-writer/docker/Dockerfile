FROM registry.docker.yeepay.com:5000/yeepay/fluentd-base:latest
MAINTAINER dawei.li@yeepay.com

ADD fluent.conf /etc/fluent/
ENTRYPOINT ["/usr/local/bundle/bin/fluentd", "-c", "/etc/fluent/fluent.conf"]
