# CREATE TABLE LIKE

create table like：creates a new table represents the result table of the SELECT query. It does not load any data with the command itself. i.e. it wont load the result table of the SELECT query into the newly-created  table.

## Regular Table

### Introduction

To create a regular table with CREATE TABLE LIKE in Hologres, the following example illustrates the usage:
```sql
CALL hg_create_table_like('table_name', 'select_query');
```
_**Note**_: Within the call to hg_create_table_like, the system will generate a schema represents the result table of the select_query, and use that schema to create a new table with the name "table_name". It will not insert any data into the new table. 

### Parameters

**_table_name_**: The new table's name.  It must not be for a Foreign Table; It must be string literal, which means it can not be strings returned from a function call or composed of other other string or name variables.

_**select_query**_ : A select query which could be against all tables (including Foreign Table). It also must be string literals, which means it can not be strings returned from a function call or composed of other other string or name variables.

### Examples

There are some examples of using "create table like" in Hologres:

1)  Create a new table with the same schema as source table.

```sql
CREATE TABLE src_table(a int, b text);
CALL hg_create_table_like('new_table', 'select * from src_table');
```

2）Create a new table according to a source table but add with extra columns.

```sql
CREATE TABLE test_table(a int, b text);

CALL hg_create_table_like('holo_table', 'select *, 1 as c, ''a'' as d from test_table');
```
## Partition Table

### Introduction

The command of "create table like" for partition tables:

```sql
CALL hg_create_table_like('table_name', 'select_query', 'partition_clause');
```
### Parameters

_**table_name：**_The new table's name.  It must not be for an Foreign Table; It must be string literal, which means it can not be strings returned from a function call or composed of other other string or name variables.

_**select_query：**_A select query which could be against all tables (including Foreign Table). It also must be string literals, which means it can not be strings returned from a function call or composed of other other string or name variables.

_**partition_clause：**_A partition clause following the the same grammar of creating a partition table.

### Example

```sql
CREATE TABLE src_table(a int, b text);
CALL hg_create_table_like('new_table', 'select *, 1 as c, ''a'' as d from src_table', 'partition by list(b)');

create table new_table_child1 partition of new_table for values in(1);

\d new_table

\d new_table_child1 
```

## Set Table Property

In Hologres, a **set_table_property **call can be used after the "create table like" command, to set more customized table properties for the newly-created table.

```sql
CREATE TABLE src_table(a int, b text);
BEGIN;
CALL hg_create_table_like('new_table', 'select *, 1 as c, ''a'' as d from src_table');
CALL set_table_property('new_table', 'distribution_key', 'b');
CALL set_table_property('new_table', 'orientation', 'column');
CALL set_table_property('new_table', 'bitmap_columns', 'b');
CALL set_table_property('new_table', 'dictionary_encoding_columns', 'b');
CALL set_table_property('new_table', 'time_to_live_in_seconds', '86400');
COMMIT;

\d new_table
```

see more details in **set_table_property**'s documentation.
### Limitation

There must be unique column names for the select query, otherwise an error about conflicting column names will be raised. e.g.
```sql
CALL hg_create_table_like('new_table', 'select *, 1 as c, ''a'' as c from src_table');
ERROR:  column "c" specified more than once
CONTEXT:  SQL statement "create table new_table (
"a"     integer,
"b"     text,
"c"     integer,
"c"     text
);"
PL/pgSQL function hg_create_table_like(text,text) line 22 at EXECUTE
```