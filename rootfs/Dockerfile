FROM nsqio/nsq:v1.2.0

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
