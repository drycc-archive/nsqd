FROM docker.io/nsqio/nsq:v1.2.1

RUN apk add --update jq \
  &&  mkdir -p /opt/nsqd/data \
  && adduser \
     -s /bin/sh \
     -D  \
     -h /opt/nsqd \
     nsqd \
     nsqd

COPY . /
RUN chown -R nsqd:nsqd /opt/nsqd
USER nsqd
WORKDIR /
