# Orange Workshop

Welcome. ....

![](assets/20250331_121233_Orange_logo.svg.png)

![](assets/20250331_121615_01-hivemq.png)

..

## Preparations :

Have Docker, Docker Compose, Git, PgAdmin (optional) and the HiveMQ CLI installed:

[https://docs.docker.com/engine/install/](https://https://docs.docker.com/engine/install/)

[https://docs.docker.com/compose/install/](https://https://docs.docker.com/compose/install/)

[HiveMQ CLI](https://https://www.hivemq.com/blog/mqtt-cli/)

[PgAdmin](https://https://www.pgadmin.org/download/)

[Git CLI](https://https://git-scm.com/book/en/v2/Getting-Started-Installing-Git) or [GitDesktop](https://https://desktop.github.com/download/)

## Clone

To get the resources please run the following command in your terminal:

```
git clone https://github.com/hivemq/Orange_Workshop.git
```

## Start :

to start please `cd` into the `Orange_Workshop` directory and run the following commands:

```
export HIVEMQ_VERSION=4.38.0
export REDPANDA_VERSION=24.2.7
export REDPANDA_CONSOLE_VERSION=2.7.2
./build.sh # #### run once  
docker-compose up -d  --build --force-recreate
```

## test:

Send some MQTT data towards the Kafka propagation topic

```
mqtt pub -u superuser -pw supersecurepassword -t to-kafka/test -m kamiel
```

See in Redpanda console the MQTT sent message apear in the correct `kafka-topic` topic:

[http://localhost:8090/topics/](http://localhost:8090/topics/)
