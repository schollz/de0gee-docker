FROM ubuntu:17.10

RUN apt-get update
RUN apt-get -y upgrade
RUN apt-get install -y git wget curl vim g++ sqlite3


# Install mosquitto
RUN apt-get install -y mosquitto-clients mosquitto

# Install Python
RUN apt-get install -y python3 python3-dev python3-pip
RUN apt-get install -y python3-scipy python3-flask python3-sklearn python3-numpy
RUN python3 -m pip install ujson pytest pytest-benchmark pytest-cov base58 extendeddict tqdm

# Install Go
RUN wget https://storage.googleapis.com/golang/go1.9.3.linux-amd64.tar.gz
RUN tar -C /usr/local -xzf go1.9.3.linux-amd64.tar.gz
RUN rm go1.9*
ENV PATH="/usr/local/go/bin:${PATH}"
RUN mkdir /usr/local/work
ENV GOPATH /usr/local/work

# Setup supervisor
RUN apt-get install -y supervisor

RUN echo "v0.0.1"
RUN go get -v github.com/de0gee/de0gee-data
RUN go install -v github.com/de0gee/de0gee-data
WORKDIR /usr/local/work/src/github.com/de0gee/
RUN git clone https://github.com/de0gee/de0gee-ai


# remove things
RUN apt-get purge -y g++ wget curl git

RUN mkdir /data
RUN mkdir /app
WORKDIR /app
COPY startup.sh /app/startup.sh
RUN chmod +x /app/startup.sh
COPY supervisord.conf /etc/supervisor/conf.d/supervisord.conf
COPY mosquitto.conf /app/mosquitto_config/mosquitto.conf
RUN touch /app/mosquitto_config/acl
RUN touch /app/mosquitto_config/passwd

# Startup
CMD ["/app/startup.sh"]
