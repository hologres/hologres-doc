# Comparisons to Other Products

## Hologres V.S. Traditional Data Warehouse

### Apache Hive

### AWS Redshift

### Snowflake


## Hologres V.S. Real-time/Time-series Database

### Druid, Clickhouse, 



### HBase, Cassandra


### Kudu

| Hologres | Kudu |
|---|---|
| Feature complete itself, include storage and service | Storage only, must be used with Impala for OLAP |
| Fast in both point-lookup query and analytical query | Point-lookup is slower than HBase/Cassandra, and analytics is slower than Druid/ClickHouse |


### BigQuery

| Hologres | BigQuery |
|---|---|
| Deploy anywhere, any cloud | Tightly coupled with Google Cloud, vendor lockin |
| Native Flink connectors | Streaming data from Google Dataflow/Beam, no direct integration with Flink |
| Charge by machines in hosted solution, much cheaper | Charge by volume of data scanned |



## Hologres V.S. Data Lake

Data Lake setups like Apache Iceberg, Apache  Hudi, Delta Lake are mostly libraries plus a cloud distributed file system. They are poor man, open-source version of commercial data warehouses.
 
Given they are libraries maintaining data on top of commodity storage, Data Lakes have to be used with Spark or Presto.

Fits better with mini-batch processing engine like Spark, but not Flink
No native streaming support
Data latency depends on how frequently files are commited
No point-lookup support
They are libaraies not services, thus their capabilities are limited and operation cost is very high. 
E.g. 
No compaction to compact small files as their number grows
No TTL support


## Disclaimer

These are some rough, high-level comparisons based on our own research. Since we are not deep technical experts in all the above technologies. If you find any inaccurate information, please inform us, and we will update as soon as possible.
 
