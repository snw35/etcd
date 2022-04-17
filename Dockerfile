FROM alpine:3.15.4

ENV ETCD_VERSION 3.5.3
ENV ETCD_URL https://github.com/etcd-io/etcd/releases/download/v${ETCD_VERSION}
ENV ETCD_FILENAME etcd-v${ETCD_VERSION}-linux-amd64.tar.gz
ENV ETCD_SHA256 e13e119ff9b28234561738cd261c2a031eb1c8688079dcf96d8035b3ad19ca58

RUN wget $ETCD_URL/$ETCD_FILENAME \
  && echo "$ETCD_SHA256  ./$ETCD_FILENAME" | sha256sum -c - \
  && tar -xzf ./${ETCD_FILENAME} \
  && chmod +x ./etcd-v${ETCD_VERSION}-linux-amd64/etcd \
  && chmod +x ./etcd-v${ETCD_VERSION}-linux-amd64/etcdctl \
  && mv ./etcd-v${ETCD_VERSION}-linux-amd64/etcd /usr/bin/etcd \
  && mv ./etcd-v${ETCD_VERSION}-linux-amd64/etcdctl /usr/bin/etcdctl \
  && rm -rf ./etcd-v${ETCD_VERSION}-linux-amd64 \
  && rm -f ./${ETCD_FILENAME} \
  && etcd --help \
  && etcdctl --help

COPY docker-entrypoint.sh /docker-entrypoint.sh

RUN apk --update --no-cache add \
    bash \
  && chmod +x /docker-entrypoint.sh

EXPOSE 2379 2380 4001 7001

VOLUME /etcd_data

ENTRYPOINT ["/docker-entrypoint.sh"]

CMD ["etcd"]
