#!/bin/sh

echo "===== Checking ENV variables ========="
if [[ -z $KAFKA_HOME ]] ; then
    echo "No KAFKA_HOME has been set!"
    exit 1
fi

for var in KAFKA_ZOOKEEPER_CONNECT KAFKA_LISTENERS KAFKA_ADVERTISED_LISTENERS KAFKA_LISTENER_SECURITY_PROTOCOL_MAP KAFKA_INTER_BROKER_LISTENER_NAME ; do
    if [[ -z `printenv $var` ]] ; then
        echo "Please ensure the $var is set. Exiting"
        exit 1
    fi
done

# Update server config properties file
echo "===== Updating configuration file ===="
sed "s|^\(zookeeper.connect=\).*|\1$KAFKA_ZOOKEEPER_CONNECT|g" $KAFKA_HOME/config/server.properties | \
    sed "s|^\(listeners=\).*|\1$KAFKA_LISTENERS|g" | \
    sed "s|^\(advertised.listeners=\).*|\1$KAFKA_ADVERTISED_LISTENERS|g" | \
    sed "s|^\(listener.security.protocol.map=\).*|\1$KAFKA_LISTENER_SECURITY_PROTOCOL_MAP|g" | \
    sed "s|^\(inter.broker.listener.name=\).*|\1$KAFKA_INTER_BROKER_LISTENER_NAME|g"  > $KAFKA_HOME/config/server.properties


echo "===== Starting Kafka Application ====="
exec "$@"
