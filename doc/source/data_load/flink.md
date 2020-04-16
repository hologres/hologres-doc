# Apache Flink

Apache Flink is an open-source, distributed stream-processing framework for stateful computations over unbounded and bounded data streams.

This documentation will walk you through how to use Apache Flink to write data to Hologres in both real-time streaming and batch fashions.

## Supported Flink versions

1.9, 1.10

## Hologres Streaming Sink

What's critically unique about Hologres is that it is a real-time data warehouse that can truly handle streaming use cases. By leveraging Flink and Hologres streaming sink, users can write streaming data from Flink to Hologres, and data is immediately available to query! 

What's better is that Hologres streaming sink can guarantee end-to-end exactly-once semantics even upon failure recoveries.

These characteristics fundamentally change how users imagine about their streaming pipeline, and how fast they can turn data into real values by querying real-time data in Hologres from BI tools.

Hologres streaming sink continuously writes data into Hologres, and should be used in Flink streaming job to continuously writing data into Hologres.


### Semantics

Hologres streaming sink can provide end-to-end exactly-once or at-least-once semantics, depending on configurations of the sink and attributes of the Hologres destination table.

#### End-to-end Exactly-Once Guarantee

When the Hologres destination table is created with primary keys, Hologres streaming sink can guarantee end-to-end exactly-once semantics with Flink via idempotency.

In such scenarios, users can configure the streaming sink's `upsert_type` and tell how Hologres should proceed when multiple records with the same values as primary key are written to the table:
	
- 	`insert-or-ignore`: default semantics, Hologres will keep the first record that it receives and ingore all the following records
-  `insert-or-replace`: the record that comes later will completely replace the existing record
-  `insert-or-update`: the record that comes later will partially replace the existing record.
	- e.g. Let's say we have a table `X` that has 4 columns, `a`, `b`, `c`, `d`, with `a` being the primary key. In the above scenario, when a new record with just two fields `a` and `b` comes, Hologres will only update the value of column `b`, and the values of `c` and `d` of existing data remain unchanged.


#### End-to-end At-Least-Once Guarantee

In all other circumstances, the streaming sink provides at-least-once guarantee.

### Write to Partitioned Tables

By default, the streaming sink can only write to a non-partitioned table. 

To write to a partitioned table, the `'connector.table'` should be the table's name, and users have to enable the sink configuration with `'connector.partition_router'='true'`. If users don't set the configuration, the sink can still write successfully to Hologres but no data will show up.

When writing to a partitioned table, partitions will not be created automatically, so users have to create those partitions before hand.


### Usage

The SQL connector can be defined as:

```
create table mysource(
  ...
) with (
  'connector.type'='hologres',  ---- required: specify this table type is hologres
  'connector.database'='...',   ---- required: hologres database name
  'connector.table'='...',      ---- required: hologres table name, can be of format '<schema>.<table>' or just 'table'
  'connector.username'='...',   ---- required: hologres username
  'connector.password'='...',   ---- required: hologres password
  'connector.endpoint'='<ip>:<port>', ---- required: hologres endpoint
  
  ---- optional params
  'connector.upsert_type'='...',       ---- optional: semantics for streaming sink, see details below. default: insertorignore
  'connector.partition_router'='...'   ---- optional: used when writing to partitioned table, see details below. default: false
);

```

To use streaming sink in Flink DataStream application:

```java
DataStream<...> dataStream = ...

HologresOutputFormat outputFormat = new HologresOutputFormat(
	new ConnectionParam(new JDBCOptions(endpoint, db, table, usrname, pwd)));
	
dataStream.writeUsingOutputFormat(outputFormat);

...
```


## Hologres Batch Sink

Hologres batch sink bulk loads data into Hologres. All data is loaded within a single transaction, so either all data is loaded successfully or none is loaded, and thus it guarantees end-to-end exactly-once. 

Data is invisible in the middle of the transaction, and only becomes visible once the bulk load transaction finishes.


Hologres batch sink is optimized for high thoughput write.

Hologres streaming sink should be used in Flink batch job, for use cases like data migration and backfill.

### Write to Partitioned Tables

Hologres batch sink can only write to a partition of a partitioned table.

### Usage

The SQL connector can be defined as:

```
create table mysource(
  ...
) with (
  'connector.type'='hologres',  ---- required: specify this table type is hologres
  'connector.database'='...',   ---- required: hologres database name
  'connector.table'='...',      ---- required: hologres table name, can be of format '<schema>.<table>' or just 'table'
  'connector.username'='...',   ---- required: hologres username
  'connector.password'='...',   ---- required: hologres password
  'connector.endpoint'='<ip>:<port>', ---- required: hologres endpoint
  'connector.bulkload'='true',  ---- required: enable bulkload mode
  
  ---- optional params
  'connector.field_delimiter'='...'   ---- optional: delimiter between fields of a row when importing data into Hologres. default: '\u0002'
);

```


It's not recommended to use batch sink in Flink DataStream application, as its implementation is quite complicated. However, if you really wish to use it, please reference the source code of `HologresBulkloadTableSink`.

## Data Types Mapping


| Flink | Hologres |
|---|---|
| STRING | STRING |
| BTYES | BYTEA |
| BOOLEAN | BOOLEAN |
| SMALLINT | SMALLINT |
| INT | INTEGER |
| BIGINT | BIGINT |
| FLOAT  | REAL |
| DOUBLE | DOUBLE PRECISION |
| DECIMAL(P,S) | NUMERIC(P,S) |
| DATA | DATE |
| TIMESTAMP | TIMESTAMP |
| ARRAY<T> | ARRAY<T> |
