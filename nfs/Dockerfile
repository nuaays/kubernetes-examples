FROM ubuntu:latest

ENV DEBIAN_FRONTEND noninteractive

RUN apt-get update -qq && apt-get install -y nfs-common inotify-tools rpcbind -qq

ADD nfs-client.sh /usr/local/bin/nfs-client

ENTRYPOINT ["/usr/local/bin/nfs-client"]
