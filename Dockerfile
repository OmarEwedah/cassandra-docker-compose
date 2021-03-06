# Cassandra 3.9 Dockerfile
#
# https://github.com/oscerd/docker-cassandra

# Pull base image.
FROM oscerd/java:oraclejava8

# Download and extract Cassandra
RUN mkdir /opt/cassandra
RUN cd /tmp/
RUN wget -O - http://archive.apache.org/dist/cassandra/3.9/apache-cassandra-3.9-bin.tar.gz | tar xzf - --strip-components=1 -C "/opt/cassandra"

COPY . /src

# Setting up environment variables
ENV MAX_HEAP_SIZE 2G
ENV HEAP_NEWSIZE 800M

# Copy over daemons
RUN cp /src/cassandra.yaml /opt/cassandra/conf/
RUN mkdir -p /etc/service/cassandra
RUN cp /src/start-cassandra /etc/service/cassandra/run
RUN chmod +x /etc/service/cassandra/run

# Expose ports
EXPOSE 7000 7001 7199 9160 9042
# install Python 2.7
RUN apt-get update
RUN apt-get install python -y
RUN apt-get clean 
RUN rm -rf /var/lib/apt/lists/* 
RUN rm -rf /tmp/* 
RUN rm -rf /var/tmp/*

CMD ["/sbin/my_init"]
