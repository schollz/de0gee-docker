```
docker build -t de0gee .
mkdir /tmp/de0gee
docker run -p 11883:1883 -p 8003:8003 -v /tmp/de0gee:/data -t de0gee
```