#-------------------------------------------------------------------------------
# Copyright (C) 2017 Eurotech.
# All rights reserved. This program and the accompanying materials
# are made available under the terms of the Eclipse Public License v1.0
# which accompanies this distribution, and is available at
# http://www.eclipse.org/legal/epl-v10.html
# 
# Contributors:
#     Eurotech - initial API and implementation
#-------------------------------------------------------------------------------
FROM resin/raspberrypi3-node:0.10.22-slim

MAINTAINER Matteo Maiero <matteo.maiero@eurotech.com>

RUN apt-get update && \
    apt-get install -y apt-utils unzip ethtool dos2unix telnet bind9 hostapd isc-dhcp-server iw wget --no-install-recommends && \
    apt-get clean && \
    rm -rf /var/lib/apt/lists/*

## Use Oracle Java 8 Embedded
ENV EJDK=ejdk-8u51-linux-arm-hflt-nocomp-debug
RUN wget https://s3.amazonaws.com/kura_downloads/virtual_machines/${EJDK}.tar.gz && \
    tar -zxf ${EJDK}.tar.gz -C /opt && \
    mv /opt/${EJDK} /opt/jre
ENV PATH="/opt/jre/bin:${PATH}"

ENV KURA_VERSION=${KURA_VERSION:-3.0.0}
ENV RPI_VERSION=${RPI_VERSION:-raspberry-pi-2-3-nn}

## Kura installation http://hudson.eclipse.org/kura/job/kura-develop/lastSuccessfulBuild/artifact/kura/distrib/target/kura_3.0.0-SNAPSHOT_raspberry-pi-2-3_installer.deb
RUN wget http://mirrors.nic.cz/eclipse/kura/releases/${KURA_VERSION}/kura_${KURA_VERSION}_${RPI_VERSION}_installer.deb && \
    dpkg -i --ignore-depends=java8-runtime-headless,java8-runtime kura_${KURA_VERSION}_${RPI_VERSION}_installer.deb && \
    rm kura_${KURA_VERSION}_${RPI_VERSION}_installer.deb

ENV ARCH=${ARCH:-arm}
ENV ARCH_FLOAT_MODE=${ARCH_FLOAT_MODE:-gnueabihf}
ENV REST_DP_VERSION=${REST_DP_VERSION:-1.0.0}

## Create missing symlink for libudev
RUN [ -f /lib/${ARCH}-linux-${ARCH_FLOAT_MODE}/libudev.so.0 ] || ln -sf /lib/${ARCH}-linux-${ARCH_FLOAT_MODE}/libudev.so.1 /lib/${ARCH}-linux-${ARCH_FLOAT_MODE}/libudev.so.0

COPY node-rest-proxy node-rest-proxy
COPY start.sh start.sh
COPY org.eclipse.kura.configuration.remote_${REST_DP_VERSION}.dp /opt/eclipse/kura/kura/packages/org.eclipse.kura.configuration.remote_${REST_DP_VERSION}.dp
COPY dpa.properties /opt/eclipse/kura/kura/dpa.properties

## Web and telnet
EXPOSE 1234
EXPOSE 5002

CMD bash start.sh
