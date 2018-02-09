# Declared here to be used by the FROM below
ARG NWN_VERSION
ARG NWNX_VERSION
ARG NWN_TAG
ARG NWN_VERSION_SUFFIX

FROM ${NWN_TAG}:${NWN_VERSION}${NWN_VERSION_SUFFIX}
LABEL maintainer "niv@beamdog.com"

RUN mkdir -p /usr/share/man/man1
RUN apt-get update && \
  apt-get -y install openjdk-8-jdk-headless && \
  rm -r /var/cache/apt /var/lib/apt/lists


