# CREATE TABLE

# Create Table
<a name="5or05"></a>
## Introduction
create table 
<a name="Kv9kC"></a>
## Synopsis


```sql
begin;
create table [if not exists] [schema_name.]table_name ([
  {
   column_name column_type [column_constraints, [...]]
   | table_constraints
   [, ...]
  }
]);

call set_table_property('<table_name>', property, value);
commit;

```
<a name="numBj"></a>
## Parameters

1. column_type is the data type of the field. please refer to data type for all supported data types.
1. Column constraints 'column_constraints' and table constraints 'table_constraints' are as follows:
| Parameter   | column_constraints | table_constraints |
| ----------- | ------------------ | ----------------- |
| primary key | supported          | supported         |
| not null    | supported          | -                 |
| null        | supported          | -                 |
| unique      | not supported      | not supported     |
| check       | not supported      | not supported     |
| default     | not supported      | not supported     |

3.set_table_property is used to set properties of the table, see below for details.
<a name="OW3CF"></a>
## Limitation
1.column_constraints can only use one column as primary key，while table_constraints can use multiple columns as primary key.<br />2.Table names and column names are not case sensitive. If you need to define uppercase or special character for table names, or column names, you can use double quotes "". For example:
```sql
create table "TBL" (a int);
select relname from pg_class where relname = 'TBL';
insert into "TBL" values (-1977);
select * from "TBL";
------------------------------------------------------------------
begin;
create table tbl ("C1" int not null);
call set_table_property('tbl', 'clustering_key', '"C1"');
commit;
------------------------------------------------------------------
begin;
create table tbl ("C1" int not null, c2 text);
call set_table_property('tbl', 'clustering_key', '"C1,c2:desc"');  -- set_table_property 
call set_table_property('tbl', 'segment_key', '"C1",c2:desc');
commit;
------------------------------------------------------------------
create table "Tab_$A%*" (a int);
select relname from pg_class where relname = 'Tab_$A%*';
insert into "Tab_$A%*" values (-1977);
select * from "Tab_$A%*";
```

<br />3.When creating a table, if there is no table with the same name and the semantics are correct, the table creation will return success. If there is a table with the same name without specifying the IF NOT EXISTS option, an exception is returned. If sql has 'IF NOT EXISTS', Hologres will print a notice, skip the table creation, and return success. The rules are as follows:

| condition       | has 'IF NOT EXISTS'                                          | not have 'IF NOT EXISTS'           |
| --------------- | ------------------------------------------------------------ | ---------------------------------- |
| table exists    | NOTICE:  relation "xx" already exists, skipping<br />SUCCEED | ERROR: relation is already exists. |
| table not exist | SUCCEED                                                      | SUCCEED                            |

4.If not using double quotes "", table names and column names can not have special characters. Table names and column names can only have characters a-z, A-Z, numbers and underscores (_), and  must start with a letter. Since table names and column names are not sensitive, A-Z will be regarded as lower case. Examples are as follows:
```sql
begin;
create table TABLE_one (a int not null);
call set_table_property('table_one', 'clustering_key', 'a');
commit;
insert into table_one values (12);
```

<br />5.The length of the table name does not exceed 64 bytes, and the bytes exceeded 64 bytes will be truncated.
<a name="T6eMx"></a>
## Example
create table example:
```sql
CREATE TABLE test (
 "id" bigint NOT NULL,
 "name" text NOT NULL,
 "age" bigint,
 "class" text NOT NULL,
PRIMARY KEY (id)
);
```


<a name="zRNaN"></a>
# Set table properties
In Hologres, set_table_property helps to organize and query data efficiently.
<a name="Kbrrq"></a>
## Introduction
```sql
call set_table_property('<table_name>', property, value);
```
Explanation:
> It should be noted that the call to set_table_property needs to be executed in the same transaction as create table.

the following syntax are supported:
```sql
call set_table_property('table_name', 'orientation', '[column | row]'); 
call set_table_property('table_name', 'clustering_key', '[columnName{:[desc|asc]} [,...]]'); 
call set_table_property('table_name', 'segment_key', '[columnName [,...]]');
call set_table_property('table_name', 'bitmap_columns', '[columnName [,...]]');
call set_table_property('table_name', 'dictionary_encoding_columns', '[columnName [,...]]');
call set_table_property('table_name', 'time_to_live_in_seconds', '<non_negative_literal>');
call set_table_property('table_name', 'distribution_key', '[columnName[,...]]');
```


<a name="wiqa5"></a>
## Parameters
<a name="lgLqi"></a>
### orientation
```sql
call set_table_property('tbl', 'orientation', '[column | row]');
```
Explanation:

- orientation：Specifies a table is row store or column store
- Column store is the default setting of orientation. Column store is more friendly to OLAP scenes, suitable for various complex queries, while row store is more friendly to kv scenes, suitable for primary key-based query and scan.

Example：
```sql
begin;
create table tbl (a int not null, b text not null);
call set_table_property('tbl', 'orientation', 'row');
commit;
```
<a name="JZ4pu"></a>
### clustering_key
```sql
call set_table_property('tbl', 'clustering_key', '[columnName{:[desc|asc]} [,...]]');
```
Explanation:

- clustering_key： Create a clustered index on the specified columns. Hologres will sort the data on the clustered index, and clustered index can speed up  range and filter queries on the index column.
- all columns of clustering_key must be not null
- clustering_key can add :desc or :asc after the columnName , and default is asc.
- clustering_key cant not contains float/double column.

Example：
```sql
begin;
create table tbl (a int not null, b text not null);
call set_table_property('tbl', 'clustering_key', 'a,b');
commit;
-------------------------------------------------------------
begin;
create table tbl (a int not null, b text not null);
call set_table_property('tbl', 'clustering_key', 'a:desc,b:asc');
commit;
```
<a name="hKXl0"></a>
### segment_key
```sql
call set_table_property('tbl', 'segment_key', '[columnName{:[desc|asc]} [,...]]');
```

- Specify some columns (eg: time columns) as the segment key. When the query filter condition contains segmented columns, the query can quickly find the storage locations in files by segment_key values.
- segment_key can only used by column store.
- All columns of segment_key must be not null.
- segment_key cant not contains float/double column.

Example：
```sql
begin;
create table tbl (a int not null, b text not null);
call set_table_property('tbl', 'segment_key', 'a,b');
commit;
-------------------------------------------------------------
begin;
create table tbl (a int not null, b time not null);
call set_table_property('tbl', 'segment_key', 'b:asc');
commit;
```
<a name="bPLFH"></a>
### bitmap_columns
```sql
call set_table_property('tbl', 'bitmap_columns', '[columnName [,...]]');
```
Explanation:

- bitmap_columns：create a bit code(Bitmap) for the columns. Bitmap can quickly filter the data in a segment, the columns, used to filter data is suggested to use bitmap.
- bitmap_columns can only used by column store.
- Bitmap  is suitable for unordered columns with few values. And each value is mapped to  a binary value.
- bitmap_columns can contain null。
- all text columns will be added to bitmap_columns by default
- Can be used in the transaction of table creation or separately

Example：
```sql
begin;
create table tbl (a int not null, b text not null);
call set_table_property('tbl', 'bitmap_columns', 'a,b');
commit;
```
<a name="pZ3sz"></a>
### dictionary_encoding_columns
```sql
call set_table_property('tbl', 'dictionary_encoding_columns', '[columnName [,...]]');
```
Explanation:

- Hologres builds a dictionary map for the value of the columns of dictionary_encoding_columns. Dictionary encoding can convert string comparisons to numeric comparisons to speed up queries such as group by and filter
- dictionary_encoding_columns can only used by column store.
- columns of dictionary_encoding_columns can contain null
- unordered columns with small cardinality are suitable for dictionary_encoding_columns, which can be compressed and save storage.
- all text columns will be added to dictionary_encoding_columns by default
- Can be used in the transaction of table creation or separately

Example：
```sql
begin;
create table tbl (a int not null, b text not null);
call set_table_property('tbl', 'dictionary_encoding_columns', 'a,b');
commit;
```
<a name="cyeSk"></a>
### time_to_live_in_seconds
```sql
call set_table_property('tbl', 'time_to_live_in_seconds', '<non_negative_literal>');
```
Explanation:

- time_to_live_in_seconds：The life time of the table, in seconds, it must be a non-negative numeric type, either integer or floating point.
- Can be used outside the transaction of table creation, to modify the life time of table 

Example:
```sql
begin;
create table tbl (a int not null, b text not null);
call set_table_property('tbl', 'time_to_live_in_seconds', '3.14159');
commit;
-------------------------------------------------------------
begin;
create table tbl (a int not null, b time not null);
call set_table_property('tbl', 'time_to_live_in_seconds', '86400');
commit;
```
<a name="rbhqk"></a>
### distribution_key
```sql
call set_table_property('table_name', 'distribution_key', '[columnName[,...]]');
```
Explanation:

- distribution_key specifies distribution strategy of a table.
- columnName can not have any white space. and it use comma(,) to separate multiple columns.
- distribution_key can contain null
- tables are randomly distributed by default. The data will be randomly distributed to each shard. If using distribution_key, the data will be shuffled to each shard according to the specified columns, the rows with same distribution_key will be shuffle to the same shard.  Hologres can filter out shards for scanning if query having filter condition of distribution_key. Hologres can use local join optimization, if join query joined by distribution_key.

Example：
```sql
begin;
create table tbl (a int not null, b text not null);
call set_table_property('tbl', 'distribution_key', 'a');
commit;

begin;
create table tbl (a int not null, b text not null);
call set_table_property('tbl', 'distribution_key', 'a,b');
commit;
```
<a name="KYSHt"></a>
# Add comments
Hologres supports adding comments to tables, external tables, columns, etc. Please refer to [PostgreSQL](https://www.postgresql.org/docs/11/sql-comment.html)。<br />Example：
```sql
-- add comment to table
COMMENT ON TABLE table_name IS 'my comments on table table_name.';

-- add comment to column
COMMENT ON COLUMN table_name.col1 IS 'This my first col1';

-- add comment to foreign table
COMMENT ON FOREIGN TABLE foreign_table IS ' comments on my foreign table';
```