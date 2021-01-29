# Kafka with 2-way ssl authentication

Kafka docker with ssl support based on https://github.com/wurstmeister/kafka-docker.

## 1. Tools

### 1.1. Required

 * docker - https://docs.docker.com/get-docker/
 * docker-compose - https://docs.docker.com/compose/install/


### 1.2 Optional

 * kafka - https://kafka.apache.org/downloads
   * if you want `kafka-console-consumer` and `kafka-console-producer` tools


## 2. Build

Build docker image `kafka-ssl` with command:

```
docker build -t kafka-ssl .
```

## 3. Run and stop

### 3.1 Prerequisites

Before running kafka edit `.env` file:
 
 * insert ip address of host machine file under `HOST_ADDRESS` key.
 * set topic definition under `KAFKA_TOPICS`, each topic is separated by comma `,`
 	* `[TOPIC_NAME_1:#PARTITIONS:#REPLICAS],[TOPIC_NAME_2:#PARTITIONS:#REPLICAS]`
 	* default: `TEST_TOPIC_1:2:1,TEST_TOPIC_2:2:1`


### 3.2 Run

```
docker-compose up -d
```

### 3.3 Stop

```
docker-compose down
```


## 4. Consumer and producer testing

### Consumer

To start consumer from terminal:

```
kafka-console-consumer --bootstrap-server localhost:9092 --topic TEST_TOPIC_1 --from-beginning --consumer.config ./client/client-ssl.properties 
```

### Producer

To start producer from terminal:

```
kafka-console-producer --broker-list localhost:9092 --topic TEST_TOPIC_1 --producer.config ./client/client-ssl.properties 
```


## 5. Assets

### 5.1 SSL certificates and keys

SSL assets for kafka is in `ssl` directory:

 * `ca.cer` - CA certificate
 * `client.cer` - client certificate
 * `client.jks` - client keystore in jks format
 * `client.p12` - client keystore in pkcs12 format
 * `server.cer` - server certificate in jks format 
 * `server.jks` - server keystore in jks format
 * `server.p12` - server keystore in pkcs12 format
 * `truststore.jks` - truststore with ca, server and client certificates


Password for all keystores/trustores is `secret`

### 5.2 Kafka client ssl config

Config for kafka client ssl is in `client` directory:

 * `client-ssl.properties` - config for consumer and producer to use client certificate.

