# Declared here to be used by the FROM below
ARG NWN_VERSION
ARG LIBRARIES

FROM nwnxee/nwserver:${NWN_VERSION}
LABEL maintainer "glorwinger"

RUN mkdir -p /usr/share/man/man1
RUN apt-get update && \
  apt-get -y install openjdk-8-jdk-headless && \
  rm -r /var/cache/apt /var/lib/apt/lists


