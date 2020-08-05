# Apache Spark

Spark is a unified analysis engine for large-scale data processing. Hologres and Saprk (Community Edition and EMR Spark Edition) are efficiently opened up, providing Spark Connector, supporting data from Spark to be written into Hologres in stream or batch mode, and quickly helping enterprises to build data warehouses.

## Supported Spark Versions

2.4.3 or 2.4.3+

## 1. JDBC Connector

Hologres is compatible with the PostgreSQL and provides JDBC/ODBC driver, so Spark can also be written through JDBC. JDBC can implement stream or batch writes, which will be introduced from two scenarios below.

Before you start, download the [Postgres JDBC driver](https://jdbc.postgresql.org/)

### Scenerio 1: Batch Writing

To start Spark-shell you can execute below code

```
./bin/spark-shell --jars /path/to/postgresql-42.2.14.jar
```

Prepare data and configure batch writing detail as below

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
  .save()
```

### Scenerio 2: Streaming Writing

1.Generate JDBC Jar

Community Spark's jdbc is available, so does EMR's jdbc dirver, with micro-batch processing will enhance performance.

Could be used in Spark-shell like below

```
./bin/spark-shell --jars /path_to/emr-jdbc_2.11-2.1.0-SNAPSHOT.jar,/path/to/postgresql-42.2.14.jar --driver-class-path /path_to/emr-jdbc_2.11-2.1.0-SNAPSHOT.jar,/path/to/postgresql-42.2.14.jar
```

2.Data Writing：prepare data and table in Spark, and configure write-in data in streaming mode to do real-time data writing into Hologres

Attention, provider's name is "jdbc2", means it uses EMR jdbc driver. `Option ("batchsize", 100)` represents micro batch processing configuration.

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
  .option("checkpointLocation", checkpointLocation)
  .start()

query.awaitTermination()
```

## 2. Hologres Spark Connector

Write Spark data by calling the Spark connector built-in Hologres:

### Jar Usage

1.Execute blow command to use jar in Spark Shell

EMR Spark Edition

```
spark-shell --jars emr-datahub_shaded_2.11-2.0.0-SNAPSHOT.jar --driver-class-path emr-datahub_shaded_2.11-2.0.0-SNAPSHOT.jar
```

Community Edition

```
spark-shell --jars emr-datahub_shaded_2.11-2.0.0-SNAPSHOT.jar
```

2.Acquire Endpoint of Hologres

To acquire Hologres real-time API endpoint through connector, please execute below command

```
show hg_datahub_endpoints;
```

3.Spark Configuration 

Configure below information in Spark

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

• `batch.size`：In order to improve writing efficiency of micro-batch processing, by deafult, value 1, represents no micro-batch processing, support streaming mode. For batch processing it shall be replaced with other suitable values. 

• `format`: Configured as datahub, write through holo instance by holohub interface.

and `decimal.precision` set up

```
df.option("decimal.precision", 38)
  .option("decimal.scale", 18)
```

### Demo of Writing Data through Connector

1.Create one table for data receiving, data type mapping shall be in accordance

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

2.Scala Code: Execute below command in terminal to open Spark interactive shell where you can write interactive Spark code for result-observing

```
spark-shell --jars emr-datahub_shaded_2.11-2.0.0-SNAPSHOT.jar
```

3.Execute below scala code in Spark Shell, demo showed as below

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

## Data Types Mapping

| Spark | Hologres |
|---|---|
| LONGTYPE | BIGINT |
| STRINGTYPE | TEXT |
| DECIMALTYPE(P,S) | NUMERIC(P,S) |
| BOOLEANTYPE | BOOL |
| DOUBLETYPE | DOUBLE PRECISION |
| TIMESTAMPTYPE | TIMESTAMPTZ |



 













