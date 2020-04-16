# Apache Flink

Apache Flink is an open-source, distributed stream-processing framework for stateful computations over unbounded and bounded data streams.

This documentation will walk you through how to use Apache Flink to read data in Hologres, as well as joining streaming data with existing data in Hologres via temporal table and temporal table function.


## Hologres Batch Source

Hologres connector right now only supports batch source. 
 
Batch source bulk reads all data of the table as a snapshot, and data is exported at high throughput within a single transaction. If it fails, it will read all data again but as a different snapshot of different time.
 
Currently the source supports projection pushdown. Filter pushdown will be added soon.
 
Hologres batch source is recomended to use with Flink batch jobs.

Each Flink source subtask (parallelism instance) can read one or more Hologres shards, thus it's recommended to set the Flink source parallelism number to be smaller than or equal to Hologres shard number, to avoid wasting resources.

### Usage 

The SQL connector can be defined:

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
);
```


To use batch source in Flink DataStream application:


```java

HologresBulkreadInputFormat inputFormat = new HologresBulkreadInputFormat(
	new JDBCOptions(endpoint, db, table, usrname, pwd), returnRowType, queryTemplate);
	
StreamExecutionEnvironment env = ...

env.createInput(inputFormat, returnTypeInfo)
	....

```


## Hologres Temporal Table and Temporal Table Function

It is a very common use case in real-time data processing to join new data with a few existing datum as point-lookup from massive existing data pool, and the requirements is to do it as fast as possible to achieve throughput. 

Flink can achieve such functionality via Hologres temporal table and temporal table function.

When Hologres table is a row-based table, users can quickly lookup specific rows by primary keys with high throughput, in order to join with something else in Flink pipeline via temporal table functions and temporal table joins.

Click [here](https://ci.apache.org/projects/flink/flink-docs-stable/dev/table/streaming/temporal_tables.html#temporal-tables) to learn more about Flink temporal table and temporal table functions, 

### Usage

#### Hologres Temporal Table Function

To use a temporal table function in Flink, users have to register the function first, and currently the registration can only happen in Flink Table API.

```java
TableEnvironment tEnv = ...

// create Hologres table source
HologresBulkreadTableSource source = new HologresBulkreadTableSource(new JDBCOptions(...), tableSchema);

// register the table source
tEnv.registerTableSource("source", source);

String[] lookupKeys = new String[] {...}

// get and register the table lookup function
tEnv.registerFunction("hologresLookup", source.getLookupFunction(lookupKeys));

```

Then users can run queries like the following, either in Table API or Flink SQL:

```
select * from source, LATERAL TABLE(hologresLookup(a, b))"));
```

#### Hologres Temporal Table

The syntax to define a temporal table in Flink is the same as defining a table source.


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
);
```

Flink uses the SQL syntax of FOR SYSTEM_TIME AS OF to query a temporal table, for instance:


```
// table `src` has three columns: x, y, proc.proctime

select x, a, b, c from src JOIN hologres_table FOR SYSTEM_TIME AS OF src.proc as h ON src.x = h.a AND src.y = h.b;
```


Note:

- Hologres temporal table is synchronous only, and doesn't support async mode.
- Hologres temporal table doesn't support cache yet
- If you have any feature requests, please feel free to submit an issue on [Github](https://github.com/hologres/hologres-issues)

## Data Types Mapping

Please find the mapping [here](/data_load/flink.md).