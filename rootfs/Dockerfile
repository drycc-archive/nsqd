FROM golang:latest AS build

ARG NSQ_VERSION=v1.2.0
RUN apt-get update \
  && apt-get install git \
  && git clone --dept 1 -b $NSQ_VERSION https://github.com/nsqio/nsq $GOPATH/src/github.com/nsqio/nsq \
  && cd $GOPATH/src/github.com/nsqio/nsq \
  && export GO111MODULE=on \
  && CGO_ENABLED=0 make DESTDIR=/opt PREFIX=/nsq BLDFLAGS='-ldflags="-s -w"' install


FROM alpine:latest

# set up nsswitch.conf for Go's "netgo" implementation
# https://github.com/golang/go/issues/35305
RUN [ ! -e /etc/nsswitch.conf ] && echo 'hosts: files dns' > /etc/nsswitch.conf

COPY --from=build /opt/nsq/bin/ /bin/

RUN mkdir -p /opt/nsqd/data \
  && adduser \
     -s /bin/sh \
     -D  \
     -h /opt/nsqd \
     nsqd \
     nsqd

ADD https://github.com/stedolan/jq/releases/download/jq-1.6/jq-linux64 /usr/bin/jq

COPY . /
RUN chown -R nsqd:nsqd /opt/nsqd
USER nsqd
WORKDIR /
