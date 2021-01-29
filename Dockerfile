FROM wurstmeister/kafka:latest

RUN echo "ssl.endpoint.identification.algorithm=" >> /opt/kafka/config/server.properties