```
docker build -t de0gee .
docker run --rm -p 11883:1883 -p 8003:8003 -v /tmp/data:/data -t de0gee
```