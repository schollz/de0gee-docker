#!/bin/bash

service stop mosquitto
pkill -9 mosquitto
if [ ! -d /app/mosquitto_config ]; then
	cp -r /app/mosquitto_config /data/
fi
mkdir /data/logs
/usr/bin/supervisord