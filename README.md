# Orange Workshop

Welcome. ....




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