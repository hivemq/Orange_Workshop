# Additional build image to unpack the zip file and change the permissions without retaining large layers just for those operations
FROM alpine:3.20@sha256:beefdbd8a1da6d2915566fde36db9db0b524eb737fc57cd1367effd16dc0d06d AS unpack

ARG HIVEMQ_VERSION

COPY hivemq-${HIVEMQ_VERSION}.zip /tmp/hivemq.zip
RUN unzip /tmp/hivemq.zip -d /opt \
    && mv /opt/hivemq-${HIVEMQ_VERSION} /opt/hivemq \
    && rm -rf /opt/hivemq/tools/hivemq-swarm
COPY config.xml /opt/hivemq/conf/config.xml

COPY hivemq-prometheus-extension-4.0.12.zip /tmp/hivemq-prometheus-extension-4.0.12.zip
RUN unzip /tmp/hivemq-prometheus-extension-4.0.12.zip -d /opt/hivemq/extensions 



# COPY ESE configfile from local resources-ese/*.* into image.
COPY ./resources-ese/*.* /opt/hivemq/extensions/hivemq-enterprise-security-extension/conf

# COPY kafka configfile from local resources-kafka/*.* into image.
COPY ./resources-kafka/*.* /opt/hivemq/extensions/hivemq-kafka-extension/conf

# COPY Postgress configfile from local resources-kafka/*.* into image.
COPY ./resources-postgres/*.* /opt/hivemq/extensions/hivemq-postgresql-extension/conf


RUN find /opt/hivemq -type d -print0 | xargs -0 chmod 750 \
    && find /opt/hivemq -type f -print0 | xargs -0 chmod 640 \
    # files that need execute permissions
    && chmod 750 /opt/hivemq/**/*.sh \
    && chmod 750 /opt/hivemq/tools/mqtt-cli*/bin/mqtt || true \
    && chmod 750 /opt/hivemq/extensions/hivemq-enterprise-security-extension/helper/linux/hivemq-ese-helper || true \
    # directories that need write permissions
    && chmod 770 /opt/hivemq/audit \
    && chmod 770 /opt/hivemq/backup \
    && chmod 770 /opt/hivemq/conf \
    && chmod 770 /opt/hivemq/data \
    && chmod 770 /opt/hivemq/extensions \
    && chmod 770 /opt/hivemq/extensions/* \
    && chmod 770 /opt/hivemq/extensions/*/conf || true \
    && chmod 770 /opt/hivemq/extensions/hivemq-amazon-kinesis-extension/customizations || true \
    && chmod 770 /opt/hivemq/extensions/hivemq-enterprise-security-extension/drivers || true \
    && chmod 770 /opt/hivemq/extensions/hivemq-enterprise-security-extension/drivers/jdbc || true \
    && chmod 770 /opt/hivemq/extensions/hivemq-google-cloud-pubsub-extension/customizations || true \
    && chmod 770 /opt/hivemq/extensions/hivemq-kafka-extension/customizations || true \
    && chmod 770 /opt/hivemq/extensions/hivemq-kafka-extension/local-schema-registry || true \
    && chmod 770 /opt/hivemq/license \
    && chmod 770 /opt/hivemq/log \
    # files that need write permissions
    && chmod 660 /opt/hivemq/conf/config.xml \
    && chmod 660 /opt/hivemq/conf/logback.xml \
    && chmod 660 /opt/hivemq/conf/tracing.xml \
    && chmod 660 /opt/hivemq/extensions/*/DISABLED || true \
    && chmod 660 /opt/hivemq/extensions/*/hivemq-extension.xml || true


# Actual image
FROM eclipse-temurin:21.0.4_7-jre-jammy@sha256:d1c536be5ba42ea6d793b8eb67b8ced61fc66ae2c168d6c612113ebca661dd96

# ******************* Please enable / disable runtime options below  *******************

# Additional JVM options, may be overwritten by user
ENV JAVA_OPTS="-XX:+UnlockExperimentalVMOptions -XX:+UseNUMA"

# Default allow all extension, set this to false to disable it
ENV HIVEMQ_ALLOW_ALL_CLIENTS=true

# Enable ESE, set this to false to disable it
ENV HIVEMQ_ENABLE_ESE=false

# Enable Kafka extention, set this to false to disable it
ENV HIVEMQ_ENABLE_KAFKA=false

# Enable Postgres extention, set this to false to disable it
ENV HIVEMQ_ENABLE_POSTGRES=true

# Enable REST API default value
ENV HIVEMQ_REST_API_ENABLED=true

# Whether we should print additional debug info for the entrypoints
ENV HIVEMQ_VERBOSE_ENTRYPOINT=false

# Set locale
ENV LANG=en_US.UTF-8

# As the user id that runs the container (10000 by default) does not have an entry in /etc/passwd, set the home directory explicitly.
# If not set, HOME would default to "/".
# Java uses this value for the system property "user.home" (used for example by the mqtt-cli).
ENV HOME=/opt/hivemq

# HiveMQ entrypoint
COPY --chmod=755 docker-entrypoint.sh /opt/docker-entrypoint.sh
COPY --chmod=644 20_handle_envs.sh /docker-entrypoint.d/20_handle_envs.sh
COPY --chmod=644 30_enable_ese.sh /docker-entrypoint.d/30_enable_ese.sh
COPY --chmod=644 40_enable_kafka.sh /docker-entrypoint.d/40_enable_kafka.sh
COPY --chmod=644 50_enable_postgres.sh /docker-entrypoint.d/50_enable_postgres.sh

RUN mkdir -p /docker-entrypoint.d

# HiveMQ
COPY --from=unpack /opt/hivemq /opt/hivemq
RUN chmod 770 /opt/hivemq

# Make broker data persistent throughout stop/start cycles
VOLUME /opt/hivemq/data

# Persist log data
VOLUME /opt/hivemq/log

# MQTT TCP listener: 1883
# MQTT Websocket listener: 8000
# HiveMQ Control Center: 8080
# HiveMQ API : 8888
# prometius ext : 9399
EXPOSE 1883 8000 8080 8888 9399


WORKDIR /opt/hivemq

ENTRYPOINT ["/opt/docker-entrypoint.sh"]
CMD ["/opt/hivemq/bin/run.sh"]

USER 10000

