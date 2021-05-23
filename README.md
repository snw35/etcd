# etcd

* [Travis CI: ![Build Status](https://travis-ci.com/snw35/etcd.svg?branch=master)](https://travis-ci.com/github/snw35/etcd)
* [Dockerhub: snw35/etcd](https://hub.docker.com/r/snw35/etcd)

Self-updating etcd container.

**NOTE:** for etcd versions 3.4.2 and below, you will need to set ETCD_VERSION to an empty string (or unset it) at runtime or etcd will exit on startup: https://github.com/etcd-io/etcd/issues/11210

## How To Use

This container complies with the official image specifications and runs `etcd` as its default entrypoint. It is recommended to run via docker-compose for a multi-member etcd cluster, e.g:

```
version: '3'
services:

  etcd-1:
    container_name: etcd1
    image: snw35/etcd:latest
    command:
      - '--advertise-client-urls=http://etcd-1:2379'
      - '--auto-compaction-mode=periodic'
      - '--auto-compaction-retention=1'
      - '--data-dir=/etcd_data'
      - '--election-timeout=1250'
      - '--heartbeat-interval=250'
      - '--initial-advertise-peer-urls=http://etcd-1:2380'
      - '--initial-cluster-state=new'
      - '--initial-cluster-token=mys3cr3ttok3n'
      - '--initial-cluster=etcd-1=http://etcd-1:2380,etcd-2=http://etcd-2:2380,etcd-3=http://etcd-3:2380'
      - '--listen-client-urls=http://0.0.0.0:2379'
      - '--listen-peer-urls=http://0.0.0.0:2380'
      - '--name=etcd-1'
    ports:
      - 2379
    volumes:
      - etcd1:/etcd_data
    networks:
      - etcd
    environment:
      - ETCD_VERSION=

  etcd-2:
    container_name: etcd2
    image: snw35/etcd:latest
    command:
      - '--advertise-client-urls=http://etcd-2:2379'
      - '--auto-compaction-mode=periodic'
      - '--auto-compaction-retention=1'
      - '--data-dir=/etcd_data'
      - '--election-timeout=1250'
      - '--heartbeat-interval=250'
      - '--initial-advertise-peer-urls=http://etcd-2:2380'
      - '--initial-cluster-state=new'
      - '--initial-cluster-token=mys3cr3ttok3n'
      - '--initial-cluster=etcd-1=http://etcd-1:2380,etcd-2=http://etcd-2:2380,etcd-3=http://etcd-3:2380'
      - '--listen-client-urls=http://0.0.0.0:2379'
      - '--listen-peer-urls=http://0.0.0.0:2380'
      - '--name=etcd-2'
    ports:
      - 2379
    volumes:
      - etcd2:/etcd_data
    networks:
      - etcd
    environment:
      - ETCD_VERSION=

  etcd-3:
    container_name: etcd3
    image: snw35/etcd:latest
    command:
      - '--advertise-client-urls=http://etcd-3:2379'
      - '--auto-compaction-mode=periodic'
      - '--auto-compaction-retention=1'
      - '--data-dir=/etcd_data'
      - '--election-timeout=1250'
      - '--heartbeat-interval=250'
      - '--initial-advertise-peer-urls=http://etcd-3:2380'
      - '--initial-cluster-state=new'
      - '--initial-cluster-token=mys3cr3ttok3n'
      - '--initial-cluster=etcd-1=http://etcd-1:2380,etcd-2=http://etcd-2:2380,etcd-3=http://etcd-3:2380'
      - '--listen-client-urls=http://0.0.0.0:2379'
      - '--listen-peer-urls=http://0.0.0.0:2380'
      - '--name=etcd-3'
    ports:
      - 2379
    volumes:
      - etcd3:/etcd_data
    networks:
      - etcd
    environment:
      - ETCD_VERSION=

volumes:
  etcd1:
  etcd2:
  etcd3:

networks:
  etcd:
```
