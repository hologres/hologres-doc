# Update

## Introduction

UPDATE：update rows of a table.  It changes the values of the specified columns in all rows that satisfy the condition. Only the columns to be modified need be mentioned in the SET clause; columns not explicitly modified retain their previous values.

## Synopsis

```sql
UPDATE table [ * ] [ [ AS ] alias ]
    SET { column = { expression } |
          ( column [, ...] ) = ( { expression } [, ...] ) } [, ...]
    [ FROM from_list ]
    [ WHERE condition ]
```

## Parameters

_**table**_: The name of the table to update. Optionally, * can be specified after the table name to explicitly indicate that descendant tables are included.

_**alias**_：A substitute name for the target table. When an alias is provided, it completely hides the actual name of the table. For example, given UPDATE foo AS f, the remainder of the UPDATE statement must refer to this table as f not foo.

_**column**_: The name of a column in table.

_**expression**_：An expression to assign to the column. The expression can use the old values of this and other columns in the table.

_**from_list**_：A list of table expressions, allowing columns from other tables to appear in the WHERE condition and the update expressions.

 _**condition**_：An expression that returns a value of type boolean. Only rows for which this expression returns true will be updated.

## Examples

```sql
CREATE TABLE update_test (
  a TEXT primary key, 
  b INT not null, 
  c TEXT not null, 
  d TEXT);  

INSERT INTO update_test VALUES ('b1', 10, '', '');

UPDATE update_test SET b = b + 10 WHERE a = 'b1';
UPDATE update_test SET c = 'new_' || a, d = null WHERE b = 20;
UPDATE update_test SET (b,c,d) = (1, 'test_c', 'test_d'); 

CREATE TABLE tmp(a int);
INSERT INTO tmp VALUES (2);
UPDATE update_test SET b = tmp.a FROM tmp;
```

For more details about UPDATE, please go to official PostgresSQL Documentation [UPDATE](https://www.postgresql.org/docs/11/sql-update.html).
## Limitations

This version does not support updating columns that are part of shard key.

