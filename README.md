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
 
 * insert ip address of host machine file under `HOST_ADDRESS` key or leave localhost.
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

### 4.1 Consumer

To start consumer from terminal:

```
kafka-console-consumer --bootstrap-server localhost:9092 --topic TEST_TOPIC_1 --from-beginning --consumer.config ./client/client-ssl.properties 
```

### 4.2 Producer

To start producer from terminal:

```
kafka-console-producer --broker-list localhost:9092 --topic TEST_TOPIC_1 --producer.config ./client/client-ssl.properties 
```


## 5. Administration

### 5.1 List topics


```
kafka-topics --command-config ./client/client-ssl.properties --list --bootstrap-server localhost:9092
```

### 5.2 Create Topic


```
kafka-topics --command-config ./client/client-ssl.properties --create --topic <topic-name> --partitions <partitions> --replication-factor <replication_factor> --bootstrap-server localhost:9092
```

  topic-name - name of topic
  partitions - number of partitions of topic
  replication-facotr - number of replications, must be equal or lower than number of brokers


Examples:
```
kafka-topics --command-config ./client/client-ssl.properties --create --topic TEST_TOPIC_3 --partitions 1 --bootstrap-server localhost:9092
```



## 6. Assets

### 6.1 SSL certificates and keys

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

### 6.2 Kafka client ssl config

Config for kafka client ssl is in `client` directory:

 * `client-ssl.properties` - config for consumer and producer to use client certificate.


## 8. FAQ

### 8.1 Got error: `Error while fetching metadata with correlation id 22 : {TOPIC_NAME=LEADER_NOT_AVAILABLE} (org.apache.kafka.clients.NetworkClient)`

Check your `HOST_ADDRESS` in .env file

