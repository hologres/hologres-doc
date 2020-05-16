# Insert

## Introduction

INSERT: Insert new rows into a table. One can insert one or more rows specified by value expressions, or zero or more rows resulting from a query.

## Synopsis

```sql
INSERT INTO table [( column [, ...] )]
   VALUES ( {expression}  [, ...] ) 
   [, ...] | query}
```

The target column names can be listed in any order. If no list of column names is given at all, the default is all the columns of the table in their declared order; or the first N column names, if there are only N columns supplied by the VALUES clause or query. The values supplied by the VALUES clause or query are associated with the explicit or implicit column list left-to-right.

Each column not present in the explicit or implicit column list will be filled with a default value, either its declared default value or null if there is none. If the expression for any column is not of the correct data type, automatic type conversion will be attempted.

## Parameters

_**table_name**_: The name (optionally schema-qualified) of an existing table.

_**alias**_: A substitute name for table_name. When an alias is provided, it completely hides the actual name of the table.

_**column_name**_: The name of a column in the table named by table_name. The column name can be qualified with a subfield name or array subscript, if needed. (Inserting into only some fields of a composite column leaves the other fields null.)

_**expression**_: An expression or value to assign to the corresponding column.

_**query**_: A query (SELECT statement) that supplies the rows to be inserted. Refer to the SELECT statement for a description of the syntax.

## Examples

In Hologres INSERT currently supports two ways to write data:

1.insert into values:

```sql
INSERT INTO rh_holo2mysqltest (cate_id, cate_name) VALUES
    (3, 'true'),
    (3, 'fale'),
    (3, 'trxxue'),
    (3, 'x'),
    (4, 'The Dinner Game');
```

2.insert into select:

```sql
insert into test2
select 2,'two';
```

