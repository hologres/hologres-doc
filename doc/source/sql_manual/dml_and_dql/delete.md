# Delete

## Introduction

DELETE: deletes rows that satisfy the `WHERE` clause from the specified table. If the `WHERE` clause is absent, the effect is to delete all rows in the table. 

## Synopsis

```sql
DELETE FROM table_name [ * ] [ [ AS ] alias ]
    [ WHERE condition  ]
```

## Parameters

_**table_name**_: The name of the table to delete rows from.  Optionally, `*` can be specified after the table name to explicitly indicate that descendant tables are included.

_**alias**_：A substitute name for the target table. When an alias is provided, it completely hides the actual name of the table. For example, given `DELETE FROM foo AS f`, the remainder of the `DELETE` statement must refer to this table as `f` not `foo`.

_**condition**_：An expression that returns a value of type `boolean`. Only rows for which this expression returns `true` will be deleted.

## Examples

```sql
CREATE TABLE delete_test (
    id INT PRIMARY KEY,
    a INT,
    b text 
);

INSERT INTO delete_test VALUES 
(1, 10, 'a'),
(2, 30, 'b'),
(3, 50,  ''),
(4, 70, null);

DELETE FROM delete_test AS dt WHERE dt.a = 10;

DELETE FROM delete_test AS dt WHERE dt.b is null;

DELETE FROM delete_test AS dt WHERE dt.b='';
```

For more details about DELETE, please go to official PostgresSQL Documentation [DELETE](https://www.postgresql.org/docs/11/sql-delete.html).


