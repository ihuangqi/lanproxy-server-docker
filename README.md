# 1. Quick Start
```shell
docker run -d \
           --name lanproxy-server \
           -p 8090:8090 \
           -p 4900:4900 \
           -p 4993:4993 \
           -p 9000-9100:9000-9100 \
           ihuangqi/lanproxy-server
```

The usable port is 9000-9100

# 2. More
look at [https://github.com/ffay/lanproxy](https://github.com/ffay/lanproxy)