FROM openjdk:13-alpine

ARG scala_version=2.12
ARG kafka_version=2.2.1

ENV SCALA_VERSION=$scala_version
ENV KAFKA_VERSION=$kafka_version
ENV KAFKA_HOME=/opt/kafka-$kafka_version
ENV PATH="$PATH:$KAFKA_HOME/bin"

EXPOSE 9092 29092
WORKDIR /opt

RUN apk --no-cache add bash
RUN wget http://mirror.dsrg.utoronto.ca/apache/kafka/$KAFKA_VERSION/kafka_$SCALA_VERSION-$KAFKA_VERSION.tgz
RUN tar zxf kafka_$SCALA_VERSION-$KAFKA_VERSION.tgz
RUN rm kafka_$SCALA_VERSION-$KAFKA_VERSION.tgz
RUN mv kafka_$SCALA_VERSION-$KAFKA_VERSION kafka-$KAFKA_VERSION

COPY wait-for.sh docker-entrypoint.sh start-kafka.sh /usr/local/bin/
COPY config/ $KAFKA_HOME/config/

ENTRYPOINT ["docker-entrypoint.sh"]
CMD ["kafka-server-start.sh", "$KAKFA_HOME/config/server.properties"]
