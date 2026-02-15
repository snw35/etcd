# etcd

* ![Build Status](https://github.com/snw35/etcd/actions/workflows/update.yml/badge.svg)
* [Dockerhub: snw35/etcd](https://hub.docker.com/r/snw35/etcd)

Automatically updated etcd container. The backbone of kubernetes clusters, etcd can be run standalone as a general purpose, high-speed, resilient key-value store.

## How To Use

This container complies with the official image specifications and runs `etcd` as its default entrypoint. It is recommended to run via docker-compose for a multi-member etcd cluster. See the `docker-compose.yaml` file, or clone the repository and run `docker compose up -d` to start a three-member lightweight etcd cluster locally.

**NOTE:** for etcd versions 3.4.2 and below, you will need to set ETCD_VERSION to an empty string (or unset it) at runtime or etcd will exit on startup: https://github.com/etcd-io/etcd/issues/11210
