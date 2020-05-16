# DROP CAST

## Introduction

DROP CAST: Remove a type cast defined previously.

_**Note**_:  to delete a type cast, you must own the source or the target data type.

## Synopsis 

In Hologres, the format of DROP CAST is:
```sql
DROP CAST [ IF EXISTS ] (source_type AS target_type) 
```
## Parameters

_**IF EXISTS**_: Do not throw an error if the cast does not exist. A notice is issued in this case.

_**source_type**_:  source data type name of the cast.

_**target_type**_: target data type name of the cast.

## Example

To delete a type cast from text to int:
```sql
DROP CAST if exists (text AS timestamptz);
DROP CAST if exists (text AS integer);
```
For more information about CREATE CAST, please refer to [PostgreSQL](https://www.postgresql.org/docs/11/sql-dropcast.html) official website.