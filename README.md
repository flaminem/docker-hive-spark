# Hive Metastore + Spark Thriftserver preconfigured docker


This docker can be used as a sandbox for using flamy.



Run this command to build the docker image (might require sudo rights)

```
docker build -t flamy-demo .
```



Then run this from the flamy-demo repository's base directory

```
docker run -it -v `pwd`/warehouse:/data/hive/warehouse -p 127.0.0.1:9083:9083 -p 127.0.0.1:4040:4040 -p 127.0.0.1:10000:10000 flamy-demo
```





