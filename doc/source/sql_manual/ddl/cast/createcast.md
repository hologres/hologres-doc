# CREATE CAST

## Introduction

CREATE CAST: Define a cast between data types.

## Synopsis

In Hologres, the format of CREATE CAST is:

```sql
CREATE CAST (source_type AS target_type)
    WITH INOUT
    [ AS ASSIGNMENT | AS IMPLICIT ]
```

## Parameters

_**source_type**_: source data type name of the cast.

_**target_type**_: target data type name of the cast.

_**WITH INOUT**_:  Indicates that the cast is an I/O conversion cast, performed by invoking the output function of the source data type, and passing the resulting string to the input function of the target data type.

_**AS ASSIGNMENT**_: Indicates that the cast can be invoked implicitly in assignment contexts.

_**AS IMPLICIT**_: Indicates that the cast can be invoked implicitly in any context.

## Example

When comparing text and numeric value types in a filter, usually there is no type casts by default. However, with CREATE CAST, text and numeric value types can be compared against each other after creating a CAST. For example,

```sql
create table test_cast(id text);
insert into test_cast values(888);
select * from test_cast aa where id > 888;
CREATE CAST (text AS integer) WITH INOUT AS IMPLICIT;
select * from test_cast aa where id > 888;
```

For more information about CREATE CAST, please refer to [PostgreSQl](https://www.postgresql.org/docs/11/sql-createcast.html) official website.