# Hive Metastore + Spark Thriftserver preconfigured docker


This docker can be used as a sandbox for using flamy.



Run this command to build the docker image (might require sudo rights)

```
docker build -t flamy-demo .
```



Then run this from the flamy-demo repository's base directory

```
docker run -e USER=`id -u -n` -e USER_ID=`id -u` -it -v `pwd`/data:/data/hive -p 127.0.0.1:9083:9083 -p 127.0.0.1:4040:4040 -p 127.0.0.1:10000:10000 fpin/docker-hive-spark
```

It will start a docker that will automatically:
- expose a running Metastore on the port 9083
- expose a running Spark ThriftServer (similar to HiveServer2) on port 10000
- expose the Spark GUI to follow job progress on port 4040
- start a beeline terminal


*In case you wonder what the part with the USER and USER_ID is about: 
it is a kind of docker-voodoo-danse to prevent docker writing stuff as root in the external volume.*









