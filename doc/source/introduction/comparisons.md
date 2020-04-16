# Comparisons to Other Product


## Hologres V.S. Traditional Data Warehouse

### Apache Hive

### AWS Redshift

### Snowflake


## Hologres V.S. Real-time/Time-series Database

### Druid, Clickhouse, 


### HBase, Cassandra


### Kudu

- Must be used with Impala
- Point-lookup is slower than HBase and Cassandra, and analytics is slower than Druid and ClickHouse


## Hologres V.S. Data Lake

Data lake setups like Apache Iceberg, Hudi, Delta Lake are mostly libraries plus a cloud distributed file system. They are poor man, open-source version of commercial offline data warehosue.
 
Usually combined with Spark or Presto
Fits better with mini-batch processing engine like Spark, but not Flink
No native streaming support
Data latency depends on how frequently files are commited
No point-lookup support
They are libaraies not services, thus their capabilities are limited and operation cost is very high. 
E.g. 
No compaction to compact small files as their number grows
No TTL support
 
