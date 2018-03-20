# Declared here to be used by the FROM below
ARG NWN_VERSION
ARG SUFFIX

FROM nwnxee/nwserver:${NWN_VERSION}${SUFFIX}
LABEL maintainer "glorwinger"

RUN mkdir -p /usr/share/man/man1
RUN apt-get update && \
  apt-get -y install openjdk-8-jdk-headless && \
  rm -r /var/cache/apt /var/lib/apt/lists

ENV NWNX_JVM_CLASSPATH=/nwn/run/nwnx/org.nwnx.nwnx2.jvm.jar

