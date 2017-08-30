# Hive Metastore + Spark Thriftserver preconfigured docker


This docker can be used as a sandbox for testing [flamy](https://github.com/flaminem/flamy).
It is required to run the second part of [flamy's demo](http://flamy.readthedocs.io/en/latest/Demo.html).

### Building image
Run this command to build the docker image (might require sudo rights)

```
docker build -t docker-hive-spark .
```


### Running the image
Then run this from the flamy-demo repository's base directory
```
docker run --rm -e USER=`id -u -n` -e USER_ID=`id -u` -it -v `pwd`/data:/data/hive -p 127.0.0.1:9083:9083 -p 127.0.0.1:4040:4040 -p 127.0.0.1:10000:10000 docker-hive-spark
```

It will start a docker that will automatically:
- expose a running Metastore on the port 9083
- expose a running Spark ThriftServer (similar to HiveServer2) on port 10000
- expose the Spark GUI to follow job progress on port 4040
- start a beeline terminal


*In case you wonder what the part with the USER and USER_ID is about: 
it is a kind of docker-voodoo-danse to prevent docker writing stuff as root in the external volume.*


### Accessing Amazon s3
This docker has Hive and Spark preconfigured to support Hive tables on Amazon s3.
You must pass your credentials to the docker by adding these options to the above `docker run` command.
Of course you shall replace the dots with the correct values.
```
-e AWS_ACCESS_KEY_ID=... -e AWS_SECRET_ACCESS_KEY=...
```

Next, you can create a table with 
```
CREATE EXTERNAL TABLE my_db.mytable (columns ...) 
LOCATION "s3a://my_bucket/my/table/path"
```

Please note the `EXTERNAL` keyword which is highly recommended if you don't want to lose the data when the table
is dropped (s3 doesn't implemented hdfs's Trash...).
Please also note that the location starts with `s3a`, and not `s3` or `s3n`.



