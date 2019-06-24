#!/bin/sh
exec wait-for.sh $KAFKA_ZOOKEEPER_CONNECT -- kafka-server-start.sh $KAFKA_HOME/config/server.properties
