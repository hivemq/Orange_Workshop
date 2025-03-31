# Orange Workshop

Welcome. ....

## Preparations :

Have Docker, Docker Compose and the HiveMQ CLI installed:

[https://docs.docker.com/engine/install/](https://https://docs.docker.com/engine/install/)

[https://docs.docker.com/compose/install/](https://https://docs.docker.com/compose/install/)

[HiveMQ CLI](https://https://www.hivemq.com/blog/mqtt-cli/)

[Git CLI](https://https://git-scm.com/book/en/v2/Getting-Started-Installing-Git) or [GitDesktop](https://https://desktop.github.com/download/)

## Clone

git clone https://github.com/hivemq/Orange_Workshop.git

## start :

to start please run the following command in your terminal

```
export HIVEMQ_VERSION=4.38.0
export REDPANDA_VERSION=24.2.7
export REDPANDA_CONSOLE_VERSION=2.7.2
./build.sh
docker-compose up -d  --build --force-recreate
```

## test:

```
mqtt pub -u superuser -pw supersecurepassword -t to-kafka/test -m kamiel
http://localhost:8090/topics/
```
