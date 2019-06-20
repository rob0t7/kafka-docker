FROM openjdk:13-alpine

ARG KAFKA_VERSION=2.12-2.2.0
ENV KAFKA_HOME=/opt/kafka_$KAFKA_VERSION

EXPOSE 9092
WORKDIR /opt

RUN apk --no-cache add bash && \
        wget http://mirror.dsrg.utoronto.ca/apache/kafka/2.2.0/kafka_2.12-2.2.0.tgz && \
        tar zxf kafka_2.12-2.2.0.tgz && \
        rm kafka_2.12-2.2.0.tgz
COPY wait-for.sh .
COPY config/ kafka_2.12-2.2.0/config/

CMD ["/opt/kafka_2.12-2.2.0/bin/kafka-server-start.sh", "/opt/kafka_2.12-2.2.0/config/server.properties"]
