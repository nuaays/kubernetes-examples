########################################################
# tdagent-base:latest
# no td-agent.conf
########################################################

FROM ubuntu-base:v3
MAINTAINER dawei.li@yeepay.com

# Ensure there are enough file descriptors for running Fluentd.
RUN ulimit -n 65536

# Disable prompts from apt.
ENV DEBIAN_FRONTEND noninteractive


# Install Fluentd.
RUN /usr/bin/curl -L https://td-toolbelt.herokuapp.com/sh/install-ubuntu-trusty-td-agent2.sh | sh

# Change the default user and group to root.
# Needed to allow access to /var/log/docker/... files.
RUN sed -i -e "s/USER=td-agent/USER=root/" -e "s/GROUP=td-agent/GROUP=root/" /etc/init.d/td-agent

# Install the Elasticsearch Fluentd plug-in.
RUN td-agent-gem install fluent-plugin-kubernetes_metadata_filter fluent-plugin-elasticsearch

# Copy the Fluentd configuration file.
# COPY td-agent.conf /etc/td-agent/td-agent.conf

# Run the Fluentd service.
# ENTRYPOINT ["td-agent"]
