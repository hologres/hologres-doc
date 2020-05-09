# DROP CAST

# Introduction
DROP CAST: Remove a type cast defined previously.<br />Note: to delete a type cast, you must own the source or the target data type.
<a name="U2bUj"></a>
# Synopsis<br />
In Hologres, the format of DROP CAST is:
```sql
DROP CAST [ IF EXISTS ] (source_type AS target_type) 
```
<a name="LhwbM"></a>
# Parameters
_**IF EXISTS: **_Do not throw an error if the cast does not exist. A notice is issued in this case.<br />_**source_type:**_ source data type name of the cast.<br />_**target_type: **_target data type name of the cast.<br />
<a name="Yyqw5"></a>
# Example<br />
To delete a type cast from text to int:
```sql
DROP CAST if exists (text AS timestamptz);
DROP CAST if exists (text AS integer);
```
For more information about CREATE CAST, please refer to [PostgreSQL](https://www.postgresql.org/docs/11/sql-dropcast.html) official website.