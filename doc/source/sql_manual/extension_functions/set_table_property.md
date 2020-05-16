# SET_TABLE_PROPERTY

## Introduction

set_table_property: Set the table properties includes index, distribution keys, columnar/row store, TTL ...
## Synopsis

```sql
CALL SET_TABLE_PROPERTY ( table_name, property, value )

where property in
	orientation
  clustering_key
  segment_key
  bitmap_columns
  dictionary_encoding_columns
  time_to_live_in_seconds
  distribution_key
```
## Parameters

_**table_name:**_ The name of the new table which could belongs to some schema. The names can contain only alphanumeric characters or an underscore(_). The first character must be an alphabetic character. All alphabetic characters are treated as lower case because the table name is case insensitive._

_**property**_ : property name.

_**orientation**_:Indicates columnar or row store. Should be specified in the same transaction of creating table. 

_**clustering_key**_ :Creating clustering index on specified columns. Should be specified in the same transaction of creating table. 

_**segment_key**_ :Segment key is used to split the data into files. Specifying a column(Ex: event_time) as segment key could benefit the queries which has a where clause on the segment key. Should be specified in the same transaction of creating table. 

_**bitmap_columns**_ : Create bitmap index on specified columns. It benefits the filtering on the columns on which have it. Can be a stand alone command.

_**dictionary_encoding_columns:**_Create a mapping dictionary for specified columns. It benefits filtering comparison, aggregation, joins. Can be a stand alone command.

_**distribution_key**_ :Declares the distribution policy. Should be specified in the same transaction of creating table. 

_**time_to_live_in_seconds**_ : Indicates the data expiration period. The precision is one second. It must be a non-negative integer or float number. Can be a stand alone command.

_**value**_ : Property value. Use double quotes(") to enclose it if it contains column names in which has upper case alphabetic characters.

## Example

```sql
BEGIN;
CREATE TABLE ORDERS ( 
  O_ORDERKEY 			 INTEGER NOT NULL,
  O_CUSTKEY        INTEGER NOT NULL,
  O_ORDERSTATUS    TEXT NOT NULL,
  O_TOTALPRICE     DECIMAL(15,2) NOT NULL,
  O_ORDERDATE      DATE NOT NULL,
  O_ORDERPRIORITY  TEXT NOT NULL,  
  O_CLERK          TEXT NOT NULL, 
  O_SHIPPRIORITY   INTEGER NOT NULL,
  O_COMMENT        TEXT NOT NULL);
CALL SET_TABLE_PROPERTY ('ORDERS', 'clustering_key', 'O_ORDERKEY:asc,O_CUSTKEY:asc');
CALL SET_TABLE_PROPERTY ('ORDERS', 'segment_key', 'O_ORDERDATE');
CALL SET_TABLE_PROPERTY ('ORDERS', 'bitmap_columns', 'O_ORDERSTATUS,O_ORDERPRIORITY,O_CLERK,O_SHIPPRIORITY');
CALL SET_TABLE_PROPERTY ('ORDERS', 'dictionary_encoding_columns', 'O_ORDERSTATUS,O_ORDERPRIORITY,O_CLERK,O_SHIPPRIORITY');
CALL SET_TABLE_PROPERTY ('ORDERS', 'time_to_live_in_seconds', '172800');
COMMIT;
```