FROM alpine:latest
MAINTAINER abw

RUN apk --update add \
    ffmpeg \
    openssl \
    curl \
    perl-mojolicious \
    perl-lwp-protocol-https \
    perl-xml-simple \
    perl-xml-libxml

RUN apk --update add \
  --repository http://dl-cdn.alpinelinux.org/alpine/edge/testing \
  --repository http://dl-cdn.alpinelinux.org/alpine/edge/main \
  atomicparsley

RUN mkdir -p /data/output /data/config

WORKDIR /app

ENV GET_IPLAYER_VERSION=3.22

### wget: error getting response: Connection reset by peer
#
#RUN wget -qO- https://github.com/get-iplayer/get_iplayer/archive/v${GET_IPLAYER_VERSION}.tar.gz | tar -xvz -C /tmp && \
#
RUN curl -s -L https://github.com/get-iplayer/get_iplayer/archive/v${GET_IPLAYER_VERSION}.tar.gz --output - | tar -xvz -C /tmp && \
    mv /tmp/get_iplayer-${GET_IPLAYER_VERSION}/get_iplayer . && \
    rm -rf /tmp/* && \
    chmod +x ./get_iplayer

ENTRYPOINT ["./get_iplayer", "--atomicparsley", "/usr/bin/AtomicParsley", "--ffmpeg", "/usr/bin/ffmpeg", "--profile-dir", "/data/config", "--output", "/data/output"]
#ENTRYPOINT ["/bin/sh"]

CMD ["-h"]
