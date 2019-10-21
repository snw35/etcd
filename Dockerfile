FROM alpine:3.10.2

ENV ETCD_VERSION 3.4.2
ENV ETCD_URL https://github.com/etcd-io/etcd/releases/download/v${ETCD_VERSION}
ENV ETCD_FILENAME etcd-v${ETCD_VERSION}-linux-amd64.tar.gz
ENV ETCD_SHA256 f369cf0568a0413d2229ae405c16639badd47bef8a070cbfde9aa3e74f072528

RUN wget $ETCD_URL/$ETCD_FILENAME \
  && echo "$ETCD_SHA256  ./$ETCD_FILENAME" | sha256sum -c - \
  && tar -xzf ./${ETCD_FILENAME} \
  && chmod +x ./etcd-v${ETCD_VERSION}-linux-amd64/etcd \
  && chmod +x ./etcd-v${ETCD_VERSION}-linux-amd64/etcdctl \
  && mv ./etcd-v${ETCD_VERSION}-linux-amd64/etcd /usr/bin/etcd \
  && mv ./etcd-v${ETCD_VERSION}-linux-amd64/etcdctl /usr/bin/etcdctl \
  && rm -rf ./etcd-v${ETCD_VERSION}-linux-amd64 \
  && rm -f ./${ETCD_FILENAME}

COPY docker-entrypoint.sh /docker-entrypoint.sh

RUN apk --update --no-cache add \
    bash \
  && chmod +x /docker-entrypoint.sh

EXPOSE 2379 2380 4001 7001

VOLUME /etcd_data

ENTRYPOINT ["/docker-entrypoint.sh"]

CMD ["etcd"]
