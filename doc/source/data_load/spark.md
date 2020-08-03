# Apache Spark

## 1. Holohub Connector（write)

### Jar Usage

1.Emr Spark Sample

```
spark-shell --jars emr-datahub_shaded_2.11-2.0.0-SNAPSHOT.jar --driver-class-path emr-datahub_shaded_2.11-2.0.0-SNAPSHOT.jar
```

2.Spark Sample--Community Edition

```
spark-shell --jars emr-datahub_shaded_2.11-2.0.0-SNAPSHOT.jar
```

### Configuration Options

```
df.write
  .format("datahub")
  .option("access.key.id", "yourAccessKeyId")
  .option("access.key.secret", "yourAccessKeySecret")
  .option("endpoint", "datahubEndpoint")
  .option("project", "yourDatabase")
  .option("topic, "yourTable")
  .option("batch.size", "100")
  .save()
```

Highlight：

• batch.size：In order to improve writing efficiency of micro-batch processing, by deafult, value 1, represents no micro-batch processing, support streaming mode. For batch processing it shall be replaced with other suitable values. 

• format: Configured as datahub, write through holo instance by holohub interface.

and decimal precision set up

```
df.option("decimal.precision", 38)
  .option("decimal.scale", 18)
```

### One Sample

Create one test table in hologres

```
BEGIN;
CREATE TABLE tb001 (
  product_id BIGINT,
  product_name TEXT,
  price NUMERIC(38, 18),
  out_of_stock bool,
  weight double precision,
  ts timestamptz
);
COMMIT;
```

Scala Code: Execute below command in terminal

```
spark-shell --jars emr-datahub_shaded_2.11-2.0.0-SNAPSHOT.jar
```

And then execute below scala code in spark-shell

```
val data = Seq(
      Row(1L, "iphone", 1234.56, false, 123.45, "2020-05-21 00:00:00"),
      Row(2L, "Huawei", 1234.56, true, 123.45, "2020-05-21 00:00:00")
)

// supported data types
val schema = StructType(Array(
  StructField("product_id", LongType),
  StructField("product_name", StringType),
  StructField("price", DecimalType),
  StructField("out_of_stock", BooleanType),
  StructField("weight", DoubleType),
  StructField("ts", TimestampType)
))

val df = spark.createDataFrame(
  spark.sparkContext.parallelize(data),
  schema
)

df.write
  .format("datahub")
  .option(DatahubSourceProvider.OPTION_KEY_ACCESS_ID, 'my_accessKeyId')
  .option(DatahubSourceProvider.OPTION_KEY_ACCESS_KEY, 'my_accessKeySecret')
  .option(DatahubSourceProvider.OPTION_KEY_ENDPOINT, 'hgxxxx.xxxx.xxx:80')
  .option(DatahubSourceProvider.OPTION_KEY_PROJECT, 'testdb')
  .option(DatahubSourceProvider.OPTION_KEY_TOPIC, 'tb001)
  .option("decimal.precision", 38)
  .option("decimal.scale", 18)
  .option("batch.size", "100")
  .save()
```

## 2. JDBC Connector

### Batch Writing

Use spark jdbc connector directly, one example below, download postgres jdbc jar file

```
./bin/spark-shell --jars postgresql-42.2.14.jar
```

```
import org.apache.spark.sql.types._
import org.apache.spark.sql.Row

val data = Seq(
    Row(1L, "test"),
    Row(2L, "test2"),
    Row(3L, "test2"),
    Row(4L, "test2"),
    Row(5L, "test2"),
    Row(6L, "test2")
)
val schema = StructType(Array(
 StructField("a", LongType),
 StructField("b", StringType)
))

val df = spark.createDataFrame(spark.sparkContext.parallelize(data),schema)

// .option("checkpointLocation", checkpointLocation)
df.write.format("jdbc")
  .option("url", "jdbc:postgresql://hgcn-xxx.yyy.zzz:80/db001")
  .option("driver", "org.postgresql.Driver")
  .option("dbtable", "tb001")
  .option("user", "Lxxxxxxxx")
  .option("password", "Dyyyyyyyyyyyyyyyyyyyy")
  .option("isolationLevel", "NONE")
  .save()
```

### Streaming Mode

Spark's jdbc is available, so does emr's jdbc dirver, with micro-batch processing will enhance performance.
Download emr jdbc driver

```
git clone https//github.com/aliyun/aliyun-emapreduce-sdk.git
git checout -b master-2.x origin/master-2.x
mvn -pl emr-jdbc clean package -DskipTests
```

Compile  to generate emr jdbc dirver: emr-jdbc_2.11-2.1.0-SNAPSHOT.jar

Could be used in spark-shell like below

```
./bin/spark-shell --jars /path_to/emr-jdbc_2.11-2.1.0-SNAPSHOT.jar,postgresql-42.2.14.jar --driver-class-path /path_to/emr-jdbc_2.11-2.1.0-SNAPSHOT.jar,postgresql-42.2.14.jar
```

One scala example:

Attention, provider's name is "jdbc2", means it uses emr jdbc driver. Option ("batchsize",100) represents micro batch processing configuration.

```
val wordCounts = lines.flatMap(_.split(" ")).groupBy("value").count()

val query = wordCounts.writeStream
  .outputMode("complete")
  .format("jdbc2")
  .option("url", url)
  .option("driver", "org.postgresql.Driver")
  .option("dbtable", table)
  .option("user", user)
  .option("password", pwd)
  .option("batchsize", 100)
  .option("isolationLevel", "NONE")
  .option("checkpointLocation", checkpointLocation)
  .start()

query.awaitTermination()
```
