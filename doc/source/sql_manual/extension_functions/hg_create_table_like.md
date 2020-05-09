# HG_CREATE_TABLE_LIKE

# Introduction
Create a table based on a query result, including all columns returned by the query.
<a name="GfrrN"></a>
# Synopsis
```sql
CALL HG_CREATE_TABLE_LIKE ( table_name, query_sql [, partition_clause] )
```
<a name="LhwbM"></a>
# Parameters
**_table_name: _**The name of the new table which could belongs to some schema. The names can contain only alphanumeric characters or an underscore(_). The first character must be an alphabetic character. All alphabetic characters are treated as lower case because the table name is case insensitive.<br />_**query_sql: **_The sql query<br />_**partition_clause:**_ The clause which is used to create a partitioned table.
<a name="NPGVZ"></a>
# Example
```sql
CALL HG_CREATE_TABLE_LIKE ( 'my_table', 'select a, b from only_for_test' ); // Create a regular table

CALL HG_CREATE_TABLE_LIKE ( 'my_table', 'select a, b from only_for_test', 'partition by list (a)' );//Create an partitioned table
```

